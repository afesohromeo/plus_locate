# Flutter Skills - Complete Reference

> Local (project): .claude/skills/flutter/
> MCP Server: dart (stdio — `dart mcp-server`)

## Skills Index

| # | Skill | When to Use | Skill File Path |
|---|-------|-------------|-----------------|
| 1 | **flutter-apply-architecture-best-practices** | Structuring a new project or refactoring for scalability | `.claude/skills/flutter/flutter-apply-architecture-best-practices/SKILL.md` |
| 2 | **flutter-build-responsive-layout** | UI must adapt to mobile and tablet/desktop form factors | `.claude/skills/flutter/flutter-build-responsive-layout/SKILL.md` |
| 3 | **flutter-fix-layout-issues** | Any RenderFlex overflow, unbounded constraint, or layout error | `.claude/skills/flutter/flutter-fix-layout-issues/SKILL.md` |
| 4 | **flutter-add-widget-test** | Validating widget rendering or user interactions with WidgetTester | `.claude/skills/flutter/flutter-add-widget-test/SKILL.md` |
| 5 | **flutter-add-integration-test** | Adding integration tests or automating full user flows | `.claude/skills/flutter/flutter-add-integration-test/SKILL.md` |
| 6 | **flutter-add-widget-preview** | Creating or updating UI components — add interactive previews | `.claude/skills/flutter/flutter-add-widget-preview/SKILL.md` |
| 7 | **flutter-implement-json-serialization** | Mapping JSON keys to Dart model classes with fromJson/toJson | `.claude/skills/flutter/flutter-implement-json-serialization/SKILL.md` |
| 8 | **flutter-setup-declarative-routing** | Deep linking, browser history, or advanced URL-based navigation | `.claude/skills/flutter/flutter-setup-declarative-routing/SKILL.md` |
| 9 | **flutter-setup-localization** | Initializing i18n support (flutter_localizations + intl) | `.claude/skills/flutter/flutter-setup-localization/SKILL.md` |
| 10 | **flutter-use-http-package** | Fetching from or sending data to a REST API | `.claude/skills/flutter/flutter-use-http-package/SKILL.md` |

---

## Architecture Pattern (MVVM + Repository)

```
UI Layer (View + ViewModel)
    ↓ injects
Domain Layer (Use Cases — optional, for complex logic)
    ↓ injects
Data Layer (Repository → Service → External API)
```

### Layer Rules
- **Views** — dumb widgets only; no business logic
- **ViewModels** — extend `ChangeNotifier`; expose immutable state; inject Repositories via constructor
- **Repositories** — single source of truth; transform API models to Domain Models; handle caching
- **Services** — stateless wrappers around external APIs or plugins

### Project Structure
```
lib/
├── data/
│   ├── models/         # API response models
│   ├── repositories/   # Repository implementations
│   └── services/       # HTTP clients, local storage wrappers
├── domain/
│   ├── models/         # Clean domain models
│   └── use_cases/      # Optional — only for complex cross-repository logic
└── ui/
    ├── core/           # Shared widgets, themes, typography
    └── features/
        └── [feature]/
            ├── view_models/
            └── views/
```

---

## Responsive Layout Rules

- Use `LayoutBuilder` (not `OrientationBuilder`) for layout decisions
- Use `MediaQuery.sizeOf(context)` for window size
- Never check hardware type (phone vs tablet) — use available width
- Breakpoint: `maxWidth > 600` → large screen layout
- Always use `ListView.builder` / `GridView.builder` for dynamic lists
- Do not lock screen orientation

---

## Testing Checklist

### Widget Test (WidgetTester)
```
testWidgets → pumpWidget → find → expect → tap/enterText → pump/pumpAndSettle → expect
```
- Wrap widget in `MaterialApp` if it needs theme/directional data
- Use `pumpAndSettle()` for animations and async transitions
- Use `scrollUntilVisible()` for items in long lists

### Integration Test (flutter_test + integration_test)
- Place tests in `integration_test/` directory
- Use `IntegrationTestWidgetsFlutterBinding.ensureInitialized()`
- Run with: `flutter test integration_test/`

---

## Key Principles

| Principle | Rule |
|-----------|------|
| **No Logic in Views** | All state and commands live in ViewModels |
| **Immutable State** | ViewModels expose snapshots, not mutable objects |
| **Responsive by Default** | LayoutBuilder over device-type checks |
| **Test Every Widget** | Widget tests before marking any UI task complete |
| **Lazy Rendering** | Always use `.builder` constructors for unknown-length lists |

---

## Reading Individual Skills

```
c:\New_folder\bus tracking\smart_drive\.claude\skills\flutter\<skill-name>\SKILL.md
```
