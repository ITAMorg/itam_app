import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

class TicketAssigneeSection extends StatelessWidget {
  final Asset? selectedAsset;
  final String? title;
  final String? description;
  final String? selectedPriority;
  final ValueChanged<String> onPriorityChanged;

  const TicketAssigneeSection({
    super.key,
    required this.selectedAsset,
    required this.title,
    required this.description,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPrioritySection(context),
          const SizedBox(height: 16),
          _buildRecap(context),
        ],
      ),
    );
  }

  Widget _buildPrioritySection(BuildContext context) {
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
              'PRIORITÉ',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          _buildPriorityTile(
            context,
            label: 'Haute',
            sublabel: 'Bloquant',
            value: 'HIGH',
            color: Colors.red,
          ),
          _buildPriorityTile(
            context,
            label: 'Moyenne',
            sublabel: 'Gennant',
            value: 'MEDIUM',
            color: Colors.orange,
          ),
          _buildPriorityTile(
            context,
            label: 'Basse',
            sublabel: 'Non bloquant',
            value: 'LOW',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityTile(
    BuildContext context, {
    required String label,
    required String sublabel,
    required String value,
    required Color color,
  }) {
    final isSelected = selectedPriority == value;

    return GestureDetector(
      onTap: () => onPriorityChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.background.withValues(alpha: 0.6),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                sublabel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
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

  Widget _buildRecap(BuildContext context) {
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
              'RÉCAPITULATIF',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          _buildRecapRow(context, 'Matériel', selectedAsset?.name ?? '-'),
          _buildRecapRow(context, 'Titre', title ?? '-'),
          _buildRecapRow(context, 'Description', description ?? '-'),
          _buildRecapPriorityRow(context),
        ],
      ),
    );
  }

  Widget _buildRecapRow(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.background.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecapPriorityRow(BuildContext context) {
    Color color;
    String label;

    switch (selectedPriority) {
      case 'HIGH':
        color = Colors.red;
        label = 'Haute';
        break;
      case 'MEDIUM':
        color = Colors.orange;
        label = 'Moyenne';
        break;
      case 'LOW':
        color = Colors.blue;
        label = 'Basse';
        break;
      default:
        color = AppColors.textSecondary;
        label = '-';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.background.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              'Priorité',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}