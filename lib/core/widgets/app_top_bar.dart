import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';

class AppTopBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Image.asset(
            'assets/icons/itam_logo_small.png',
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 8),
          Text(
            'ITAM',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondary),
          onPressed: () async {
            await ref.read(authNotifierProvider.notifier).logout();
          },
        ),
      ],
    );
  }
}