import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @login_page_title.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_page_title;

  /// No description provided for @filed_name_label.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get filed_name_label;

  /// No description provided for @filed_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get filed_email_label;

  /// No description provided for @filed_password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get filed_password_label;

  /// No description provided for @filed_confirm_password_label.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get filed_confirm_password_label;

  /// No description provided for @field_validator_required.
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get field_validator_required;

  /// No description provided for @field_validator_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get field_validator_email;

  /// No description provided for @field_validator_password.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get field_validator_password;

  /// No description provided for @field_validator_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get field_validator_confirm_password;

  /// No description provided for @field_login.
  ///
  /// In en, this message translates to:
  /// **'There was an error logging in, please try again later'**
  String get field_login;

  /// No description provided for @login_page_login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_page_login_button;

  /// No description provided for @login_page_not_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_page_not_have_account;

  /// No description provided for @login_page_new_account_button.
  ///
  /// In en, this message translates to:
  /// **' Create an account '**
  String get login_page_new_account_button;

  /// No description provided for @register_page_title.
  ///
  /// In en, this message translates to:
  /// **'New Account'**
  String get register_page_title;

  /// No description provided for @login_page_register_button.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get login_page_register_button;

  /// No description provided for @home_page_title.
  ///
  /// In en, this message translates to:
  /// **'BOND'**
  String get home_page_title;

  /// No description provided for @notification_page_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications Center'**
  String get notification_page_title;

  /// No description provided for @popup_menu_language_title.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get popup_menu_language_title;

  /// No description provided for @popup_menu_theme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get popup_menu_theme;

  /// No description provided for @popup_menu_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get popup_menu_logout;

  /// No description provided for @popup_menu_notification_center.
  ///
  /// In en, this message translates to:
  /// **'Notifications Center'**
  String get popup_menu_notification_center;

  /// No description provided for @navigation_bar_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigation_bar_home;

  /// No description provided for @navigation_bar_collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get navigation_bar_collections;

  /// No description provided for @navigation_bar_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navigation_bar_more;

  /// No description provided for @update_app.
  ///
  /// In en, this message translates to:
  /// **'It\'s time to update'**
  String get update_app;

  /// No description provided for @update_app_text.
  ///
  /// In en, this message translates to:
  /// **'To receive all new updates, update the Bond app'**
  String get update_app_text;

  /// No description provided for @update_app_now.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get update_app_now;

  /// No description provided for @share_post_image.
  ///
  /// In en, this message translates to:
  /// **'Share image'**
  String get share_post_image;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
