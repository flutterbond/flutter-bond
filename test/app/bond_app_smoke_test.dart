import 'package:bond/app/routes.dart';
import 'package:bond/bond_app.dart';
import 'package:bond/core/resources/app_keys.dart';
import 'package:bond/features/post/data/api.dart';
import 'package:bond/features/post/data/models/post.dart';
import 'package:bond/features/post/presentations/providers/posts_provider.dart';
import 'package:bond/l10n/app_localizations.dart';
import 'package:bond_cache/bond_cache.dart';
import 'package:bond_core/bond_core.dart';
import 'package:bond_network/bond_network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class _FakePostsApi extends Fake implements PostsApi {
  @override
  Future<ListResponse<Post>> posts([String? url]) async =>
      const ListResponse<Post>(data: []);
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  setUp(() async {
    await sl.reset();
    sl.registerSingleton<CacheDriver>(InMemoryCacheDriver());
    Cache.cacheDriver = BondCache(driver: sl<CacheDriver>());
    await Cache.put('language', 'en');
    goRouter.go('/home');
  });

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postsProvider.overrideWith(() => PostController(_FakePostsApi())),
        ],
        child: const BondApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  BuildContext homeContext(WidgetTester tester) =>
      tester.element(find.byKey(AppKeys.postsGrid));

  testWidgets('renders Home in English', (tester) async {
    await pumpApp(tester);

    final strings = lookupAppLocalizations(const Locale('en'));
    expect(find.byKey(AppKeys.postsGrid), findsOneWidget);
    expect(find.text(strings.navigation_bar_home), findsWidgets);
    expect(Directionality.of(homeContext(tester)), TextDirection.ltr);
  });

  testWidgets('renders Home in Arabic, right to left', (tester) async {
    await Cache.put('language', 'ar');
    await pumpApp(tester);

    final strings = lookupAppLocalizations(const Locale('ar'));
    expect(find.byKey(AppKeys.postsGrid), findsOneWidget);
    expect(find.text(strings.navigation_bar_home), findsWidgets);
    expect(Directionality.of(homeContext(tester)), TextDirection.rtl);
  });

  testWidgets('theme menu flips the brightness', (tester) async {
    await pumpApp(tester);
    Brightness brightness() => Theme.of(homeContext(tester)).brightness;
    expect(brightness(), Brightness.light);

    await tester.tap(find.byKey(AppKeys.menuButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(AppKeys.menuTheme));
    await tester.pumpAndSettle();

    expect(brightness(), Brightness.dark);
    expect(Cache.get<String>('theme'), 'dark');
  });

  testWidgets('/update_app?message=x shows the message', (tester) async {
    await pumpApp(tester);

    goRouter.go('/update_app?message=x');
    await tester.pumpAndSettle();

    expect(find.byKey(AppKeys.updateAppPage), findsOneWidget);
    expect(find.text('x'), findsOneWidget);
  });
}
