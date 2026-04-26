import 'package:flutter/material.dart';
import 'package:plus_locate/src/core/core.dart';
import 'package:plus_locate/src/features/features.dart';
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
      routes: [...shellSubRoutes],
    );
  }

  static List<RouteBase> get shellSubRoutes {
    return [
      GoRoute(
        name: homeRouteName,
        path: homePage,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const HomePage(),
          );
        },
      ),
      GoRoute(
        name: generateRouteName,
        path: generatePage,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const GeneratePage(),
          );
        },
      ),
      GoRoute(
        name: decodeRouteName,
        path: decodePage,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const DecodePage(),
          );
        },
      ),
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
      GoRoute(
        name: settingsRouteName,
        path: settingsPage,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const SettingsPage(),
          );
        },
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
