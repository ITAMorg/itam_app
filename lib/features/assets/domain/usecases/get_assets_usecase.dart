import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/domain/repositories/asset_repository.dart';

class GetAssetsUseCase {
  final AssetRepository _repository;

  GetAssetsUseCase(this._repository);

  Future<List<Asset>> call() async {
    return await _repository.getAssets();
  }
}