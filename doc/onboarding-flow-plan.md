# Onboarding Flow — Implementation Plan

## Goal
Show a first-launch splash screen (matching the Stitch "Digital Beacon" design) once, then never again. Tap "Get Started" to enter the app.

## Storage Strategy
`SecureStorageHelper` (flutter_secure_storage) stores a `hasSeenOnboarding` bool as a string.
Since GoRouter's `redirect` is synchronous, the flag is read once during `AppInitializer.preAppRun()`,
cached as `bool hasSeenOnboarding`, and passed down `Application → RouteManager`.

## Files to Create
1. `lib/src/features/onboarding/views/onboarding_page.dart` — full UI
2. `lib/src/features/onboarding/onboarding.dart` — barrel export

## Files to Modify
1. `secure_storage_helper.dart` — add `kHasSeenOnboarding`, `hasSeenOnboarding()`, `markOnboardingSeen()`
2. `app_initializer.dart` — read flag in `preAppRun()`, expose as `bool hasSeenOnboarding`
3. `main.dart` — pass `appInitializer.hasSeenOnboarding` into `Application`
4. `application.dart` — accept + forward `hasSeenOnboarding` to `RouteManager`
5. `route_names.dart` — add `onboardingRouteName`
6. `route_paths.dart` — add `onboardingPage = '/onboarding'`
7. `route_manager.dart` — add `GoRoute` + `redirect` (if not seen → `/onboarding`)
8. `features.dart` — export onboarding barrel
9. `app_en.arb` + `app_fr.arb` — add onboarding strings

## OnboardingPage UI (Stitch — single splash)
- Logo row: `location_on` icon + "PlusLocate"
- Large hero location pin icon
- Plus Code display card: "8FVC9G8F+W2" + "Precise to 3 meters" badge
- Headline: "Find Your Place Everywhere."
- Tagline: "Discover precise Plus Codes for any location on Earth, even without a street address."
- Three feature chips: Global Coverage · Offline Access · Easy Sharing
- Full-width "Get Started" button → `markOnboardingSeen()` then `context.go(mapViewPage)`
- NO "How it works" button

## l10n Keys (new)
- `onboardingHeadline`
- `onboardingTagline`
- `onboardingPrecise`
- `onboardingFeatureGlobal`
- `onboardingFeatureOffline`
- `onboardingFeatureShare`
- `getStarted`

## Implementation Order
1. SecureStorageHelper
2. AppInitializer + main.dart
3. Application
4. Route constants + RouteManager
5. OnboardingPage + barrel
6. features.dart export
7. l10n strings