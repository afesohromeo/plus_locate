# PlusLocate

PlusLocate is a Flutter application for generating, decoding, and locating [Google Plus Codes](https://maps.google.com/pluscodes/) — a free, open geocoding system that gives any point on Earth a short, shareable code, independent of street addresses. Tap a spot on the map, drop in an address, or paste a code, and PlusLocate resolves it to precise coordinates and back.

It exists because a large share of the world doesn't have (or doesn't have reliable) street addressing — which makes deliveries, navigation, and emergency response harder than they should be. PlusLocate is built for anyone who needs to communicate a location precisely: individuals in areas without formal addresses, delivery and logistics use cases, or simply people who want a faster way to share "meet me here."

---

## Screenshots

| Home | Generate | Search |
|------|----------|--------|
| ![Home](docs/screenshots/home.png) | ![Generate](docs/screenshots/generate.png) | ![Search](docs/screenshots/search.png) |

| Map | History | Settings |
|-----|---------|----------|
| ![Map](docs/screenshots/map.png) | ![History](docs/screenshots/history.png) | ![Settings](docs/screenshots/settings.png) |

---

## Why PlusLocate?

Traditional street addresses break down in a lot of real-world situations — informal settlements, rural areas, large parks, or new developments that haven't been mapped yet. Google Plus Codes solve this by dividing the globe into a grid and assigning each cell a short alphanumeric code (e.g. `8FVC9G8F+6W`), generated entirely offline from latitude/longitude, with no central authority or database required.

PlusLocate wraps that system in a focused, mobile-first tool: point at a location and get a code, or take a code and find the location — without needing to understand the underlying geocoding math. The goal is a small, reliable utility that does one job well, rather than a bloated maps app.

---

## Features

- ✅ Generate a Plus Code for any location by tapping the map or using your current GPS position
- ✅ Reverse geocoding — Plus Codes and map taps resolve to a human-readable address
- ✅ Search by address or by Plus Code, with automatic detection of which one you typed
- ✅ Google Places autocomplete for search, with a free on-device geocoding fallback once the local monthly autocomplete quota is reached
- ✅ Interactive Google Maps view with current-location detection
- ✅ Save locations to a local history, backed by Hive for offline access
- ✅ Search/filter saved locations, plus single and multi-select delete
- ✅ Jump from a saved location straight back to its spot on the map
- ✅ Share a location's Plus Code and address via the native share sheet
- ✅ Copy a Plus Code to the clipboard
- ✅ Hand off to Google Maps for turn-by-turn navigation
- ✅ First-launch onboarding flow (shown once, then skipped on future launches)
- ✅ Localized in English and French

---

## Architecture

PlusLocate follows a right-sized Clean Architecture: enough separation to keep the codebase maintainable, without the ceremony a small app doesn't need.

```
lib/src/
├── core/        # App bootstrap, routing (go_router), initialization
├── data/        # API providers (Dio)
├── domain/      # Freezed models + repositories
├── features/    # UI + BLoC per feature (home, generate, search, map_view, history, onboarding, settings)
└── shared/      # Cross-feature widgets, theming, utilities
```

Key decisions:
- **State management:** `flutter_bloc` with `freezed` events/states in every feature.
- **Navigation:** `go_router`, with the three main tabs (Map, Saved, Search) wired through a `StatefulShellRoute.indexedStack` so each tab keeps its own navigation stack.
- **Local persistence:** `hive` for saved locations and search-quota tracking; `flutter_secure_storage` for the onboarding flag.
- **Internationalization:** zero hardcoded UI strings — all text is sourced from ARB files via `AppLocalizations`.
- **Layout:** every page is wrapped in a shared `ResponsiveScaffoldWrapper` for consistent structure across screen sizes.

---

## Tech Stack

| Category | Tools |
|---|---|
| Framework | Flutter (Dart SDK ≥ 3.6.0) |
| State management | flutter_bloc, freezed, equatable |
| Routing | go_router |
| Maps & location | google_maps_flutter, geolocator, geocoding, open_location_code, google_places_flutter |
| Networking | dio |
| Local storage | hive, flutter_secure_storage |
| Sharing & utilities | share_plus, url_launcher, intl_phone_field |
| Localization | flutter_localizations, intl |
| Code generation | build_runner, freezed, json_serializable |
| Release | Shorebird (over-the-air updates) |

---

## Getting Started

**Prerequisites**
- Flutter SDK ≥ 3.6.0 (this project is developed with [fvm](https://fvm.app/))
- A Google Maps API key

```bash
git clone <repo-url>
cd plus_locate
flutter pub get

# Generate freezed/json_serializable code
dart run build_runner build --delete-conflicting-outputs

# Run the app (API key passed at build/run time, never hardcoded)
flutter run --dart-define=GOOGLE_MAPS_API_KEY=your_key_here
```

