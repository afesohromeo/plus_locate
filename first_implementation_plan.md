# PlusLocate — Engineering Standards Adaptation Plan (First Revised)

## Goal

Evaluate the 12 enterprise-grade engineering standards and produce a **right-sized** architecture for PlusLocate. 
PlusLocate is a relatively simple application (approx 6-7 screens) for interacting with Google Plus Codes. The architecture should be lightweight but strictly adhere to key standards such as zero hardcoded strings and unified UI wrappers.

---

## The Verdict: Keep vs. Drop vs. Adapt

| Standard | Status | Rationale for PlusLocate |
| :--- | :--- | :--- |
| **Clean Architecture** | **Adapt (Light)** | 4 layers (Domain, Data, Core, Features). Skip strict UseCases. Repositories handle API calls. |
| **State Management** | **Keep** | Use `flutter_bloc` with `freezed` for events/states. |
| **Dependency Injection** | **Adapt (Light)** | Use a simple `MultiRepositoryProvider` and `MultiBlocProvider` at the root (`application.dart`). No need for `get_it` or `injectable`. |
| **Routing** | **Keep** | Use `go_router` for robust navigation. |
| **Internationalization (i18n)** | **Keep (Strict)** | **Zero hardcoded strings.** All UI text MUST use `AppLocalizations` (`app_en.arb`). |
| **Design System / Theming** | **Adapt (Light)** | Define centralized text styles, colors, and button styles in `theme.dart`. |
| **Network & API** | **Keep** | Use `Dio` for API requests. Keep the standard `ApiProvider`. |
| **Error Handling** | **Keep** | Standardized `GenericStatus` (initial, loading, success, error) and friendly error messages. |
| **Form Validation** | **Drop** | Not applicable; very little form input in this app. |
| **Responsive UI** | **Keep (Strict)** | All pages MUST be wrapped in the standardized `ResponsiveScaffoldWrapper`. |
| **Local Storage** | **Adapt** | Use `hive` or `shared_preferences` for saving user history. |
| **Testing** | **Adapt (Light)** | Focus on Bloc and Repository tests. Minimal widget tests unless complex UI. |

---

## Architectural Rules for PlusLocate

1. **Mandatory Page Wrapper**: Every feature page MUST use `ResponsiveScaffoldWrapper`.
2. **Zero Hardcoded Strings**: All text displayed to the user MUST come from `AppLocalizations`. No exceptions.
3. **Data Models**: Use `freezed` for all models (Data layer and State layer).
4. **API Keys**: Secrets like `GOOGLE_MAPS_API_KEY` must be passed via `--dart-define` and retrieved safely. No hardcoded secrets.
5. **Separation of Concerns**: UI widgets should not contain business logic. Business logic lives in Blocs. Network logic lives in Repositories.

---

## Phased Implementation (Revised)

*   **Phase 1:** Core structure setup (directories, dependencies, routing, base scaffold).
*   **Phase 2:** Domain models (`LocationResult`, `PlusCode`).
*   **Phase 3:** Data Layer (API Provider, `GeocodingRepository`, `PlusCodeRepository`).
*   **Phase 4:** Core Blocs (stubbing out state management for Map and Generate views).
*   **Phase 5:** Feature implementations (Map View, Generate View, History View) strictly using the `ResponsiveScaffoldWrapper` and Localizations.
