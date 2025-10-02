import 'package:flutter/material.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import 'playlist_screen.dart';
import '../widgets/custom_app_bar.dart';

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
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(titleKey: appLocalizations?.login ?? 'Connexion'),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PlaylistsScreen(
                  palette: palette,
                  onToggleTheme: onToggleTheme,
                ),
              ),
            );
          },
          child: Container(
            width: 120,
            height: 60,
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              appLocalizations?.loginButton ?? 'Se connecter',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
