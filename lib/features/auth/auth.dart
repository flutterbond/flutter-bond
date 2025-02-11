library;

import 'package:bond_cache/bond_cache.dart';

import 'data/models/user.dart';

export 'data/models/user.dart';
export 'data/models/user_meta.dart';
export 'routes.dart';

class Auth {
  static bool check() => Cache.has('token');

  static User user() => Cache.get('user');

  static String token() => Cache.get('token');
}
