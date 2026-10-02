import 'package:flutter/material.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:go_router/go_router.dart';

class RouteManager {
  RouteManager() {
    router = createRouter();
  }

  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router;
  GoRouter createRouter() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: mapViewPage,
      redirect: (context, state) async {
        final seen = await SecureStorageHelper.hasSeenOnboarding();
        if (!seen && state.matchedLocation != onboardingPage) {
          return onboardingPage;
        }
        return null;
      },
      routes: [...shellSubRoutes],
    );
  }

  static List<RouteBase> get shellSubRoutes {
    return [
      GoRoute(
        name: onboardingRouteName,
        path: onboardingPage,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const OnboardingPage(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNav(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: mapViewRouteName,
                path: mapViewPage,
                pageBuilder: (context, state) {
                  return NoTransitionPage<void>(
                    key: state.pageKey,
                    child: const MapViewPage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: historyRouteName,
                path: historyPage,
                pageBuilder: (context, state) {
                  return NoTransitionPage<void>(
                    key: state.pageKey,
                    child: const HistoryPage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: searchRouteName,
                path: searchPage,
                pageBuilder: (context, state) {
                  return NoTransitionPage<void>(
                    key: state.pageKey,
                    child: const SearchPage(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ];
  }

  CustomTransitionPage slideTransition(
    GoRouterState state,
    Widget child,
    Offset begin,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        const end = Offset.zero;
        const curve = Curves.easeIn;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
