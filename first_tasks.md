# Tasks for PlusLocate Architectural Setup (First Revised)

- [x] **Phase 1: Project Skeleton & Core Config**
  - [x] Configure pubspec.yaml with all required dependencies.
  - [x] Set up app_en.arb for I18n.
  - [x] Create core directories (`core/`, `domain/`, `data/`, `features/`, `shared/`).
  - [x] Implement `ResponsiveScaffoldWrapper`.

- [x] **Phase 2: Domain Layer**
  - [x] Create `LocationResult` freezed model.
  - [x] Create `PlusCode` freezed model.

- [x] **Phase 3: Data Layer**
  - [x] Implement standard `ApiProvider`.
  - [x] Implement `GeocodingRepository` interface and implementation.
  - [x] Implement `PlusCodeRepository` interface and implementation.

- [x] **Phase 4: State Management (Core Blocs)**
  - [x] Setup `MapViewBloc` (State and Event).
  - [x] Configure Dependency Injection in `application.dart`.

- [ ] **Phase 5: Map View UI Setup**
  - [ ] Implement `MapViewPage` using `ResponsiveScaffoldWrapper`.
  - [ ] Remove hardcoded UI strings; strictly use `AppLocalizations`.
  - [ ] Use `Geolocator` to fetch actual device position as initial state.
  - [ ] Place markers via onTap gesture instead of relying on map's camera center.

- [ ] **Phase 6: Search & Generate Plus Codes**
  - [ ] Implement bottom sheet search.
  - [ ] Add logic for generating and decoding codes interactively.
