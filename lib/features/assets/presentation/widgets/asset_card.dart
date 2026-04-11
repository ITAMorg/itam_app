import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/utils/color_resolver.dart';
import 'package:itam_app/core/utils/icon_resolver.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

class AssetCard extends StatelessWidget {
  final Asset asset;

  const AssetCard({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
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

    final assetColor = ColorResolver.resolve(asset.assetType.colorKey);
    final iconData = IconResolver.resolve(asset.assetType.iconKey);

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final horizontalPadding = isDesktop ? 32.0 : 16.0;

    return GestureDetector(
      onTap: () => context.go('/assets/${asset.id}'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: assetColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: assetColor),
                ),
                child: Icon(iconData, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      asset.location?.name ?? 'Non assigné',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      statusLabel,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: statusColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}