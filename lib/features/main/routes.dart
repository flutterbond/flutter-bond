library;

import 'package:bond/features/main/presentation/main_page.dart';
import 'package:bond/features/more/presentation/more_page.dart';
import 'package:go_router/go_router.dart';

import '../post/presentations/posts_page.dart';

final mainRoutes = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return MainPage(body: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const PostsPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/more',
            builder: (context, state) => const MorePage(),
          ),
        ],
      ),
    ],
  ),
];
