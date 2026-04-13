import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/assets/presentation/pages/assets_list_page.dart';
import '../../features/assets/presentation/pages/asset_detail_page.dart';
import '../../features/tickets/presentation/pages/ticket_list_page.dart';
import '../../features/tickets/presentation/pages/ticket_detail_page.dart';
import '../../features/tickets/presentation/pages/ticket_create_page.dart';
import '../../core/widgets/app_shell.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/assets',
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isInitial = authState.status == AuthStatus.initial;
      final isOnLogin = state.matchedLocation == '/login';

      if (isInitial) return null;
      if (!isAuthenticated && !isOnLogin) return '/login';
      if (isAuthenticated && isOnLogin) return '/assets';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/assets/:id', 
        builder: (context, state) => AssetDetailPage(
          assetId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/tickets/create',
        builder: (context, state) => CreateTicketPage(
          assetId: state.uri.queryParameters['assetId'] != null
              ? int.parse(state.uri.queryParameters['assetId']!)
              : null,
        ),
      ),
      GoRoute(
        path: '/tickets/:id',
        builder: (context, state) => TicketDetailPage(
          ticketId: int.parse(state.pathParameters['id']!),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/assets',
                builder: (context, state) => const AssetListPage(),
              ),
            ],
          ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: '/scanner',
          //       builder: (context, state) => const Scaffold(
          //         body: Center(child: Text('Scanner')),
          //       ),
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tickets',
                builder: (context, state) => const TicketListPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}