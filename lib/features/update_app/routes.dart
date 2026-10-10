library;

import 'package:bond/core/route_helpers.dart';
import 'package:go_router/go_router.dart';

import 'presentations/page/soft_update_page.dart';
import 'presentations/page/update_app_page.dart';

/// Location of the force update page showing [message].
String updateAppLocation(String message) =>
    Uri(path: '/update_app', queryParameters: {'message': message}).toString();

/// Location of the soft update sheet showing [message].
String softUpdateLocation(String message) =>
    Uri(path: '/soft_update', queryParameters: {'message': message})
        .toString();

final updateAppRoutes = [
  GoRoute(
    path: '/update_app',
    builder: (context, state) => UpdateAppPage(
      message: state.uri.queryParameters['message'] ?? '',
    ),
  ),
  GoRoute(
    path: '/soft_update',
    pageBuilder: (context, state) {
      return ModalBottomSheetPage(
        child: SoftUpdatePage(
          message: state.uri.queryParameters['message'] ?? '',
        ),
        isScrollControlled: true,
      );
    },
  ),
];
