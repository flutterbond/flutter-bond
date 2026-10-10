import 'package:material_ui/material_ui.dart';

import 'app_text_theme.dart';

ThemeData appDarkThemeData() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      primary: Color.fromRGBO(50, 45, 120, 1),
      secondary: Color.fromRGBO(34, 193, 224, 1),
      surface: Colors.white54,
      error: Color.fromRGBO(241, 95, 109, 1),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color.fromRGBO(9, 35, 55, 1),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),

    /// AppBar theme
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(9, 35, 55, 1),
      elevation: 0,
      titleTextStyle: appTextTheme.headlineSmall?.copyWith(
        color: const Color.fromRGBO(34, 193, 224, 1),
        fontWeight: FontWeight.w700,
      ),
    ),

    tabBarTheme: const TabBarThemeData(
      labelColor: Color.fromRGBO(34, 193, 224, 1),
      unselectedLabelColor: Colors.white,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(9, 35, 55, 1),
      selectedItemColor: Color.fromRGBO(34, 193, 224, 1),
      unselectedItemColor: Colors.white,
    ),

    /// Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 48),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(50, 45, 120, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
    ),

    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: appTextTheme.titleSmall?.copyWith(
        color: Colors.white,
      ),
      color: const Color.fromRGBO(9, 35, 55, 1),
    ),

    /// Text theme
    textTheme: appTextTheme,

    inputDecorationTheme: InputDecorationThemeData(
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(241, 95, 109, 1),
          width: 1,
        ),
      ),
      floatingLabelStyle: appTextTheme.labelLarge?.copyWith(
        color: Colors.white,
      ),
      labelStyle: appTextTheme.labelLarge?.copyWith(
        color: Colors.white,
      ),
      isDense: true,
      iconColor: const Color.fromRGBO(34, 193, 224, 1),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(34, 193, 224, 1),
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(50, 45, 120, 1),
        ),
      ),
    ),
    bottomAppBarTheme:
        const BottomAppBarThemeData(color: Color.fromRGBO(9, 35, 55, 1)),
  );
}
