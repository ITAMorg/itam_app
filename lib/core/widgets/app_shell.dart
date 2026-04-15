import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/widgets/app_bottom_bar.dart';
import 'package:itam_app/core/widgets/app_top_bar.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: navigationShell,
      bottomNavigationBar: AppBottomBar(
        currentIndex: navigationShell.currentIndex == 1 
            ? 2  // branch 1 (tickets) → onglet 2
            : navigationShell.currentIndex, // branch 0 (assets) → onglet 0
        onTap: (index) {
          if (index == 1) {
            context.push('/scanner');
            return;
          }
          final branchIndex = index > 1 ? index - 1 : index;
          navigationShell.goBranch(
            branchIndex,
            initialLocation: branchIndex == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}