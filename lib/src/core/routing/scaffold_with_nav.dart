import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_locate/plus_locate.dart';

/// Hosts the [StatefulShellRoute.indexedStack] body and the persistent
/// [AppBottomNavBar] shared by the Map, Saved and Search tabs.
class ScaffoldWithNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNav({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}