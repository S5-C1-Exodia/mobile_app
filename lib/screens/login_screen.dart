import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import 'playlist_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                    builder: (context) => const PlaylistsScreen(),
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
