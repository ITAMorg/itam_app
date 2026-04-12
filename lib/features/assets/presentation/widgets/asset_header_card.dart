import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/utils/color_resolver.dart';
import 'package:itam_app/core/utils/icon_resolver.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

class AssetHeaderCard extends StatelessWidget {
  final Asset asset;

  const AssetHeaderCard({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    final assetColor = ColorResolver.resolve(asset.assetType.colorKey);
    final iconData = IconResolver.resolve(asset.assetType.iconKey);

    final statusColors = Theme.of(context)
        .extension<AssetStatusThemeExtension>()!
        .statusColors;

    final statusColor = switch (asset.status) {
      AssetStatus.inService => statusColors.inService,
      AssetStatus.broken => statusColors.broken,
      AssetStatus.inStock => statusColors.inStock,
    };

    final statusLabel = switch (asset.status) {
      AssetStatus.inService => 'En service',
      AssetStatus.broken => 'En panne',
      AssetStatus.inStock => 'En stock',
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icône + nom + QR code
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icône type
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: assetColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: assetColor),
                ),
                child: Icon(iconData, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              // Nom + type + location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      asset.assetType.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      asset.location?.name ?? 'Non assigné',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              // QR code placeholder
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
                ),
                child: const Icon(
                  Icons.qr_code_rounded,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Badge statut
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  statusLabel,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: statusColor,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Dates achat + garantie
          Row(
            children: [
              Expanded(
                child: _DateCard(
                  label: 'ACHAT',
                  date: asset.purchaseDate,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DateCard(
                  label: 'GARANTIE',
                  date: asset.warrantyEnd,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String label;
  final DateTime? date;

  const _DateCard({required this.label, this.date});

  @override
  Widget build(BuildContext context) {
    final formatted = date != null
        ? '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}'
        : '—';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            formatted,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}