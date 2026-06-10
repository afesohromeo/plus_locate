# Bottom Navigation & Map View Completion — Plan

## Decisions (confirmed with user)

- **Tabs**: 3 — Map, Saved, Search. No Profile/Settings tab.
- **Search** tab → existing `decode` feature (Address/Plus Code lookup).
- **Saved** tab → existing `history` feature.
- **Settings** → deferred entirely for now (no entry point added). Language stays device-default.
- Routing restructured to **`StatefulShellRoute.indexedStack`** so each tab keeps its own navigation stack and the map isn't rebuilt on tab switch.

## Out of scope (separate future tasks)

- Building out full UI for History ("Saved Locations") and Decode ("Address Lookup") screens — currently `Center(child: Text(...))` stubs, per Stitch designs.
- Settings/Profile entry point.
- Cold-start geocoding timeout (unresolved, unrelated bug).

## Implementation Steps

### 1. New shared widget — `AppBottomNavBar`

- File: `lib/src/shared/components/app_bottom_nav_bar.dart`, exported via `components.dart`.
- `StatelessWidget` with `currentIndex: int` and `onTap: ValueChanged<int>`.
- 3 items, reusing existing l10n keys: `mapView` ("Map"), `saved` ("Saved"), `search` ("Search").
- Icons: `Icons.map_outlined` / `Icons.bookmark_outline` / `Icons.search`, filled variants for active state.
- Styling consistent with `FloatingSearchPill` (glass/blur bar via `BackdropFilter`, `customColors.surface` translucent background, `customColors.primary` for active tab indicator).

### 2. Route restructuring — `route_manager.dart`

- Wrap the `mapView`, `history`, `decode` `GoRoute`s inside a `StatefulShellRoute.indexedStack`:
  - 3 `StatefulShellBranch`es, one per route, each with its own nested `Navigator`.
  - `builder: (context, state, navigationShell) => ScaffoldWithNav(navigationShell: navigationShell)`.
- New small widget `ScaffoldWithNav` (in `lib/src/core/routing/` or `shared/components/`):
  - `body: navigationShell`
  - `bottomNavigationBar: AppBottomNavBar(currentIndex: navigationShell.currentIndex, onTap: navigationShell.goBranch)`
- `home`, `generate`, `settings` routes remain flat, outside the shell — unaffected.
- `initialLocation` stays `/map-view`.

### 3. Map View layout fix

- `AppBottomNavBar` will occupy ~70–80px at the bottom of the screen.
- In `map_view_page.dart`, the `Positioned` wrapper around `PlusCodeDetailCard` currently uses `bottom: 0` — change to sit above the nav bar (e.g. `bottom: <navBarHeight>` or wrap with matching `SizedBox`/padding) so it doesn't overlap.
- `ResponsiveScaffoldWrapper` props for `MapViewPage`, `HistoryPage`, `DecodePage` keep `showBottomNav: false` (default) — the shell-level `Scaffold` (via `ScaffoldWithNav`) provides the single bottom nav, avoiding nested bottom navs.

### 4. History & Decode pages

- No content changes — they become reachable via the Saved/Search tabs at their existing routes (`/history`, `/decode`). Full UI build-out is a separate task.

## Verification

- Run the app: confirm Map / Saved / Search tabs switch correctly and each branch preserves its own navigation state.
- Confirm the Map View detail card no longer overlaps the bottom nav bar.
- Confirm `home`, `generate`, `settings` routes are still reachable via `context.go(...)` (no regression from the shell restructure).