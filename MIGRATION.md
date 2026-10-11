# Migrating from Flutter Bond v1 to v2

v2.0.0 moves the template to **Flutter 3.47.7 / Dart 3.13.5** with Riverpod 3, `material_ui`,
go_router 18, the Firebase 4.x line, Android Gradle Plugin 9.1 (Kotlin DSL) and iOS 15 with the
UIScene lifecycle. The legacy template stays available as the `v1.0.0` tag.

**Recommended:** start a fresh project with `bond create project` (bond_cli 0.2.x clones `v2.1.0`)
and move your features over. Upgrading an existing v1 app in place works too; follow the steps in
order.

## Compatibility

| Template | bond_* packages | bond_cli | Flutter |
|---|---|---|---|
| `v1.0.0` | bond_core 0.0.3, bond_network ≤ 0.0.11+11, bond_form ≤ 0.0.22+19, bond_form_riverpod ≤ 0.0.17+19, notifications/analytics 0.1.0 | 0.0.4+3 (or 0.1.x with `--ref v1.0.0`) | 3.19 – 3.27 |
| `v2.0.0` | core, cache, network, form, form_riverpod 0.1.x; notifications, app_analytics 0.2.x | 0.1.x | 3.47.7+ |
| `v2.1.0` | same as v2.0.0 | 0.2.x | 3.47.7+ |

## 1. Toolchain

- Flutter 3.47.7 (Dart 3.13.5).
- Java 17 for Android, Xcode 26 for iOS (minimum iOS 15.0).
- `dart pub global activate flutterfire_cli` — the iOS archive build phases call `flutterfire` to
  bundle the per-flavor `GoogleService-Info.plist` and upload Crashlytics symbols.

## 2. Dependencies

| Package | v1 | v2 |
|---|---|---|
| flutter_riverpod | 2.6 | 3.4.3 |
| material_ui | — | 1.6.0 |
| go_router | 14.8 | 18.0.2 |
| google_fonts | 6.2 | 9.0.0 |
| get_it / equatable | 8 / 2 | 9.3.0 / 3.0.0 |
| dio | 5.8 | 5.11.1 |
| firebase_core / analytics / messaging / crashlytics / remote_config | 3.11 / 11.4 / 15.2 / 4.3 / 5.4 | 4.15 / 12.6 / 16.7 / 5.4 / 6.7 |
| flutter_local_notifications | 18 | 22.3.1 |
| share_plus / package_info_plus / device_info_plus | 10 / 8 / 11 | 13.3.1 / 10.2.2 / 13.3.0 |
| flutter_secure_storage | 9 | 11.2.0 |
| intl | 0.19 | 0.20 (pinned by Flutter) |
| json_serializable | dependency | dev dependency (6.14.1) |
| open_store, faker | used | removed |

Bond packages: see [bond-core/MIGRATION.md](https://github.com/flutterbond/bond-core/blob/main/MIGRATION.md).

## 3. Dart code

1. **material_ui.** Run `dart fix --apply --code=migrate_design_widgets`; it rewrites
   `package:flutter/material.dart` imports to `package:material_ui/material_ui.dart`. Don't import
   `flutter_localizations` in the same file (`GlobalMaterialLocalizations` becomes ambiguous).
2. **MaterialApp.** `localizationsDelegates: [AppLocalizations.delegate, ...GlobalMaterialLocalizations.delegates]`
   and `builder: (context, child) => MaterialUiCompatibilityBridge(child: child!)` (deprecated and
   temporary, for dependencies that still import `flutter/material.dart`).
3. **Localizations.** `package:flutter_gen/gen_l10n/app_localizations.dart` →
   `package:bond/l10n/app_localizations.dart`. Generated files live in `lib/l10n` and are committed;
   drop `synthetic-package` from `l10n.yaml`.
4. **Themes.** `AppBarTheme(color:)` → `AppBarThemeData(backgroundColor:)`; `TabBarTheme`,
   `BottomAppBarTheme`, `InputDecorationTheme` → `*ThemeData`; `ButtonThemeData` and bond_core's
   `context.buttonTheme` are gone; `useMaterial3: true`.
5. **Riverpod 3 notifiers.** `AutoDisposeAsyncNotifier` → `AsyncNotifier` (keep
   `AsyncNotifierProvider.autoDispose`), `AutoDisposeNotifier` → `Notifier`, `Family*` → base class
   with the argument passed to the constructor. The notifier instance survives rebuilds and
   retries: create disposable objects (e.g. `ScrollController`) in `build()`, and check
   `ref.mounted` after every `await` before writing `state`.
6. **Riverpod 3 behaviour.** Failing providers retry automatically (up to 10 times, 200 ms → 6.4 s),
   so an offline error can take ~40 s to show; disable with `ProviderScope(retry: (_, _) => null)`.
   Listeners only fire when the new state is `!=` the old one, so Equatable states and models need
   meaningful `props` (`Post` now compares `[uuid, updatedAt]`).
7. **Forms (bond_form_riverpod 0.1).** `AutoDisposeFormStateNotifier` → `FormStateNotifier` with
   `NotifierProvider.autoDispose`; family forms use `MyForm(super.arg)` and `build()`.
8. **Update routes.** Build them with `updateAppLocation(message)` / `softUpdateLocation(message)`
   (`Uri(path:, queryParameters:)`); pages read `state.uri.queryParameters['message'] ?? ''`.
9. **go_router 18.** No template API change; paths are case-sensitive.
10. **share_plus 13.** `Share.share(text)` → `SharePlus.instance.share(ShareParams(text: ...))`.
11. **open_store → in_app_review.** `AppReviewHelper.openStoreListing()`; set your App Store id in
    `AppReviewHelper.appStoreId`.
12. **flutter_local_notifications 22.** `initialize`, `show`, `zonedSchedule`… take named parameters.
13. **BondFire.** No longer a singleton: register `it.registerLazySingleton<BondFire>(BondFire.new)`
    and use `sl<BondFire>()`.
14. **equatable 3.** `EquatableMixin` → `with Equatable`; `==` ignores `runtimeType`; no generated
    `toString`.
15. **Firebase start-up.** `FirebaseServiceProvider` no longer awaits `fetchAndActivate` (remote
    config is activated in the background) and reuses the native default app on `duplicate-app`.
16. **Locale default.** `PlatformDispatcher.instance.locale.languageCode` (was `Platform.localeName`).
17. **Codegen.** Re-run `dart run build_runner build` (json_serializable 6.14 output changed;
    build_runner 2.16 ignores `-d`).

## 4. Configuration

- **API timeouts are milliseconds now** (`Duration(milliseconds:)`, they were read as seconds).
  Update your local `env.json` / `env.staging.json`: `CONNECT_TIMEOUT` 10000, `SEND_TIMEOUT` 30000,
  `RECEIVE_TIMEOUT` 30000. Old values like 100000 / 1000000 would now mean 100 s / 1000 s.

## 5. Android

Copy the `android/` folder of v2 and re-apply your app id and signing:

- Groovy → Kotlin DSL: `settings.gradle.kts`, `build.gradle.kts`, `app/build.gradle.kts`; AGP 9.1.0,
  Kotlin 2.4.0, Gradle 9.3.1, Java 17, core library desugaring.
- `gradle.properties` keeps `android.builtInKotlin=false` and `android.newDsl=false`: several Firebase
  plugins still apply the Kotlin Gradle plugin themselves.
- App name per flavor in `android/app/src/{production,staging}/res/values/strings.xml`
  (`resValue` and the manifest `package=` attribute are gone); flavor dimension `default`.
- Release signing reads `android/key.properties` if present, otherwise uses the debug keys.
- `gradlew` and the wrapper jar are no longer committed; Flutter regenerates them.

## 6. iOS

- Deployment target iOS 15.0; `AppDelegate` uses `FlutterImplicitEngineDelegate` and a
  `SceneDelegate` (UIScene lifecycle, `UIApplicationSceneManifest` in `Info.plist`).
- **Swift Package Manager only.** CocoaPods is removed (no `Podfile`). When upgrading an existing
  checkout, delete `ios/Pods` (or run `pod deintegrate`) — stale Firebase pods otherwise clash with
  the Firebase Swift package ("Redefinition of module 'Firebase'").
- Universal app (iPhone + iPad); six build configurations (`{Debug,Profile,Release}-{Production,Staging}`)
  with per-flavor xcconfigs in `ios/Flutter/`.
- `Runner.entitlements` with `aps-environment` and `UIBackgroundModes` (fetch, remote-notification)
  for push. Set your `DEVELOPMENT_TEAM` to sign for devices.
- `ios/Staging/GoogleService-Info.plist` is a placeholder built from `lib/firebase_options_staging.dart`:
  replace it with the file from the Firebase console.

## v2.0.0 → v2.1.0

v2.1.0 only adds the Claude Code MCP setup; app code and packages are unchanged. To adopt it, copy
`.mcp.json`, `tool/mcp/` and `.claude/settings.json` from the template and install the CLI once with
`dart install bond_cli` (0.2.0 or newer). See "Claude Code and MCP" in the README.

## Rollback

- Template: `git checkout v1.0.0` and switch back to your previous Flutter version.
- Packages: pin the previous versions; pub.dev keeps them all.
- CLI: `dart pub global activate bond_cli 0.0.4+3`, or bond_cli 0.1.x with `--ref v1.0.0`.
