import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';

class PriorityChip extends StatelessWidget {
  final String label;
  final Color color;

  const PriorityChip({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelChip.copyWith(color: Colors.white),
      ),
    );
  }
}