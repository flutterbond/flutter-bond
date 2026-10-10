import 'package:bond/core/app_theme.dart';
import 'package:material_ui/material_ui.dart';

ThemeData appLightThemeData() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      primaryContainer: Color.fromRGBO(50, 45, 120, 1),
      primary: Color.fromRGBO(50, 45, 120, 1),
      secondary: Color.fromRGBO(34, 193, 224, 1),
      surface: Colors.black,
      error: Color.fromRGBO(241, 95, 109, 1),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onError: Colors.black,
      brightness: Brightness.light,
    ),
    brightness: Brightness.light,

    scaffoldBackgroundColor: Colors.white,

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.black,
    ),

    /// AppBar theme
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: appTextTheme.headlineSmall?.copyWith(
        color: const Color.fromRGBO(50, 45, 120, 1),
        fontWeight: FontWeight.w700,
      ),
      actionsIconTheme: const IconThemeData(
        color: Color.fromRGBO(50, 45, 120, 1),
      ),
      iconTheme: const IconThemeData(
        color: Color.fromRGBO(50, 45, 120, 1),
      ),
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
        color: Colors.black,
      ),
      color: Colors.white,
    ),

    /// Text theme
    textTheme: appTextTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color.fromRGBO(34, 193, 224, 1),
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(241, 95, 109, 1),
          width: 1,
        ),
      ),
      floatingLabelStyle: appTextTheme.labelLarge?.copyWith(
        color: const Color.fromRGBO(50, 45, 120, 1),
      ),
      isDense: true,
      iconColor: const Color.fromRGBO(34, 193, 224, 1),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromRGBO(50, 45, 120, 1),
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
  );
}
