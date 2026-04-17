import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;
  final bool hasActiveFilters;
  final String hintText;

  const SearchFilterBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onFilterTap,
    required this.hasActiveFilters,
    this.hintText = 'Recherche...',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search_rounded),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              constraints: const BoxConstraints(maxHeight: 48),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: hasActiveFilters
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: hasActiveFilters
                    ? AppColors.primary
                    : AppColors.border.withValues(alpha: 0.5),
              ),
            ),
            child: Icon(
              Icons.tune_rounded,
              color: hasActiveFilters
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}