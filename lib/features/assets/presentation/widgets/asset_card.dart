import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/utils/color_resolver.dart';
import 'package:itam_app/core/utils/icon_resolver.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

class AssetCard extends StatelessWidget {
  final Asset asset;
  final VoidCallback? onTap;

   const AssetCard({super.key, required this.asset, this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColors = Theme.of(context)
        .extension<AssetStatusThemeExtension>()!
        .statusColors;

    final statusColor = switch (asset.status) {
      AssetStatus.inService => statusColors.inService,
      AssetStatus.broken => statusColors.broken,
      AssetStatus.maintenance => statusColors.maintenance,
      AssetStatus.inStock => statusColors.inStock,
    };

    final assetColor = ColorResolver.resolve(asset.assetType.colorKey);
    final iconData = IconResolver.resolve(asset.assetType.iconKey);

    return GestureDetector(
      onTap: onTap ?? () => context.push('/assets/${asset.id}'),
      child: Stack(
        children: [
          Container(
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
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: assetColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: assetColor),
                  ),
                  child: Icon(iconData, color: Colors.white, size: 27),
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
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: statusColor,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),  
            ),
          ),
        ],
      ),
    );
  }
}