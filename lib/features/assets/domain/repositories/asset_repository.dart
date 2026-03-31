import 'package:itam_app/features/assets/domain/entities/asset.dart';

abstract class AssetRepository {
  Future<List<Asset>> getAssets();
  Future<List<Asset>> getAssetsByLocation(int locationId);
}