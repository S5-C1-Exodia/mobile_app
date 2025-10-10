import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import '../screens/playlist_screen.dart';
import 'login_button.dart';
import '../viewmodels/connexion_vm.dart';

class LoginScreenBody extends StatefulWidget {
  final AppPalette palette;
  final VoidCallback onToggleTheme;

  const LoginScreenBody({
    Key? key,
    required this.palette,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connexionVM = context.read<ConnexionVM>();
      connexionVM.onConnectionSuccess = _navigateToPlaylists;
      connexionVM.addListener(_checkForErrors);
    });
  }

  void _navigateToPlaylists() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlaylistScreen(
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

    return Center(
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
              await context.read<ConnexionVM>().connect();
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
    );
  }
}