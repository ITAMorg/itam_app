import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/foundation.dart';

part 'auth_remote_datasource.g.dart';

const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';

class TechnicianModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  const TechnicianModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory TechnicianModel.fromJson(Map<String, dynamic> json) =>
      TechnicianModel(
        id: json['id'] as int,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
      );
}

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<List<TechnicianModel>> getUsersByRole(String role);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  const AuthRemoteDataSourceImpl(this._dio, this._storage);

  @override
  Future<List<TechnicianModel>> getUsersByRole(String role) async {
    final response = await _dio.get('/users/role/$role');
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((e) => TechnicianModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );

      final accessToken = response.data['accessToken'] as String;
      final refreshToken = response.data['refreshToken'] as String;
      final userData = response.data['user'] as Map<String, dynamic>;

      await _storage.write(key: _accessTokenKey, value: accessToken);
      await _storage.write(key: _refreshTokenKey, value: refreshToken);

      return UserModel.fromJson(userData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw const UnauthorizedFailure();
      if (e.type == DioExceptionType.connectionError) throw const NetworkFailure();
      throw ServerFailure(e.response?.data?['message'] ?? 'Erreur serveur');
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } finally {
      await _storage.deleteAll();
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final token = await _storage.read(key: _accessTokenKey);
      if (token == null) return null;

      final jwt = JWT.decode(token);
      final payload = jwt.payload as Map<String, dynamic>;

      return UserModel(
        id: (payload['userId'] as num).toInt(),
        email: payload['email'] as String,
        role: payload['role'] as String,
        firstName: '',
        lastName: '',
        locationId: payload['locationId'] != null
            ? (payload['locationId'] as num).toInt()
            : null,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('getCurrentUser error: $e');
      }
      return null;
    }
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(
    ref.watch(dioClientProvider),
    const FlutterSecureStorage(),
  );
}