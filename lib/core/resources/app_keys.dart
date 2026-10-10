import 'package:flutter/widgets.dart';

/// Keys of the widgets driven by the integration smoke test
/// (integration_test/smoke_test.dart).
class AppKeys {
  static const homeTab = Key('home_tab');
  static const moreTab = Key('more_tab');
  static const menuButton = Key('menu_button');
  static const menuTheme = Key('menu_theme');
  static const menuLanguage = Key('menu_language');

  static const postsPage = Key('posts_page');
  static const postsLoading = Key('posts_loading');
  static const postsGrid = Key('posts_grid');
  static const postsError = Key('posts_error');
  static const postDetailsPage = Key('post_details_page');
  static const shareButton = Key('share_button');
  static const morePage = Key('more_page');

  static const updateAppPage = Key('update_app_page');
  static const updateAppMessage = Key('update_app_message');

  static const loginEmailField = Key('login_email_field');
  static const loginPasswordField = Key('login_password_field');
  static const loginSubmitButton = Key('login_submit_button');
}
