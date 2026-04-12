import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/theme/app_theme.dart';

class DetailTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DetailTopBar({
    super.key,
    required this.title,
    this.onEdit,
    this.onDelete,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
            size: 20,
          ),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        if (onEdit != null)
          GestureDetector(
            onTap: onEdit,
            child: Container(
              margin: const EdgeInsets.all(8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_rounded,
                color: Colors.blue,
                size: 18,
              ),
            ),
          ),
        if (onDelete != null)
          GestureDetector(
            onTap: onDelete,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }
}