import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/domain/usecases/get_asset_by_id_usecase.dart';

final getAssetByIdUseCaseProvider = Provider((ref) {
  final repository = ref.watch(assetRepositoryProvider);
  return GetAssetByIdUsecase(repository);
});

final assetDetailProvider = FutureProvider.family<Asset, String>((ref, id) async {
  final useCase = ref.watch(getAssetByIdUseCaseProvider);
  return await useCase.execute(id);
});