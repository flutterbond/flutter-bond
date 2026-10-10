// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login_page_title => 'تسجيل الدخول';

  @override
  String get filed_name_label => 'الاسم';

  @override
  String get filed_email_label => 'البريد الإلكتروني';

  @override
  String get filed_password_label => 'كلمة المرور';

  @override
  String get filed_confirm_password_label => 'تأكيد كلمة المرور';

  @override
  String get field_validator_required => 'الحقل مطلوب';

  @override
  String get field_validator_email => 'البريد الإلكتروني غير صحيح';

  @override
  String get field_validator_password =>
      'كلمة المرور يجب أن تكون أكثر من 6 أحرف';

  @override
  String get field_validator_confirm_password => 'كلمة المرور غير متطابقة';

  @override
  String get field_login => 'هناك خطأ في تسجيل الدخول يرجى المحاولة لاحقا';

  @override
  String get login_page_login_button => 'تسجيل الدخول';

  @override
  String get login_page_not_have_account => 'ليس لديك حساب؟';

  @override
  String get login_page_new_account_button => ' حساب جديد ';

  @override
  String get register_page_title => 'حساب جديد';

  @override
  String get login_page_register_button => 'تسجيل';

  @override
  String get home_page_title => 'BOND';

  @override
  String get notification_page_title => 'مركز التنبيهات';

  @override
  String get popup_menu_language_title => 'تغيير اللغة';

  @override
  String get popup_menu_theme => 'تغيير المظهر';

  @override
  String get popup_menu_logout => 'تسجيل الخروج';

  @override
  String get popup_menu_notification_center => 'مركز التنبيهات';

  @override
  String get navigation_bar_home => 'الرئيسية';

  @override
  String get navigation_bar_collections => 'المجموعات';

  @override
  String get navigation_bar_more => 'المزيد';

  @override
  String get update_app => 'حان وقت التحديث';

  @override
  String get update_app_text =>
      'ليصلك كل جديد يتم إضافته، قم بتحديث تطبيق راسل';

  @override
  String get update_app_now => 'تحديث الآن';

  @override
  String get share_post_image => 'مشاركة الصورة';
}
