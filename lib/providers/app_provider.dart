import 'package:flutter/material.dart';

/// A provider class for managing the application's locale and theme mode.
///
/// This class extends [ChangeNotifier] to allow widgets to listen for changes
/// in the locale or theme mode. It provides methods to update these settings
/// and notifies listeners when changes occur.
class AppProvider with ChangeNotifier {
  Locale _locale = const Locale('fr');
  ThemeMode _themeMode = ThemeMode.dark;

  Locale get locale => _locale;

  ThemeMode get themeMode => _themeMode;

  /// Sets the application's locale and notifies listeners of the change.
  ///
  /// [locale]: The new [Locale] to apply.
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  /// Sets the application's theme mode and notifies listeners of the change.
  ///
  /// [mode]: The new [ThemeMode] to apply.
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  /// Toggles the theme mode between dark and light, and notifies listeners.
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }
}
