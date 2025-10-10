import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import '../screens/playlist_screen.dart';
import 'login_button.dart';
import '../viewmodels/connexion_vm.dart';

/// A stateful widget representing the body of the login screen.
///
/// Displays animated login options for Spotify and Apple Music.
/// Handles theme toggling, navigation on successful connection, and error display.
///
/// [palette] defines the color palette for the screen.
/// [onToggleTheme] is a callback to switch between light and dark themes.
class LoginScreenBody extends StatefulWidget {
  /// The color palette used for theming.
  final AppPalette palette;

  /// Callback to toggle the app theme.
  final VoidCallback onToggleTheme;

  /// Creates a [LoginScreenBody] widget.
  ///
  /// [palette] is required for theming.
  /// [onToggleTheme] is required for theme switching.
  const LoginScreenBody({
    Key? key,
    required this.palette,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

/// State class for [LoginScreenBody].
///
/// Manages connection events, error handling, and navigation.
class _LoginScreenBodyState extends State<LoginScreenBody> {
  @override
  void initState() {
    super.initState();
    // Set up listeners for connection success and error handling after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connexionVM = context.read<ConnexionVM>();
      connexionVM.onConnectionSuccess = _navigateToPlaylists;
      connexionVM.addListener(_checkForErrors);
    });
  }

  /// Navigates to the playlist screen upon successful connection.
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

  /// Displays an error message in a snackbar if an error occurs.
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
    // Remove listeners and callbacks to prevent memory leaks.
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
          // Animated cat login illustration.
          Lottie.asset(
            'assets/animations/cat_login.json',
            width: 180,
            height: 180,
            repeat: true,
          ),
          const SizedBox(height: 32),
          // Spotify login button.
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
          // Apple Music login button (disabled).
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