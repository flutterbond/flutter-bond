import 'dart:developer';

import 'package:bond/features/auth/auth.dart';
import 'package:bond_core/bond_core.dart';
import 'package:bond_notifications/bond_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:universal_platform/universal_platform.dart';

class RunAppTasks extends RunTasks {
  @override
  Future<void> beforeRun(WidgetsBinding widgetsBinding) async {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    FlutterNativeSplash.remove();
  }

  @override
  Future<void> afterRun() async {
    if (UniversalPlatform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'Bond', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    sl<PushNotificationsProviders>().listen();
    if (Auth.check()) {
      sl<NotificationCenterProvider>().load();
      sl<NotificationCenterProvider>().listen();
      final firebaseMessaging =
          sl<PushNotificationProvider>(instanceName: 'firebase_messaging');
      final fcmToken = await firebaseMessaging.token;
      if (fcmToken != null) {
        // TODO: send fcm token to server
        log('fcm token $fcmToken', name: 'RunAppTasks');
      }
    }
  }

  @override
  void onError(Object error, StackTrace stack) {
    log('Error: $error', stackTrace: stack);
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  }
}
