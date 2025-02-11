import 'package:bond_cache/bond_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => XThemeMode.fromValue(
        Cache.get(
          'theme',
          defaultValue: ThemeMode.system.value,
        ),
      );

  void update(ThemeMode themeMode) {
    Cache.put('theme', themeMode.value);
    state = themeMode;
  }
}

extension XThemeMode on ThemeMode {
  String get value {
    switch (this) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
    }
  }

  static ThemeMode fromValue(String value) {
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}
