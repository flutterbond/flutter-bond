import 'dart:io';

import 'package:bond/app/routes.dart';
import 'package:bond/core/resources/app_keys.dart';
import 'package:bond/features/post/presentations/views/post_item.dart';
import 'package:bond/features/update_app/routes.dart';
import 'package:bond/l10n/app_localizations.dart';
import 'package:bond/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';

/// Smoke test of the real app on a device or simulator:
///
/// ```sh
/// fvm flutter drive --driver=test_driver/integration_test.dart \
///   --target=integration_test/smoke_test.dart --flavor staging \
///   --dart-define-from-file=env.staging.json -d <device>
/// ```
///
/// Every step is saved as `build/screenshots/<platform>_<step>.png`. The
/// posts depend on the network, so both their data and their error state
/// pass. The app is left in the flipped theme and in Arabic (persisted),
/// which a relaunch can use to check persistence.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'app smoke test',
    timeout: const Timeout(Duration(minutes: 5)),
    (tester) async {
      var surfaceConverted = false;
      Future<void> screenshot(String step) async {
        if (Platform.isAndroid && !surfaceConverted) {
          await binding.convertFlutterSurfaceToImage();
          surfaceConverted = true;
        }
        await tester.pump();
        await binding.takeScreenshot(step);
      }

      Future<void> settle() => tester.pumpAndSettle(
            const Duration(milliseconds: 100),
            EnginePhase.sendSemanticsUpdate,
            const Duration(seconds: 15),
          );

      Future<void> waitFor(
        Finder finder, {
        Duration timeout = const Duration(seconds: 15),
      }) =>
          _pumpUntil(
            tester,
            () => finder.evaluate().isNotEmpty,
            timeout,
            '$finder',
          );

      Future<void> selectMenu(Key item) async {
        await tester.tap(find.byKey(AppKeys.menuButton));
        await settle();
        await tester.tap(find.byKey(item));
        await settle();
      }

      final postsPage = find.byKey(AppKeys.postsPage);
      final postsError = find.byKey(AppKeys.postsError);
      final grid = find.byKey(AppKeys.postsGrid);
      final posts = find.descendant(of: grid, matching: find.byType(PostItem));
      BuildContext home() => tester.element(postsPage);

      // 1. Splash -> Home.
      final testErrorHandler = FlutterError.onError;
      app.main();
      await waitFor(postsPage, timeout: const Duration(seconds: 60));
      // The app reports Flutter errors to Crashlytics; fail the test too.
      final appErrorHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        appErrorHandler?.call(details);
        testErrorHandler?.call(details);
      };

      // Posts: data or the error state (network dependent). Riverpod retries
      // a failing load for a while before it shows the error.
      await _pumpUntil(
        tester,
        () => grid.evaluate().isNotEmpty || postsError.evaluate().isNotEmpty,
        const Duration(minutes: 2),
        'the posts or their error state',
      );
      final hasPosts = posts.evaluate().isNotEmpty;
      await screenshot('01_home');

      if (hasPosts) {
        // 2. Open a post, then come back.
        await tester.tap(posts.first);
        await waitFor(find.byKey(AppKeys.postDetailsPage));
        await settle();
        expect(find.byKey(AppKeys.shareButton), findsOneWidget);
        await screenshot('02_post_details');
        goRouter.pop();
        await settle();
        expect(postsPage, findsOneWidget);

        // 3. Scrolling to the end loads the next page, if there is one. The
        // page ends with more posts, or with the error state when offline.
        final countBefore = posts.evaluate().length;
        await tester.drag(grid, const Offset(0, -3000));
        await tester.pump(const Duration(milliseconds: 500));
        await _pumpUntil(
          tester,
          () => find.byKey(AppKeys.postsLoadingMore).evaluate().isEmpty,
          const Duration(seconds: 30),
          'the next page',
        );
        await settle();
        if (postsError.evaluate().isEmpty) {
          expect(posts.evaluate().length, greaterThanOrEqualTo(countBefore));
        }
        await screenshot('03_load_more');
      }

      // 4. Bottom tabs.
      await tester.tap(find.byKey(AppKeys.moreTab));
      await waitFor(find.byKey(AppKeys.morePage));
      await settle();
      await screenshot('04_more_tab');
      await tester.tap(find.byKey(AppKeys.homeTab));
      await waitFor(postsPage);
      await settle();

      // 5. Theme: the menu flips the brightness.
      final brightness = Theme.of(home()).brightness;
      await selectMenu(AppKeys.menuTheme);
      await _pumpUntil(
        tester,
        () => Theme.of(home()).brightness != brightness,
        const Duration(seconds: 10),
        'the brightness to flip',
      );
      await settle();
      await screenshot('05_theme_flipped');

      // 6. Language: Arabic, right to left.
      bool isArabic() => Directionality.of(home()) == TextDirection.rtl;
      if (isArabic()) {
        await selectMenu(AppKeys.menuLanguage);
        await _pumpUntil(tester, () => !isArabic(), _localeTimeout, 'English');
      }
      await selectMenu(AppKeys.menuLanguage);
      await _pumpUntil(tester, isArabic, _localeTimeout, 'Arabic');
      await settle();
      final arabic = lookupAppLocalizations(const Locale('ar'));
      expect(find.text(arabic.navigation_bar_home), findsWidgets);
      await screenshot('06_arabic');

      // 7. The force update page shows the message passed in its location.
      const message = 'Smoke test: please update';
      goRouter.go(updateAppLocation(message));
      await waitFor(find.byKey(AppKeys.updateAppPage));
      await settle();
      expect(find.text(message), findsOneWidget);
      await screenshot('07_update_app');

      // 8. Login: submitting the empty form shows the validation errors.
      goRouter.go('/login');
      await waitFor(find.byKey(AppKeys.loginSubmitButton));
      await settle();
      await tester.tap(find.byKey(AppKeys.loginSubmitButton));
      await settle();
      String? errorText(Key field) => tester
          .widget<TextField>(
            find.descendant(
              of: find.byKey(field),
              matching: find.byType(TextField),
            ),
          )
          .decoration
          ?.errorText;
      expect(errorText(AppKeys.loginEmailField), isNotNull);
      expect(errorText(AppKeys.loginPasswordField), isNotNull);
      await screenshot('08_login_validation');
    },
  );
}

const _localeTimeout = Duration(seconds: 10);

/// Pumps frames until [condition] holds, failing after [timeout].
Future<void> _pumpUntil(
  WidgetTester tester,
  bool Function() condition,
  Duration timeout,
  String description,
) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      throw TestFailure('Timed out after $timeout waiting for $description');
    }
    await tester.pump(const Duration(milliseconds: 250));
  }
}
