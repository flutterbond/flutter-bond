import 'dart:ui';

import 'package:bond_cache/bond_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalNotifier extends Notifier<Locale> {
  @override
  Locale build() => Locale(
        Cache.get(
          'language',
          defaultValue: PlatformDispatcher.instance.locale.languageCode,
        ),
      );

  void update(Locale locale) {
    Cache.put('language', locale.languageCode);
    state = locale;
  }
}
