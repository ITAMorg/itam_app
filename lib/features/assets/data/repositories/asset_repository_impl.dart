import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/asset.dart';
import '../../domain/repositories/asset_repository.dart';
import '../datasources/asset_remote_datasource.dart';
import '../models/asset_model.dart';

part 'asset_repository_impl.g.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetRemoteDataSource _datasource;

  const AssetRepositoryImpl(this._datasource);

  @override
  Future<List<Asset>> getAssets() async {
    final models = await _datasource.getAssets();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Asset>> getAssetsByLocation(int locationId) async {
    final models = await _datasource.getAssetsByLocation(locationId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Asset> getAssetById(String id) async {
    final model = await _datasource.getAssetById(id);
    return model.toEntity();
  }
}

@riverpod
AssetRepository assetRepository(Ref ref) {
  return AssetRepositoryImpl(ref.watch(assetRemoteDataSourceProvider));
}