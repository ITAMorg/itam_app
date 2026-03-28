import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constants/api_constants.dart';

part 'dio_client.g.dart';

const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';

@riverpod
Dio dioClient(Ref ref) {
  final storage = const FlutterSecureStorage();
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read(key: _accessTokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshed = await _tryRefreshToken(dio, storage);
          if (refreshed) {
            final token = await storage.read(key: _accessTokenKey);
            error.requestOptions.headers['Authorization'] = 'Bearer $token';
            final response = await dio.fetch(error.requestOptions);
            return handler.resolve(response);
          }
        }
        handler.next(error);
      },
    ),
  );

  return dio;
}

Future<bool> _tryRefreshToken(Dio dio, FlutterSecureStorage storage) async {
  try {
    final refreshToken = await storage.read(key: _refreshTokenKey);
    if (refreshToken == null) return false;

    final response = await dio.post(
      ApiConstants.refresh,
      data: {'refreshToken': refreshToken},
    );

    final accessToken = response.data['accessToken'] as String?;
    final newRefreshToken = response.data['refreshToken'] as String?;

    if (accessToken == null) return false;

    await storage.write(key: _accessTokenKey, value: accessToken);
    if (newRefreshToken != null) {
      await storage.write(key: _refreshTokenKey, value: newRefreshToken);
    }

    return true;
  } catch (_) {
    await storage.deleteAll();
    return false;
  }
}