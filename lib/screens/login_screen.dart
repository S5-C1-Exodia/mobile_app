import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import 'playlist_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/login_button.dart';
import '../viewmodels/connexion_vm.dart';

class LoginScreen extends StatefulWidget {
  final AppPalette palette;
  final VoidCallback onToggleTheme;

  const LoginScreen({
    Key? key,
    required this.palette,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // Configurer le callback de navigation dans le ViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connexionVM = context.read<ConnexionVM>();

      // Le VM appellera ce callback quand la connexion réussit
      connexionVM.onConnectionSuccess = _navigateToPlaylists;

      // Écouter les erreurs
      connexionVM.addListener(_checkForErrors);
    });
  }

  void _navigateToPlaylists() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlaylistsScreen(
            palette: widget.palette,
            onToggleTheme: widget.onToggleTheme,
          ),
        ),
      );
    }
  }

  void _checkForErrors() {
    final connexionVM = context.read<ConnexionVM>();
    if (connexionVM.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(connexionVM.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    final connexionVM = context.read<ConnexionVM>();
    connexionVM.removeListener(_checkForErrors);
    connexionVM.onConnectionSuccess = null;
    super.dispose();
  }

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
              text: appLocalizations?.loginSpotify ?? 'Connexion à Spotify',
              color: Colors.green,
              onPressed: () async {
                // Simplement lancer la connexion
                await context.read<ConnexionVM>().connect();
                // La navigation se fera automatiquement via le listener
              },
              imageAsset: 'assets/images/logo_spotify.png',
              enabled: true,
            ),
            const SizedBox(height: 24),
            LoginButton(
              text: appLocalizations?.loginAppleMusic ?? 'Connexion à Apple Music',
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