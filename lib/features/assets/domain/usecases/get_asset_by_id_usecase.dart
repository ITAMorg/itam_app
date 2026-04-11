import '../entities/asset.dart';
import '../repositories/asset_repository.dart';

class GetAssetByIdUsecase {
  final AssetRepository _repository;

  const GetAssetByIdUsecase(this._repository);

  Future<Asset> execute(String id) async {
    if (id.isEmpty) throw Exception('ID asset invalide');
    return _repository.getAssetById(id);
  }
}