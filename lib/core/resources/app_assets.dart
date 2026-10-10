import 'package:material_ui/material_ui.dart';

class AppImagesAssets {
  static const String logo = 'assets/images/app_logo.svg';
  static const String forceUpdate = 'assets/images/force_update.png';
  static const String _homeBondLight = 'assets/images/home_bond.png';
  static const String _homeBondDark = 'assets/images/home_bond_dark.png';

  static const String _homeBondArabicLight =
      'assets/images/home_bond_arabic.png';
  static const String _homeBondArabicDark =
      'assets/images/home_bond_arabic_dark.png';

  static String homeBond(Brightness mode, String locale) {
    if (mode == Brightness.light) {
      return locale == 'ar' ? _homeBondArabicLight : _homeBondLight;
    } else {
      return locale == 'ar' ? _homeBondArabicDark : _homeBondDark;
    }
  }
}
