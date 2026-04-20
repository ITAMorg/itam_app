import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

class AssetInfoSection extends StatelessWidget {
  final Asset asset;

  const AssetInfoSection({super.key, required this.asset});

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
            child: Text(
              'INFORMATIONS TECHNIQUES',
              style: AppTextStyles.titleSection
            ),
          ),
          const SizedBox(height: 8),
          // Lignes
          _Divider(),
          _InfoRow(label: 'Marque', value: asset.brand),
          _Divider(),
          _InfoRow(label: 'Modèle', value: asset.model),
          _Divider(),
          _InfoRow(label: 'N° de série', value: asset.serialNumber.isEmpty ? null : asset.serialNumber),
          _Divider(),
          _InfoRow(label: 'Fournisseur', value: asset.supplier?.name),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.labelSection,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? '—',
              style: AppTextStyles.bodySection.copyWith(
                    color: value != null
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight: value != null ? FontWeight.w700 : FontWeight.w400,
              ),
              textAlign: TextAlign.end,
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