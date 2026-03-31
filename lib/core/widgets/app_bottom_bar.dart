import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.primary,
            letterSpacing: 0,
          ),
      unselectedLabelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 0,
          ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_rounded),
          label: 'Parc',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner_rounded),
          label: 'Scanner',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          label: 'Ticket',
        ),
      ],
    );
  }
}