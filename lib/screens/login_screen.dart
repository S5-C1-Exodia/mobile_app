import 'package:flutter/material.dart';
import '../core/theme/palettes.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  final AppPalette palette;
  final VoidCallback onToggleTheme;

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
