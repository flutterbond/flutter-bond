import 'package:bond/core/app_localizations.dart';
import 'package:bond/core/resources/app_keys.dart';
import 'package:bond/features/app/app_providers.dart';
import 'package:bond/features/auth/auth.dart';
import 'package:bond_core/bond_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'bond_popup_menu_item.dart';

class BondPopMenuButton extends ConsumerWidget {
  const BondPopMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Menu>(
      key: AppKeys.menuButton,
      onSelected: (Menu item) => _onSelected(context, ref, item),
      icon: const Icon(
        Icons.more_vert_rounded,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        BondPopupBondMenuItem(
          key: AppKeys.menuTheme,
          value: Menu.theme,
          icon: Icon(
            Icons.color_lens_rounded,
            color: context.colorScheme.onSurface,
          ),
          title: context.localizations.popup_menu_theme,
        ),
        BondPopupBondMenuItem(
          key: AppKeys.menuLanguage,
          value: Menu.language,
          icon: Icon(
            Icons.language,
            color: context.colorScheme.onSurface,
          ),
          title: context.localizations.popup_menu_language_title,
        ),
        BondPopupBondMenuItem(
          value: Menu.notifications,
          icon: Icon(
            Icons.notifications_rounded,
            color: context.colorScheme.onSurface,
          ),
          title: context.localizations.popup_menu_notification_center,
        ),
        if (Auth.check())
          BondPopupBondMenuItem(
            value: Menu.logout,
            icon: Icon(
              Icons.logout,
              color: context.colorScheme.onSurface,
            ),
            title: context.localizations.popup_menu_logout,
          ),
      ],
    );
  }

  void _onSelected(BuildContext context, WidgetRef ref, Menu item) {
    switch (item) {
      case Menu.theme:
        // Flip the brightness on screen, also while following the system.
        final newThemeMode = context.brightness == Brightness.dark
            ? ThemeMode.light
            : ThemeMode.dark;
        ref.read(themeProvider.notifier).update(newThemeMode);
        break;
      case Menu.language:
        final local = ref.read(localProvider);
        final newLocale = local.languageCode == 'ar'
            ? const Locale('en')
            : const Locale('ar');
        ref.read(localProvider.notifier).update(newLocale);
        break;
      case Menu.logout:
        context.go('/login');
        break;
      case Menu.notifications:
        context.push('/notifications');
        break;
    }
  }
}
