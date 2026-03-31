import 'package:dio/dio.dart';
import 'package:itam_app/features/assets/data/models/asset_model.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  final Dio _dio;

  AssetRepositoryImpl(this._dio);

  @override
  Future<List<Asset>> getAssets() async {
    final response = await _dio.get('/assets');
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => AssetModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<List<Asset>> getAssetsByLocation(int locationId) async {
    final response = await _dio.get('/assets/location/$locationId');
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => AssetModel.fromJson(json).toEntity())
        .toList();
  }
}