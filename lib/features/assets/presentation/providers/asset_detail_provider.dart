import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:itam_app/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/domain/usecases/get_asset_by_id_usecase.dart';

part 'asset_detail_provider.g.dart';

final getAssetByIdUseCaseProvider = Provider((ref) {
  final repository = ref.watch(assetRepositoryProvider);
  return GetAssetByIdUsecase(repository);
});

@riverpod
class AssetDetail extends _$AssetDetail {
  @override
  Future<Asset> build(String assetId) async {
    final useCase = ref.watch(getAssetByIdUseCaseProvider);
    return await useCase.execute(assetId);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> updateLocation(int? locationId) async {
    final repository = ref.read(assetRepositoryProvider);
    await repository.updateLocation(assetId, locationId);
    ref.invalidateSelf();
    await future;
  }
}