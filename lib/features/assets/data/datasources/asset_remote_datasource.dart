import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../models/asset_model.dart';

part 'asset_remote_datasource.g.dart';

abstract class AssetRemoteDataSource {
  Future<List<AssetModel>> getAssets();
  Future<List<AssetModel>> getAssetsByLocation(int locationId);
  Future<AssetModel> getAssetById(String id);
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final Dio _dio;

  const AssetRemoteDataSourceImpl(this._dio);

  @override
  Future<List<AssetModel>> getAssets() async {
    final response = await _dio.get('/assets');
    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => AssetModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<AssetModel>> getAssetsByLocation(int locationId) async {
    final response = await _dio.get('/assets/location/$locationId');
    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => AssetModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<AssetModel> getAssetById(String id) async {
    final response = await _dio.get('/assets/$id');
    return AssetModel.fromJson(response.data as Map<String, dynamic>);
  }
}

@riverpod
AssetRemoteDataSource assetRemoteDataSource(Ref ref) {
  return AssetRemoteDataSourceImpl(ref.watch(dioClientProvider));
}