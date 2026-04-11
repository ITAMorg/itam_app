import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/presentation/providers/assets_provider.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_card.dart';

class AssetListPage extends ConsumerStatefulWidget {
  const AssetListPage({super.key});

  @override
  ConsumerState<AssetListPage> createState() => _AssetListPageState();
}

class _AssetListPageState extends ConsumerState<AssetListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assetsAsync = ref.watch(assetsProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final horizontalPadding = isDesktop ? 32.0 : 16.0;

    return Column(
      children: [
        // Barre de recherche
        Padding(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding, 16, horizontalPadding, 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) =>
                      setState(() => _searchQuery = value.toLowerCase()),
                  decoration: const InputDecoration(
                    hintText: 'Recherche...',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.border.withValues(alpha: 0.5),
                  ),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        // Liste
        Expanded(
          child: assetsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text(
                'Erreur : $e',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            data: (assets) {
              final filtered = assets.where((a) {
                return a.name.toLowerCase().contains(_searchQuery) ||
                    (a.location?.name ?? '').toLowerCase().contains(_searchQuery) || // ← changement ici
                    a.assetType.name.toLowerCase().contains(_searchQuery);
              }).toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Text(
                    'Aucun asset trouvé',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 8,
                ),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    AssetCard(asset: filtered[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}