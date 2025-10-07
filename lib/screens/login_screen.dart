import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import 'playlist_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/login_button.dart';
import '../viewmodels/connexion_vm.dart';

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
    final connexionVM = context.watch<ConnexionVM>();

    return Scaffold(
      appBar: CustomAppBar(titleKey: appLocalizations?.login ?? 'Connexion'),
      body: Center(
        child: connexionVM.isLoading
            ? const CircularProgressIndicator()
            : Column(
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
              text:
              appLocalizations?.loginSpotify ?? 'Connexion à Spotify',
              color: Colors.green,
              onPressed: () async {
                await connexionVM.connect();

                if (connexionVM.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(connexionVM.errorMessage!),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (connexionVM.isConnected) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistsScreen(
                        palette: palette,
                        onToggleTheme: onToggleTheme,
                      ),
                    ),
                  );
                }
              },
              imageAsset: 'assets/images/logo_spotify.png',
              enabled: true,
            ),
            const SizedBox(height: 24),
            LoginButton(
              text: appLocalizations?.loginAppleMusic ??
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
