import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import 'playlist_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/login_button.dart';

/// A stateless widget that displays the login screen for the application.
///
/// The screen includes:
/// - A custom app bar with a localized title.
/// - An animated Lottie asset (cat animation) as a visual element.
/// - Two login buttons: one for Spotify (enabled) and one for Apple Music (disabled).
///   - The Spotify button navigates to the [PlaylistsScreen] upon successful login.
///   - The Apple Music button is currently disabled.
/// - The appearance adapts to the provided color palette and localization.
///
/// Parameters:
/// - [palette]: The color palette to use for theming.
/// - [onToggleTheme]: Callback to toggle the app theme.
///
/// Usage:
/// ```dart
/// LoginScreen(palette: palette, onToggleTheme: onToggleTheme)
/// ```
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/cat_login.json',
              width: 180,
              height: 180,
              repeat: true,
            ),
            const SizedBox(height: 32),
            LoginButton(
              text: appLocalizations?.loginSpotify ?? 'Connexion à Spotify',
              color: Colors.green,
              onPressed: () {
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
              imageAsset: 'assets/images/logo_spotify.png',
              enabled: true,
            ),
            const SizedBox(height: 24),
            LoginButton(
              text:
                  appLocalizations?.loginAppleMusic ??
                  'Connexion à Apple Music',
              color: Colors.grey,
              onPressed: () {},
              imageAsset: 'assets/images/logo_apple.png',
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
