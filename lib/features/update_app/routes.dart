library;

import 'package:bond/core/route_helpers.dart';
import 'package:go_router/go_router.dart';

import 'presentations/page/soft_update_page.dart';
import 'presentations/page/update_app_page.dart';

final updateAppRoutes = [
  GoRoute(
    path: '/update_app',
    builder: (context, state) => UpdateAppPage(
      message: state.uri.queryParameters['message'] as String,
    ),
  ),
  GoRoute(
    path: '/soft_update',
    pageBuilder: (context, state) {
      return ModalBottomSheetPage(
        child: SoftUpdatePage(
          message: state.uri.queryParameters['message'] as String,
        ),
        isScrollControlled: true,
      );
    },
  ),
];
