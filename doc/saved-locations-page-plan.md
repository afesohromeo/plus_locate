# Saved Locations (History) Page — Plan

## Scope

Replace the `HistoryPage` stub with a functional UI bound to the **already-implemented** `HistoryBloc` / `SavedCodesRepository` (Hive-backed, CRUD + search all working). Mostly UI-only, plus one small `MapViewBloc` addition to support "tap to view on map".

Adapted from the Stitch "Saved Locations" screen, simplified to match the actual `SavedCode` model (`id`, `globalCode`, `localCode`, `latitude`, `longitude`, `label`, `locality`, `savedAt`):

- **Dropped** (not in data model, would be premature): folder/category organization, favorites tagging, "Organize"/"New Save" header buttons, photo/map thumbnails per card.
- **Kept**: searchable list of cards, plus-code chip, locality + saved date, per-item actions (view on map, copy, share, delete), empty state.

## `HistoryPage` structure

- `ResponsiveScaffoldWrapper` — `hasAppbar: true`, `title: Text(l10n.saved)`.
- `BlocBuilder<HistoryBloc, HistoryState>`:
  - Top: `SearchInputField` → `HistoryEvent.searchCodes(query)`; clearing the field re-dispatches `fetchSavedCodes()`.
  - `historyStatus == loading` → `LoadingWidget`.
  - `historyStatus == failure` → `ErrorrWidget` (existing shared widget) with retry → `fetchSavedCodes()`.
  - `savedCodes.isEmpty` → `EmptyWidget` (`l10n.noData`, retry = `fetchSavedCodes()`).
  - else → `ListView.builder` of `SavedLocationCard`.
- `BlocListener<HistoryBloc, HistoryState>` for `historyActionStatus` / `flowStep == deletingItem` → success/failure dialog via `DialogUtils`, then `resetFlowStep()` (mirrors the existing pattern in `MapViewPage` for save actions).

## New widget: `SavedLocationCard`

Location: `lib/src/features/history/components/saved_location_card.dart`

- Rounded surface card (`customColors.surface`, rounded ~24px) per "Digital Beacon" styling.
- Leading: placeholder icon tile (`Icons.location_on`, `customColors.primary`) — no map thumbnail (no image data available).
- Title: `code.displayTitle` (label, falling back to `globalCode`).
- Plus-code chip: `code.globalCode` in `primary`-tinted pill.
- Subtitle: `code.locality ?? '---'`.
- Trailing meta: formatted `savedAt` via existing `formatDate()` helper (no new date/time package).
- Whole card is tappable when `code.hasCoordinates` → "view on map" (see below).
- Actions row: Copy (`actionCopy`, clipboard + `msgCodeCopied`), Share (`actionShare`, `Share.share` using `shareLocationText` with `locality` as the address), Delete (`actionDelete`).

## Tap to view on Map (new)

**`mapViewPage` is a route inside the `StatefulShellRoute`**, so a plain `context.goNamed(mapViewRouteName)` from `HistoryPage` resolves to that branch and go_router switches the shell's active tab automatically — no `navigationShell` plumbing required.

To center the map and populate the detail card on the saved location:

1. **`MapViewBloc`**: add a new event `focusOnLocation({required double latitude, required double longitude, PlusCode? plusCode, LocationResult? locationResult})`.
   - Handler sets `currentLatitude/Longitude`, `selectedPlusCode`, `locationResult`, `geocodeStatus = success`, and bumps a new `int focusToken` field in `MapViewState` (incremented each call) — used as a one-shot signal distinct from map-tap updates.
2. **`MapViewState`**: add `@Default(0) int focusToken`.
3. **`MapViewPage`**: add a `BlocListener<MapViewBloc, MapViewState>` with `listenWhen: (p, c) => p.focusToken != c.focusToken`, which animates the `GoogleMapController` camera to `LatLng(currentLatitude, currentLongitude)`.
4. **`SavedLocationCard`** `onTap`:
   ```dart
   context.read<MapViewBloc>().add(MapViewEvent.focusOnLocation(
     latitude: code.latitude!,
     longitude: code.longitude!,
     plusCode: PlusCode(globalCode: code.globalCode, localCode: code.localCode,
         latitude: code.latitude, longitude: code.longitude, locality: code.locality),
     locationResult: LocationResult(latitude: code.latitude, longitude: code.longitude,
         locality: code.locality),
   ));
   context.goNamed(mapViewRouteName);
   ```
   This reuses the cached Plus Code/locality from `SavedCode` directly — no redundant geocoding call.

## Delete flow

- Tap delete → `AlertDialog` using existing l10n keys: `confirmDeleteTitle`, `confirmDeleteMessage`, `cancel`, `actionDelete`.
- Confirm → `HistoryEvent.deleteCode(id)` → on success, `msgCodeDeleted` via `DialogUtils.handleSuccess`.

## Verification

- Save a location from Map View → appears in Saved list.
- Search filters the list (and clearing restores full list).
- Tap a saved card → switches to Map tab, camera centers on it, detail card shows its Plus Code/locality.
- Delete asks for confirmation and removes the item.
- Copy/Share produce expected clipboard content / share sheet text.
- Empty state shows when no saved codes exist.