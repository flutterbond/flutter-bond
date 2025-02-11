library;

import 'package:go_router/go_router.dart';

import 'data/models/post.dart';
import 'presentations/post_details_page.dart';

final postRoutes = [
  GoRoute(
    path: '/post/:id',
    builder: (context, state) => PostDetailsPage(
      id: state.pathParameters['id'].toString(),
      post: state.extra as Post?,
    ),
  ),
];
