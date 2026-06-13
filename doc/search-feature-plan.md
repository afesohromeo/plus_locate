# Search Feature Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the `decode` stub tab with a fully working **Search** tab that lets users find a location by address or Plus Code, view it on a result card, and jump to it on the map.

**Architecture:**
- Rename the existing `decode` feature folder/bloc to `search` and replace its single-purpose `DecodeBloc` with a `SearchBloc` that supports two input modes:
  - **Autocomplete mode** (default): `google_places_flutter`'s `GooglePlaceAutoCompleteTextField` (2s debounce) for live place suggestions.
  - **Fallback "on-submit" mode**: a plain text field + search button using the existing free, device-native `geocoding`/`open_location_code` packages — auto-detecting whether the typed text is a Plus Code or an address.
- A new `SearchQuotaRepository` (Hive-backed) tracks a monthly per-device autocomplete usage counter. `SearchBloc` checks this on init and after every autocomplete selection; once the local monthly limit is hit, it silently switches to fallback mode. The Google Cloud Console daily quota/budget (configured outside the app) is the actual cost backstop.
- The result (an address + Plus Code) is shown via an extended `PlusCodeDetailCard` (new optional `title` + `onViewOnMapPressed`), reusing the existing save/share/copy/navigate actions and adding "View on Map", which focuses the location on the Map tab via the existing `MapViewEvent.focusOnLocation`.

**Tech Stack:** Flutter, flutter_bloc (freezed), `google_places_flutter` 2.1.1, `geocoding`, `open_location_code`, Hive, go_router.

---

## File Structure

**New files:**
- `lib/src/domain/repository/search_quota_repository.dart` — local monthly autocomplete quota counter (Hive)
- `test/domain/repository/search_quota_repository_test.dart` — unit tests for the quota repository
- `test/domain/repository/plus_code_repository_test.dart` — unit test for `isValidPlusCode`
- `lib/src/features/search/bloc/search_bloc.dart`, `search_event.dart`, `search_state.dart`
- `lib/src/features/search/views/search_page.dart`
- `lib/src/features/search/search.dart`

**Modified files:**
- `lib/src/data/api/plus_code/plus_code_api_provider.dart` — add `isValidPlusCode`
- `lib/src/domain/repository/plus_code_repository.dart` — expose `isValidPlusCode`
- `lib/src/core/routing/route_names.dart`, `route_paths.dart`, `route_manager.dart` — rename `decode` → `search` route
- `lib/src/core/application.dart` — register `SearchQuotaRepository` + `SearchBloc`, drop `DecodeBloc`
- `lib/src/features/features.dart` — export `search` instead of `decode`
- `lib/src/features/map_view/components/plus_code_detail_card.dart` — add optional `title` + `onViewOnMapPressed`
- `lib/src/features/map_view/views/map_view_page.dart` — wire `FloatingSearchPill.onTap` to navigate to Search tab
- `lib/src/core/l10n/app_en.arb`, `app_fr.arb` — add new strings, remove unused `decode`/`actionDecode`

**Removed:**
- `lib/src/features/decode/` (entire folder, replaced by `search/`)

---

## Task 1: Add `isValidPlusCode` to the Plus Code data/domain layer

**Files:**
- Modify: `lib/src/data/api/plus_code/plus_code_api_provider.dart`
- Modify: `lib/src/domain/repository/plus_code_repository.dart`
- Test: `test/domain/repository/plus_code_repository_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
// test/domain/repository/plus_code_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:plus_locate/src/domain/repository/plus_code_repository.dart';

void main() {
  group('PlusCodeRepository.isValidPlusCode', () {
    final repository = PlusCodeRepository();

    test('returns true for a valid full Plus Code', () {
      expect(repository.isValidPlusCode('8FVC9G8F+6W'), isTrue);
    });

    test('returns false for an address string', () {
      expect(repository.isValidPlusCode('123 Main Street'), isFalse);
    });

    test('returns false for an empty string', () {
      expect(repository.isValidPlusCode(''), isFalse);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/domain/repository/plus_code_repository_test.dart`
Expected: FAIL — `isValidPlusCode` is not defined on `PlusCodeRepository`.

- [ ] **Step 3: Add `isValidPlusCode` to `PlusCodeApiProvider`**

In `lib/src/data/api/plus_code/plus_code_api_provider.dart`, add a method alongside `encodePlusCode`/`decodePlusCode`:

```dart
  /// Whether [code] is a syntactically valid Plus Code.
  ///
  /// Non-throwing — unlike `.decode()`, `.isValid` returns false for
  /// malformed or short codes instead of throwing [ArgumentError].
  bool isValidPlusCode(String code) {
    return olc.PlusCode(code).isValid;
  }
```

- [ ] **Step 4: Expose it on `PlusCodeRepository`**

In `lib/src/domain/repository/plus_code_repository.dart`, add:

```dart
  /// Whether [code] is a syntactically valid Plus Code (no network call).
  bool isValidPlusCode(String code) {
    return _apiProvider.isValidPlusCode(code);
  }
```

- [ ] **Step 5: Run test to verify it passes**

Run: `flutter test test/domain/repository/plus_code_repository_test.dart`
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add lib/src/data/api/plus_code/plus_code_api_provider.dart lib/src/domain/repository/plus_code_repository.dart test/domain/repository/plus_code_repository_test.dart
git commit -m "feat: add isValidPlusCode to PlusCodeRepository for search auto-detect"
```

---

## Task 2: Create `SearchQuotaRepository`

**Files:**
- Create: `lib/src/domain/repository/search_quota_repository.dart`
- Test: `test/domain/repository/search_quota_repository_test.dart`

This repository tracks how many Places Autocomplete searches the device has used this calendar month, stored in a plain (untyped) Hive box — no custom `TypeAdapter` needed since it only stores `int`/`String`.

- [ ] **Step 1: Write the failing test**

```dart
// test/domain/repository/search_quota_repository_test.dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:plus_locate/src/domain/repository/search_quota_repository.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('search_quota_test');
    Hive.init(tempDir.path);
  });

  tearDown(async () async {
    await Hive.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });

  group('SearchQuotaRepository', () {
    test('allows autocomplete when under the monthly limit', () async {
      final repository = SearchQuotaRepository();
      expect(await repository.canUseAutocomplete(), isTrue);
    });

    test('blocks autocomplete once the monthly limit is reached', () async {
      final repository = SearchQuotaRepository();

      for (var i = 0; i < SearchQuotaRepository.maxMonthlyAutocompleteSearches; i++) {
        await repository.recordAutocompleteUsage();
      }

      expect(await repository.canUseAutocomplete(), isFalse);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/domain/repository/search_quota_repository_test.dart`
Expected: FAIL — `package:plus_locate/src/domain/repository/search_quota_repository.dart` does not exist.

- [ ] **Step 3: Write the implementation**

```dart
// lib/src/domain/repository/search_quota_repository.dart
import 'package:hive/hive.dart';

/// Tracks how many Places Autocomplete searches this device has used in the
/// current calendar month, and decides when to fall back to the free
/// search-on-submit (device geocoding) flow.
///
/// This is a client-side cost-smoothing mechanism only. The real safety net
/// against runaway Places API spend is a daily quota + budget alert
/// configured in the Google Cloud Console.
class SearchQuotaRepository {
  static const String _boxName = 'search_quota';
  static const String _countKey = 'count';
  static const String _monthKey = 'month';

  /// Maximum number of Places Autocomplete searches allowed per device,
  /// per calendar month, before falling back to search-on-submit.
  static const int maxMonthlyAutocompleteSearches = 15;

  Future<Box> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }
    return Hive.openBox(_boxName);
  }

  String get _currentMonthKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }

  /// Returns the usage count for the current month, resetting it to 0 if
  /// the stored count belongs to a previous month.
  Future<int> _currentMonthCount(Box box) async {
    final storedMonth = box.get(_monthKey) as String?;
    if (storedMonth != _currentMonthKey) {
      await box.put(_monthKey, _currentMonthKey);
      await box.put(_countKey, 0);
      return 0;
    }
    return box.get(_countKey, defaultValue: 0) as int;
  }

  /// Whether the device can still use Places Autocomplete this month.
  Future<bool> canUseAutocomplete() async {
    final box = await _getBox();
    final count = await _currentMonthCount(box);
    return count < maxMonthlyAutocompleteSearches;
  }

  /// Records one Places Autocomplete usage for the current month.
  Future<void> recordAutocompleteUsage() async {
    final box = await _getBox();
    final count = await _currentMonthCount(box);
    await box.put(_countKey, count + 1);
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/domain/repository/search_quota_repository_test.dart`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/src/domain/repository/search_quota_repository.dart test/domain/repository/search_quota_repository_test.dart
git commit -m "feat: add SearchQuotaRepository for local autocomplete usage limits"
```

---

## Task 3: Remove the `decode` feature and scaffold the `search` feature

**Files:**
- Delete: `lib/src/features/decode/` (entire folder, including generated `.freezed.dart`)
- Create: `lib/src/features/search/bloc/search_bloc.dart`
- Create: `lib/src/features/search/bloc/search_event.dart`
- Create: `lib/src/features/search/bloc/search_state.dart`
- Create: `lib/src/features/search/search.dart`

- [ ] **Step 1: Delete the old decode feature folder**

```bash
git rm -r lib/src/features/decode
```

- [ ] **Step 2: Create `search_state.dart`**

```dart
// lib/src/features/search/bloc/search_state.dart
part of 'search_bloc.dart';

/// Which input UI the Search page should render.
enum SearchMode {
  /// Live Places Autocomplete suggestions (Google Places API).
  autocomplete,

  /// Plain text field with a search button — free, device-native
  /// geocoding/Plus Code decode, used once the monthly autocomplete
  /// quota is exhausted.
  onSubmit,
}

@freezed
sealed class SearchState with _$SearchState {
  const SearchState._();

  const factory SearchState({
    @Default(GenericStatus.initial) GenericStatus searchStatus,
    @Default(SearchMode.autocomplete) SearchMode searchMode,
    LocationResult? locationResult,
    PlusCode? plusCode,
    String? searchErrorMessage,
  }) = _SearchState;

  /// Best-available latitude for the current result (location result first,
  /// falling back to the Plus Code's decoded center).
  double? get latitude => locationResult?.latitude ?? plusCode?.latitude;

  /// Best-available longitude for the current result.
  double? get longitude => locationResult?.longitude ?? plusCode?.longitude;
}
```

- [ ] **Step 3: Create `search_event.dart`**

```dart
// lib/src/features/search/bloc/search_event.dart
part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  /// Checks the local autocomplete quota and sets the initial [SearchMode].
  const factory SearchEvent.init() = _Init;

  /// A suggestion was picked from the Places Autocomplete list.
  const factory SearchEvent.placeSelected({
    required String description,
    required double latitude,
    required double longitude,
  }) = _PlaceSelected;

  /// The user submitted a free-text query (address or Plus Code) in
  /// search-on-submit mode.
  const factory SearchEvent.submitQuery({required String query}) =
      _SubmitQuery;

  /// Clears the current result.
  const factory SearchEvent.reset() = _Reset;
}
```

- [ ] **Step 4: Create `search_bloc.dart`**

```dart
// lib/src/features/search/bloc/search_bloc.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:plus_locate/src/domain/models/location_result.dart';
import 'package:plus_locate/src/domain/models/plus_code.dart';
import 'package:plus_locate/src/domain/repository/geocoding_repository.dart';
import 'package:plus_locate/src/domain/repository/plus_code_repository.dart';
import 'package:plus_locate/src/domain/repository/search_quota_repository.dart';
import 'package:plus_locate/src/shared/utils/localization_service.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PlusCodeRepository _plusCodeRepository;
  final GeocodingRepository _geocodingRepository;
  final SearchQuotaRepository _quotaRepository;

  SearchBloc({
    required PlusCodeRepository plusCodeRepository,
    required GeocodingRepository geocodingRepository,
    required SearchQuotaRepository quotaRepository,
  })  : _plusCodeRepository = plusCodeRepository,
        _geocodingRepository = geocodingRepository,
        _quotaRepository = quotaRepository,
        super(const SearchState()) {
    on<_Init>(_onInit);
    on<_PlaceSelected>(_onPlaceSelected);
    on<_SubmitQuery>(_onSubmitQuery);
    on<_Reset>(_onReset);
  }

  Future<void> _onInit(_Init event, Emitter<SearchState> emit) async {
    final canUseAutocomplete = await _quotaRepository.canUseAutocomplete();
    emit(state.copyWith(
      searchMode:
          canUseAutocomplete ? SearchMode.autocomplete : SearchMode.onSubmit,
    ));
  }

  /// User picked a suggestion from Places Autocomplete.
  Future<void> _onPlaceSelected(
    _PlaceSelected event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(
      searchStatus: GenericStatus.loading,
      searchErrorMessage: null,
    ));

    try {
      await _quotaRepository.recordAutocompleteUsage();

      final results = await Future.wait([
        _plusCodeRepository.encodePlusCode(
          latitude: event.latitude,
          longitude: event.longitude,
        ),
        _safeReverseGeocode(event.latitude, event.longitude),
      ]);

      final plusCode = results[0] as PlusCode?;
      final locationResult = (results[1] as LocationResult?) ??
          LocationResult(
            formattedAddress: event.description,
            latitude: event.latitude,
            longitude: event.longitude,
          );

      final canStillUseAutocomplete =
          await _quotaRepository.canUseAutocomplete();

      emit(state.copyWith(
        searchStatus: GenericStatus.success,
        plusCode: plusCode,
        locationResult: locationResult,
        searchMode: canStillUseAutocomplete
            ? SearchMode.autocomplete
            : SearchMode.onSubmit,
      ));
    } catch (e) {
      log('Error resolving selected place: $e');
      emit(state.copyWith(
        searchStatus: GenericStatus.failure,
        searchErrorMessage: LocalizationService.localization.operationError,
      ));
    }
  }

  /// User submitted free text in search-on-submit mode. Auto-detects
  /// whether [SubmitQuery.query] is a Plus Code or an address.
  Future<void> _onSubmitQuery(
    _SubmitQuery event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) return;

    emit(state.copyWith(
      searchStatus: GenericStatus.loading,
      searchErrorMessage: null,
    ));

    try {
      if (_plusCodeRepository.isValidPlusCode(query)) {
        await _searchByPlusCode(query, emit);
      } else {
        await _searchByAddress(query, emit);
      }
    } catch (e) {
      log('Error submitting search query: $e');
      emit(state.copyWith(
        searchStatus: GenericStatus.failure,
        searchErrorMessage: LocalizationService.localization.operationError,
      ));
    }
  }

  Future<void> _searchByPlusCode(
    String code,
    Emitter<SearchState> emit,
  ) async {
    final plusCode = await _plusCodeRepository.decodePlusCode(code: code);
    if (plusCode == null || !plusCode.hasCoordinates) {
      emit(state.copyWith(
        searchStatus: GenericStatus.failure,
        searchErrorMessage:
            LocalizationService.localization.errorInvalidPlusCode,
      ));
      return;
    }

    final locationResult = await _safeReverseGeocode(
      plusCode.latitude!,
      plusCode.longitude!,
    );

    emit(state.copyWith(
      searchStatus: GenericStatus.success,
      plusCode: plusCode,
      locationResult: locationResult,
    ));
  }

  Future<void> _searchByAddress(
    String address,
    Emitter<SearchState> emit,
  ) async {
    final locationResult =
        await _geocodingRepository.geocodeAddress(address: address);
    if (locationResult == null || !locationResult.hasCoordinates) {
      emit(state.copyWith(
        searchStatus: GenericStatus.failure,
        searchErrorMessage: LocalizationService.localization.msgNoResults,
      ));
      return;
    }

    final plusCode = await _plusCodeRepository.encodePlusCode(
      latitude: locationResult.latitude!,
      longitude: locationResult.longitude!,
    );

    emit(state.copyWith(
      searchStatus: GenericStatus.success,
      plusCode: plusCode,
      locationResult: locationResult,
    ));
  }

  /// Reverse geocode without throwing — failure just leaves the address
  /// blank, the Plus Code/coordinates are still shown.
  Future<LocationResult?> _safeReverseGeocode(
    double latitude,
    double longitude,
  ) async {
    try {
      return await _geocodingRepository.reverseGeocode(
        latitude: latitude,
        longitude: longitude,
      );
    } catch (e) {
      log('Reverse geocoding failed (non-fatal): $e');
      return null;
    }
  }

  void _onReset(_Reset event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      searchStatus: GenericStatus.initial,
      plusCode: null,
      locationResult: null,
      searchErrorMessage: null,
    ));
  }
}
```

- [ ] **Step 5: Create `search.dart` barrel export**

```dart
// lib/src/features/search/search.dart
export 'bloc/search_bloc.dart';
export 'views/search_page.dart';
```

- [ ] **Step 6: Commit**

```bash
git add -A lib/src/features/search lib/src/features/decode
git commit -m "feat: scaffold SearchBloc replacing DecodeBloc"
```

> Note: this will not compile yet — `search_page.dart` doesn't exist and `features.dart`/`route_manager.dart`/`application.dart` still reference the old `decode` feature. That's fixed in the following tasks. The user will run `build_runner` to generate `search_bloc.freezed.dart`.

---

## Task 4: Extend `PlusCodeDetailCard` with `title` and `onViewOnMapPressed`

**Files:**
- Modify: `lib/src/features/map_view/components/plus_code_detail_card.dart`

- [ ] **Step 1: Add the new optional constructor params**

In `lib/src/features/map_view/components/plus_code_detail_card.dart`, update the class fields and constructor:

```dart
class PlusCodeDetailCard extends StatelessWidget {
  final LocationResult? locationResult;
  final PlusCode? plusCode;
  final GenericStatus status;
  final VoidCallback onNavigatePressed;
  final VoidCallback onSavePressed;
  final VoidCallback onSharePressed;
  final VoidCallback onCopyPlusCode;

  /// Header title. Defaults to [AppLocalizations.currentLocation] when null
  /// — used by the Map tab. The Search tab passes its own title.
  final String? title;

  /// When provided, shows a "View on Map" icon button in the action row.
  final VoidCallback? onViewOnMapPressed;

  const PlusCodeDetailCard({
    super.key,
    this.locationResult,
    this.plusCode,
    required this.status,
    required this.onNavigatePressed,
    required this.onSavePressed,
    required this.onSharePressed,
    required this.onCopyPlusCode,
    this.title,
    this.onViewOnMapPressed,
  });
```

- [ ] **Step 2: Use `title` in the header**

In `_buildContent`, replace the hardcoded header text:

```dart
                  Text(
                    title ?? l10n.currentLocation,
                    style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: customColors.primary,
                    ),
                  ),
```

- [ ] **Step 3: Add the "View on Map" button to the action row**

In the final `Row` of `_buildContent` (the one containing Navigate/Save/Share), add a new icon button after the Share `IconButton`, only rendered when `onViewOnMapPressed` is provided:

```dart
            IconButton(
              iconSize: 20,
              onPressed: onSharePressed,
              style: IconButton.styleFrom(
                backgroundColor: customColors.black1.withValues(alpha: 0.05),
                foregroundColor: customColors.black1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.zero,
              ),
              icon: const Icon(Icons.share),
            ),
            if (onViewOnMapPressed != null) ...[
              const SizedBox(width: 12),
              IconButton(
                iconSize: 20,
                onPressed: onViewOnMapPressed,
                style: IconButton.styleFrom(
                  backgroundColor:
                      customColors.primary.withValues(alpha: 0.1),
                  foregroundColor: customColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: EdgeInsets.zero,
                ),
                icon: const Icon(Icons.map_outlined),
              ),
            ],
```

- [ ] **Step 4: Commit**

```bash
git add lib/src/features/map_view/components/plus_code_detail_card.dart
git commit -m "feat: add optional title and View on Map action to PlusCodeDetailCard"
```

---

## Task 5: Add new localization strings

**Files:**
- Modify: `lib/src/core/l10n/app_en.arb`
- Modify: `lib/src/core/l10n/app_fr.arb`

- [ ] **Step 1: Remove the now-unused `decode`/`actionDecode` keys**

In `app_en.arb`, remove:

```json
    "decode": "Decode",
    "@decode": {
        "description": "Decode Plus Code page title"
    },
```

and:

```json
    "actionDecode": "Decode Code",
    "@actionDecode": {
        "description": "Button text to decode a Plus Code to coordinates"
    },
```

Remove the equivalent `decode`/`actionDecode` entries from `app_fr.arb`.

- [ ] **Step 2: Add new search-result strings to `app_en.arb`**

Add after `"searchPlacesOrCodes"`:

```json
    "searchResult": "Search Result",
    "@searchResult": {
        "description": "Header title for the search result card"
    },
    "viewOnMap": "View on Map",
    "@viewOnMap": {
        "description": "Button/tooltip to focus the searched location on the map"
    },
    "searchInitialPrompt": "Search for an address or Plus Code to see details here",
    "@searchInitialPrompt": {
        "description": "Placeholder shown on the Search tab before any search is performed"
    },
```

- [ ] **Step 3: Add matching French strings to `app_fr.arb`**

```json
    "searchResult": "Résultat de recherche",
    "@searchResult": {
        "description": "Header title for the search result card"
    },
    "viewOnMap": "Voir sur la carte",
    "@viewOnMap": {
        "description": "Button/tooltip to focus the searched location on the map"
    },
    "searchInitialPrompt": "Recherchez une adresse ou un Plus Code pour voir les détails ici",
    "@searchInitialPrompt": {
        "description": "Placeholder shown on the Search tab before any search is performed"
    },
```

- [ ] **Step 4: Commit**

```bash
git add lib/src/core/l10n/app_en.arb lib/src/core/l10n/app_fr.arb
git commit -m "feat: add search result l10n strings, remove unused decode strings"
```

> Note: the user will run `flutter gen-l10n` (or `build_runner`) to regenerate `app_localizations*.dart`.

---

## Task 6: Build the `SearchPage` UI

**Files:**
- Create: `lib/src/features/search/views/search_page.dart`

This page renders either the Places Autocomplete field or the fallback text field (based on `state.searchMode`), and shows the result via `PlusCodeDetailCard`.

- [ ] **Step 1: Write `search_page.dart`**

```dart
// lib/src/features/search/views/search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:plus_locate/plus_locate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        title: Text(l10n.search),
        hasAppbar: true,
      ),
      mobileBody: const _SearchBody(),
      tabletBody: const _SearchBody(),
      desktopBody: const _SearchBody(),
    );
  }
}

class _SearchBody extends StatefulWidget {
  const _SearchBody();

  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    context
        .read<SearchBloc>()
        .add(SearchEvent.submitQuery(query: _textController.text));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.searchMode == SearchMode.autocomplete)
                _AutocompleteField(textController: _textController)
              else
                _SubmitField(
                  textController: _textController,
                  onSubmit: () => _submit(context),
                ),
              const SizedBox(height: 16),
              Expanded(child: _buildContent(context, state, l10n)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    SearchState state,
    AppLocalizations l10n,
  ) {
    switch (state.searchStatus) {
      case GenericStatus.loading:
        return LoadingWidget(loadingText: l10n.loading);
      case GenericStatus.failure:
        return ErrorrWidget(
          errorMessage: state.searchErrorMessage ?? l10n.operationError,
          refreshText: l10n.refresh,
          onPressed: () =>
              context.read<SearchBloc>().add(const SearchEvent.reset()),
        );
      case GenericStatus.success:
        return _SearchResultView(state: state);
      default:
        return EmptyWidget(
          emptyText: l10n.searchInitialPrompt,
          onPressed: () =>
              context.read<SearchBloc>().add(const SearchEvent.reset()),
        );
    }
  }
}

/// Live Places Autocomplete field — used while under the monthly quota.
class _AutocompleteField extends StatelessWidget {
  final TextEditingController textController;

  const _AutocompleteField({required this.textController});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GooglePlaceAutoCompleteTextField(
      textEditingController: textController,
      googleAPIKey: Environment.googleMapsApiKey,
      debounceTime: 2000,
      isLatLngRequired: true,
      inputDecoration: InputDecoration(
        hintText: l10n.searchPlacesOrCodes,
        filled: true,
        fillColor: customColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      itemClick: (prediction) {
        textController.text = prediction.description ?? '';
        textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length),
        );
      },
      getPlaceDetailWithLatLng: (prediction) {
        final latitude = double.tryParse(prediction.lat ?? '');
        final longitude = double.tryParse(prediction.lng ?? '');
        if (latitude == null || longitude == null) return;

        context.read<SearchBloc>().add(
              SearchEvent.placeSelected(
                description: prediction.description ?? '',
                latitude: latitude,
                longitude: longitude,
              ),
            );
      },
    );
  }
}

/// Free-text field + search button — used once the monthly autocomplete
/// quota is exhausted. Auto-detects Plus Code vs. address on submit.
class _SubmitField extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSubmit;

  const _SubmitField({
    required this.textController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InputField(
      controller: textController,
      validator: (_) => null,
      labelText: l10n.searchPlacesOrCodes,
      bgColor: customColors.surface,
      borderRadius: BorderRadius.circular(10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      onEditingComplete: onSubmit,
      suffixIcon: IconButton(
        icon: Icon(Icons.search, color: customColors.primary),
        onPressed: onSubmit,
      ),
    );
  }
}

class _SearchResultView extends StatelessWidget {
  final SearchState state;

  const _SearchResultView({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: PlusCodeDetailCard(
        title: l10n.searchResult,
        locationResult: state.locationResult,
        plusCode: state.plusCode,
        status: state.searchStatus,
        onNavigatePressed: () async {
          final latitude = state.latitude;
          final longitude = state.longitude;
          if (latitude == null || longitude == null) return;

          final url = Uri.parse(
            'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
          );
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else if (context.mounted) {
            await DialogUtils.handleFailure(context, l10n.operationError);
          }
        },
        onSavePressed: () {
          if (state.plusCode == null) return;

          final savedCode = SavedCode(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            globalCode: state.plusCode?.globalCode,
            localCode: state.plusCode?.localCode,
            latitude: state.latitude,
            longitude: state.longitude,
            locality: state.locationResult?.locality,
            address: state.locationResult?.formattedAddress,
            savedAt: DateTime.now(),
          );
          context.read<HistoryBloc>().add(HistoryEvent.saveCode(code: savedCode));
        },
        onSharePressed: () {
          final plusCodeVal = state.plusCode?.globalCode ?? '---';
          final latVal = state.latitude?.toStringAsFixed(6) ?? '---';
          final lngVal = state.longitude?.toStringAsFixed(6) ?? '---';
          final addressVal = state.locationResult?.formattedAddress ?? '---';

          Share.share(
            l10n.shareLocationText(plusCodeVal, latVal, lngVal, addressVal),
          );
        },
        onCopyPlusCode: () async {
          final code = state.plusCode?.globalCode;
          if (code == null) return;

          Clipboard.setData(ClipboardData(text: code));
          if (context.mounted) {
            await DialogUtils.handleSuccess(context, l10n.msgCodeCopied);
          }
        },
        onViewOnMapPressed: () {
          final latitude = state.latitude;
          final longitude = state.longitude;
          if (latitude == null || longitude == null) return;

          context.read<MapViewBloc>().add(
                MapViewEvent.focusOnLocation(
                  latitude: latitude,
                  longitude: longitude,
                  plusCode: state.plusCode,
                  locationResult: state.locationResult,
                ),
              );
          context.goNamed(mapViewRouteName);
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/src/features/search/views/search_page.dart
git commit -m "feat: build SearchPage with autocomplete and fallback modes"
```

---

## Task 7: Rename the `decode` route to `search`

**Files:**
- Modify: `lib/src/core/routing/route_names.dart`
- Modify: `lib/src/core/routing/route_paths.dart`
- Modify: `lib/src/core/routing/route_manager.dart`

- [ ] **Step 1: Update `route_names.dart`**

```dart
const String homeRouteName = 'home';
const String rootRouteName = 'root';
const String generateRouteName = 'generate';
const String searchRouteName = 'search';
const String mapViewRouteName = 'map-view';
const String historyRouteName = 'history';
const String settingsRouteName = 'settings';
```

- [ ] **Step 2: Update `route_paths.dart`**

```dart
const String homePage = '/home';
const String rootPage = '/';
const String generatePage = '/generate';
const String searchPage = '/search';
const String mapViewPage = '/map-view';
const String historyPage = '/history';
const String settingsPage = '/settings';
```

- [ ] **Step 3: Update the third `StatefulShellBranch` in `route_manager.dart`**

Replace:

```dart
          StatefulShellBranch(
            routes: [
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
            ],
          ),
```

with:

```dart
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
```

- [ ] **Step 4: Commit**

```bash
git add lib/src/core/routing/route_names.dart lib/src/core/routing/route_paths.dart lib/src/core/routing/route_manager.dart
git commit -m "refactor: rename decode route to search"
```

---

## Task 8: Update feature exports and DI registration

**Files:**
- Modify: `lib/src/features/features.dart`
- Modify: `lib/src/core/application.dart`

- [ ] **Step 1: Update `features.dart`**

```dart
export 'home/home.dart';
export 'generate/generate.dart';
export 'search/search.dart';
export 'map_view/map_view.dart';
export 'history/history.dart';
export 'settings/settings.dart';
```

- [ ] **Step 2: Update `application.dart`**

Add `SearchQuotaRepository` to the repository providers, and replace the `DecodeBloc` provider with `SearchBloc`:

```dart
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => PlusCodeRepository()),
        RepositoryProvider(create: (_) => GeocodingRepository()),
        RepositoryProvider(create: (_) => SavedCodesRepository()),
        RepositoryProvider(create: (_) => SearchQuotaRepository()),
        Provider<RouteManager>(
          lazy: true,
          create: (context) => RouteManager(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeBloc()),
          BlocProvider(
            create: (context) => GenerateBloc(
              repository: context.read<PlusCodeRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              plusCodeRepository: context.read<PlusCodeRepository>(),
              geocodingRepository: context.read<GeocodingRepository>(),
              quotaRepository: context.read<SearchQuotaRepository>(),
            )..add(const SearchEvent.init()),
          ),
          BlocProvider(
            create: (context) => MapViewBloc(
              geocodingRepository: context.read<GeocodingRepository>(),
              plusCodeRepository: context.read<PlusCodeRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => HistoryBloc(
              repository: context.read<SavedCodesRepository>(),
            )..add(const HistoryEvent.init()),
          ),
        ],
        child: const ApplicationView(),
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add lib/src/features/features.dart lib/src/core/application.dart
git commit -m "refactor: register SearchBloc and SearchQuotaRepository, drop DecodeBloc"
```

---

## Task 9: Wire up `FloatingSearchPill` to navigate to the Search tab

**Files:**
- Modify: `lib/src/features/map_view/views/map_view_page.dart`

- [ ] **Step 1: Replace the TODO**

In `map_view_page.dart`, replace:

```dart
              child: FloatingSearchPill(
                onTap: () {
                  // TODO: Open Search Bottom Sheet or Page
                },
              ),
```

with:

```dart
              child: FloatingSearchPill(
                onTap: () => context.goNamed(searchRouteName),
              ),
```

- [ ] **Step 2: Commit**

```bash
git add lib/src/features/map_view/views/map_view_page.dart
git commit -m "feat: navigate to Search tab from the floating search pill"
```

---

## Task 10: Manual verification

No widget/integration tests are added for `SearchPage` itself (the project has no existing bloc/widget test harness — `bloc_test`/`mocktail` aren't dependencies, and adding that infrastructure is out of scope for this feature). Verify manually after `build_runner` + `flutter gen-l10n`:

- [ ] **Step 1: Run code generation** (user runs this)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

- [ ] **Step 2: Cold-start check** — app launches, Search tab shows the Places Autocomplete field (quota box is empty → `canUseAutocomplete()` is true).

- [ ] **Step 3: Autocomplete flow** — type a partial address, wait ~2s, tap a suggestion → loading spinner → result card shows address, locality, Plus Code, and Navigate/Save/Share/Copy/View on Map actions.

- [ ] **Step 4: View on Map** — tap "View on Map" → app switches to Map tab and camera animates to the searched location with the marker placed.

- [ ] **Step 5: Save from Search** — tap Save → success dialog → entry appears on the Saved tab.

- [ ] **Step 6: Quota fallback** — temporarily set `SearchQuotaRepository.maxMonthlyAutocompleteSearches = 0`, hot-restart, confirm the Search tab shows the plain text field + search icon instead of autocomplete.

- [ ] **Step 7: Search-on-submit, address** — with the field above, type a full address and tap the search icon → result card populates the same as the autocomplete flow.

- [ ] **Step 8: Search-on-submit, Plus Code** — type a valid Plus Code (e.g. `8FVC9G8F+6W`) and tap search → result card shows the decoded coordinates/address.

- [ ] **Step 9: Search-on-submit, no results** — type gibberish (e.g. `zzzzzzzzzzzz`) and tap search → `ErrorrWidget` shows the "no results" message with a working reset/refresh button.

- [ ] **Step 10: Revert the temporary quota change** from Step 6 before committing anything further.

- [ ] **Step 11: Map pill navigation** — from the Map tab, tap the floating "Search for places or Plus Codes" pill → lands on the Search tab.

---

## Self-Review Notes

- **Spec coverage:** core search-by-address-or-Plus-Code ✓ (Task 6/3), auto-detect format ✓ (`SearchBloc._onSubmitQuery`), result card with "View on Map" ✓ (Task 4/6), search pill → Search tab ✓ (Task 9), rename decode→search ✓ (Tasks 3/7/8), dedicated SearchBloc ✓ (Task 3), 2s debounce ✓ (Task 6 `_AutocompleteField`), quota + silent fallback ✓ (Task 2/3).
- **Type consistency:** `SearchEvent.placeSelected`/`submitQuery`/`reset`/`init` used consistently across Task 3 (bloc) and Task 6 (UI). `SearchState.latitude`/`longitude` getters used consistently in Task 6's `_SearchResultView`. `PlusCodeDetailCard`'s new `title`/`onViewOnMapPressed` params (Task 4) match their usage in Task 6.
- **Payment/IAP**: explicitly out of scope — deferred per the brainstorming discussion (requires auth + backend, a separate future spec).