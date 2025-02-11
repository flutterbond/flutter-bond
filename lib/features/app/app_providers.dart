library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifiers/local_notifier.dart';
import 'notifiers/theme_notifier.dart';

export 'notifiers/local_notifier.dart';
export 'notifiers/theme_notifier.dart';

final localProvider = NotifierProvider<LocalNotifier, Locale>(() {
  return LocalNotifier();
});

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});
