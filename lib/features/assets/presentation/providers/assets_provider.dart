import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/network/dio_client.dart';
import 'package:itam_app/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/domain/usecases/get_assets_usecase.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';

final assetRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioClientProvider);
  return AssetRepositoryImpl(dio);
});

final getAssetsUseCaseProvider = Provider((ref) {
  final repository = ref.watch(assetRepositoryProvider);
  return GetAssetsUseCase(repository);
});

class AssetsNotifier extends AsyncNotifier<List<Asset>> {
  @override
  Future<List<Asset>> build() async {
    final useCase = ref.watch(getAssetsUseCaseProvider);
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;

    if (user == null) return [];

    final isUser = user.role == 'USER';

    if (isUser && user.locationId != null) {
      return await useCase.getByLocation(user.locationId!);
    }

    return await useCase.call();
  }
}

final assetsProvider =
    AsyncNotifierProvider<AssetsNotifier, List<Asset>>(
  AssetsNotifier.new,
);