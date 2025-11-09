import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFFBFA),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFE74C3C),
      primaryContainer: Color(0xFFFFDAD4),
      secondary: Color(0xFFFF8C42),
      surface: Color(0xFFFFF5F3),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF1B1B1B),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFF8A80),
      primaryContainer: Color(0xFF4A1E1C),
      secondary: Color(0xFFFFB74D),
      surface: Color(0xFF1A0E0D),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
    ),
  );
}
