// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_page_title => 'Login';

  @override
  String get filed_name_label => 'Name';

  @override
  String get filed_email_label => 'Email';

  @override
  String get filed_password_label => 'Password';

  @override
  String get filed_confirm_password_label => 'Confirm Password';

  @override
  String get field_validator_required => 'Field is required';

  @override
  String get field_validator_email => 'Invalid email address';

  @override
  String get field_validator_password =>
      'Password must be at least 6 characters long';

  @override
  String get field_validator_confirm_password => 'Passwords do not match';

  @override
  String get field_login =>
      'There was an error logging in, please try again later';

  @override
  String get login_page_login_button => 'Login';

  @override
  String get login_page_not_have_account => 'Don\'t have an account?';

  @override
  String get login_page_new_account_button => ' Create an account ';

  @override
  String get register_page_title => 'New Account';

  @override
  String get login_page_register_button => 'Register';

  @override
  String get home_page_title => 'BOND';

  @override
  String get notification_page_title => 'Notifications Center';

  @override
  String get popup_menu_language_title => 'Change Language';

  @override
  String get popup_menu_theme => 'Change Theme';

  @override
  String get popup_menu_logout => 'Logout';

  @override
  String get popup_menu_notification_center => 'Notifications Center';

  @override
  String get navigation_bar_home => 'Home';

  @override
  String get navigation_bar_collections => 'Collections';

  @override
  String get navigation_bar_more => 'More';

  @override
  String get update_app => 'It\'s time to update';

  @override
  String get update_app_text =>
      'To receive all new updates, update the Bond app';

  @override
  String get update_app_now => 'Update now';

  @override
  String get share_post_image => 'Share image';
}
