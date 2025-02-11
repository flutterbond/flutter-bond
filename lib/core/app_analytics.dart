library;

import 'dart:developer';

import 'package:bond_app_analytics/bond_app_analytics.dart';
import 'package:bond_core/bond_core.dart';

import '../config/analytics.dart';

export 'app_analytics_providers/firebase_analytics_provider.dart';

class AppAnalytics {
  static void fire(AnalyticsEvent event) {
    AnalyticsConfig.providers.forEach(
      (key, value) {
        final driver = value['driver'] as String;
        log('AppAnalytics provider $driver'
            ' fire log ${event.key} and params ${event.params}');
        sl<AnalyticsProvider>(instanceName: driver).log(event);
      },
    );
  }

  static void setUserId(int userId) {
    AnalyticsConfig.providers.forEach(
          (key, value) {
        final driver = value['driver'] as String;
        log('AppAnalytics provider $driver'
            ' set user userId $userId');
        sl<AnalyticsProvider>(instanceName: driver).setUserId(userId);
      },
    );
  }

  static void setUserAttributes(Map<String, dynamic> attributes) {
    AnalyticsConfig.providers.forEach(
          (key, value) {
        final driver = value['driver'] as String;
        log('AppAnalytics provider $driver'
            ' set user attributes $attributes');
        sl<AnalyticsProvider>(instanceName: driver).setUserAttributes(attributes);
      },
    );
  }
}
