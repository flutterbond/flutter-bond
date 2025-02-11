library;

import 'presentation/login_page.dart';
import 'presentation/register_page.dart';

import 'package:go_router/go_router.dart';

final authRoutes = [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterPage(),
  ),
];
