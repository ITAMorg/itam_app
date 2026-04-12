import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';

class AssetHistorySection extends StatelessWidget {
  const AssetHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implémenter GET /assets/:id/tickets
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.history_rounded,
            color: AppColors.textSecondary.withValues(alpha: 0.4),
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            'Historique des tickets',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary.withValues(alpha: 0.4),
                ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textSecondary.withValues(alpha: 0.4),
            size: 20,
          ),
        ],
      ),
    );
  }
}