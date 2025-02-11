library;

import 'package:bond/features/auth/auth.dart';
import 'package:bond_core/bond_core.dart';
import 'package:bond_notifications/bond_notifications.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presentations/ui/notifications_page.dart';

final notificationRoutes = [
  GoRoute(
    path: '/notifications',
    builder: (context, state) => NotificationsPage(
      notificationCenterProvider: sl<NotificationCenterProvider>(),
    ),
    redirect: (BuildContext context, GoRouterState state) =>
        Auth.check() ? null : '/login',
  ),
];
