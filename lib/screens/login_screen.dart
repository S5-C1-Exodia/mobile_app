import 'package:flutter/material.dart';
import '../core/theme/palettes.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/login_screen_body.dart';

/// A stateless widget representing the login screen.
///
/// Displays a custom app bar and the login screen body.
/// Allows toggling the theme via [onToggleTheme].
class LoginScreen extends StatelessWidget {
  /// The color palette used for theming the screen.
  final AppPalette palette;

  /// Callback to toggle the app's theme.
  final VoidCallback onToggleTheme;

  /// Creates a [LoginScreen] widget.
  ///
  /// [palette] The color palette to use.
  /// [onToggleTheme] The callback to toggle the theme.
  const LoginScreen({
    Key? key,
    required this.palette,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleKey: 'Connexion'),
      body: LoginScreenBody(palette: palette, onToggleTheme: onToggleTheme),
    );
  }
}