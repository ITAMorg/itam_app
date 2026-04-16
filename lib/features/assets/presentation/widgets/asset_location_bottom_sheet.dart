import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/presentation/providers/asset_detail_provider.dart';
import 'package:itam_app/features/locations/presentation/providers/locations_provider.dart';

class AssetLocationBottomSheet extends ConsumerStatefulWidget {
  final String assetId;
  final int? currentLocationId;

  const AssetLocationBottomSheet({
    super.key,
    required this.assetId,
    this.currentLocationId,
  });

  @override
  ConsumerState<AssetLocationBottomSheet> createState() =>
      _AssetLocationBottomSheetState();
}

class _AssetLocationBottomSheetState
    extends ConsumerState<AssetLocationBottomSheet> {
  int? _selectedLocationId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedLocationId = widget.currentLocationId;
  }

  @override
  Widget build(BuildContext context) {
    final locationsAsync = ref.watch(locationsProvider);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Affecter un lieu',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          locationsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Erreur : $e'),
            data: (locations) => Column(
              children: [
                // Option "Aucun lieu"
                _LocationTile(
                  label: 'Aucun lieu',
                  subtitle: 'Retirer l\'affectation',
                  isSelected: _selectedLocationId == null,
                  onTap: () => setState(() => _selectedLocationId = null),
                ),
                const SizedBox(height: 6),
                ...locations.map(
                  (loc) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _LocationTile(
                      label: loc.name,
                      subtitle: '${loc.building} — Étage ${loc.floor}',
                      isSelected: _selectedLocationId == loc.id,
                      onTap: () =>
                          setState(() => _selectedLocationId = loc.id),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isLoading ? null : _save,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Confirmer'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(assetDetailProvider(widget.assetId).notifier)
          .updateLocation(_selectedLocationId);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

class _LocationTile extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _LocationTile({
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.6)
                : AppColors.border.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_rounded, color: AppColors.primary, size: 18),
          ],
        ),
      ),
    );
  }
}