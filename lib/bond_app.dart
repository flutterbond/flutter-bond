import 'package:bond/app/routes.dart';
import 'package:material_ui/material_ui.dart';
import 'package:bond/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_theme.dart';
import 'features/app/app_providers.dart';

class BondApp extends ConsumerWidget {
  const BondApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localProvider);
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: true,
      theme: appLightThemeData(),
      darkTheme: appDarkThemeData(),
      themeMode: theme,
      // Exposes the theme and localizations to dependencies that still import
      // package:flutter/material.dart. Remove once they all use material_ui.
      // ignore: deprecated_member_use
      builder: (context, child) => MaterialUiCompatibilityBridge(child: child!),
    );
  }
}
