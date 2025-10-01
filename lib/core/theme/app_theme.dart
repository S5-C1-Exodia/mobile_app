import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF1DB954),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: Color(0xFFF5F5F5),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF1DB954),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        elevation: 0,
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: Color(0xFF282828),
      ),
    );
  }
}