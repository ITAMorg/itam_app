import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_location_bottom_sheet.dart';

class AssetAffectationSection extends StatelessWidget {
  final Asset asset;
  final bool canEdit; // true si ADMIN ou TECHNICIAN

  const AssetAffectationSection({
    super.key,
    required this.asset,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'AFFECTATION',
                    style: AppTextStyles.titleSection,
                  ),
                ),
                if (canEdit)
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (_) => AssetLocationBottomSheet(
                          assetId: asset.id,
                          currentLocationId: asset.location?.id,
                          ),
                        );
                      },
                    child: const Icon(
                      Icons.edit_rounded,
                      color: AppColors.textSecondary,
                      size: 16,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _Divider(),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary,
                    ),
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: AppColors.textPrimary,
                    size: 27,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  asset.location?.name ?? 'Non assigné',
                  style: AppTextStyles.bodySection.copyWith(
                        color: asset.location != null
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.border.withValues(alpha: 0.15),
    );
  }
}