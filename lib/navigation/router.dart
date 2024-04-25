import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/navigation/routes.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/view/components/custom_nav_bar.dart';

import 'package:home_tasks_app/view/groupes_page/groupes_page_view.dart';
import 'package:home_tasks_app/view/settings_page/settings_page_view.dart';

import '../repositories/auth_repository.dart';
import '../view/authorization_page/auth_view.dart';
import '../view/group_page/group_page_view.dart';
import '../view/home_page/home_page_view.dart';

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
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: "groupes",
                  builder: (context, state) => const GroupesPage(),
                  routes: [
                    GoRoute(
                      path: "group",
                      builder: (context, state) => GroupEditor(
                          group: state.extra is GroupOfRooms
                              ? state.extra as GroupOfRooms
                              : null),
                    )
                  ],
                ),
              ],
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
                builder: (context, state) => const SettingsPage()),
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
    /*GoRoute(
      path: AppRoute.test.path,
      name: AppRoute.test.name,
      builder: (context, state) => const HomePage(),
    ),*/
  ],
);
