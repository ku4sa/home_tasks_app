import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/navigation/routes.dart';
import 'package:home_tasks_app/view/components/custom_nav_bar.dart';

import '../repositories/auth_repository.dart';
import '../view/authorization-page/auth_view.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoute.auth.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => NavigationPage(
        key: const GlobalObjectKey('NAvigationPageKey'),
        navigationShell: navigationShell,
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: AppRoute.home.path,
          routes: [
            GoRoute(
              path: AppRoute.home.path,
              builder: (context, state) => const Scaffold(
                body: Text("Home"),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.plans.path,
              builder: (context, state) => const Scaffold(
                body: Text("Plans"),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.settings.path,
              builder: (context, state) => const Scaffold(
                body: Text("Settings"),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.auth.path,
      name: AppRoute.auth.name,
      builder: (context, state) => const AuthorizationPage(),
      redirect: (context, state) async {
        final isLoggedIn =
            GetIt.instance<AuthorizationRepository>().isUserAuthorized();
        if (isLoggedIn && state.path == AppRoute.auth.path) {
          return AppRoute.home.path;
        }

        return null;
      },
    ),
  ],
);
