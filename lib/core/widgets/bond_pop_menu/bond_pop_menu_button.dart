import 'package:bond/core/app_localizations.dart';
import 'package:bond/features/app/app_providers.dart';
import 'package:bond/features/auth/auth.dart';
import 'package:bond_core/bond_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'bond_popup_menu_item.dart';

class BondPopMenuButton extends ConsumerWidget {
  const BondPopMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Menu>(
      onSelected: (Menu item) => _onSelected(ref, item),
      icon: const Icon(
        Icons.more_vert_rounded,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        BondPopupBondMenuItem(
          value: Menu.theme,
          icon: Icon(
            Icons.color_lens_rounded,
            color: context.colorScheme.onSurface,
          ),
          title: context.localizations.popup_menu_theme,
        ),
        BondPopupBondMenuItem(
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

  void _onSelected(WidgetRef ref, Menu item) {
    switch (item) {
      case Menu.theme:
        final theme = ref.read(themeProvider);
        final newThemeMode =
            theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
        ref.read(themeProvider.notifier).update(newThemeMode);
        break;
      case Menu.language:
        final local = ref.read(localProvider);
        final newLocale = local == const Locale('en')
            ? const Locale('ar')
            : const Locale('en');
        ref.read(localProvider.notifier).update(newLocale);
        break;
      case Menu.logout:
        ref.context.go('/login');
        break;
      case Menu.notifications:
        ref.context.push('/notifications');
        break;
    }
  }
}
