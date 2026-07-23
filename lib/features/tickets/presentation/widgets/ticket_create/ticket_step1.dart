import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/presentation/providers/assets_provider.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';

class TicketAssetSection extends ConsumerStatefulWidget {
  final int? preselectedAssetId;
  final ValueChanged<Asset> onAssetSelected;

  const TicketAssetSection({
    super.key,
    this.preselectedAssetId,
    required this.onAssetSelected,
  });

  @override
  ConsumerState<TicketAssetSection> createState() => _TicketAssetSectionState();
}

class _TicketAssetSectionState extends ConsumerState<TicketAssetSection> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Asset? _selectedAsset;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assetsAsync = ref.watch(assetsProvider);
    final authState = ref.watch(authNotifierProvider);
    final isUser = authState.user?.role == 'USER';
    final listLabel = isUser ? 'Mes actifs' : 'Tous les actifs';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bouton QR (désactivé)
          _buildQrButton(),
          const SizedBox(height: 24),
          // Séparateur "ou choisir dans la liste"
          _buildDivider(),
          const SizedBox(height: 20),
          // Barre de recherche
          _buildSearchBar(),
          const SizedBox(height: 16),
          // Liste des assets
          assetsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur : $e')),
            data: (assets) {
              final filtered = assets.where((a) {
                final q = _searchQuery.toLowerCase();
                return a.name.toLowerCase().contains(q) ||
                    (a.brand?.toLowerCase().contains(q) ?? false) ||
                    (a.serialNumber?.toLowerCase().contains(q) ?? false);
              }).toList();

              return _buildAssetList(filtered, listLabel);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQrButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.4),
          width: 1.5,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.circular(14),
        color: AppColors.primary.withValues(alpha: 0.05),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.qr_code_scanner_rounded,
              color: AppColors.primary.withValues(alpha: 0.5),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scanner le QR code',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                'Identification automatique',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.surface, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'ou choisir dans la liste',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.surface, thickness: 1)),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'Recherche...',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildAssetList(List<Asset> assets, String label) {
    if (assets.isEmpty) {
      return Center(
        child: Text(
          'Aucun actif trouvé',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          ...assets.map((asset) => _buildAssetTile(asset)),
        ],
      ),
    );
  }

  Widget _buildAssetTile(Asset asset) {
    final isSelected = _selectedAsset?.id == asset.id;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedAsset = asset);
        widget.onAssetSelected(asset);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.background.withValues(alpha: 0.6), width: 1),
          ),
        ),
        child: Row(
          children: [
            // Icône type
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.devices_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Nom + type/localisation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '${asset.assetType.name}${asset.location != null ? ' · ${asset.location!.name}' : ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            // Radio
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}