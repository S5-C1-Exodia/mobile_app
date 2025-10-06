import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  bool get _isEn => locale.languageCode == 'en';

  String get appTitle => 'SwipeZ';
  String get selectPlaylist => _isEn ? 'Select a playlist' : 'Sélectionnez une playlist';
  String get playlists => _isEn ? 'My playlists' : 'Mes playlists';
  String get songs => _isEn ? 'Songs' : 'Sons';
  String get history => _isEn ? 'History' : 'Historique';
  String get profile => _isEn ? 'Profile' : 'Profil';
  String get outsideInTheNight => _isEn ? 'DEHORS DANS LA NIGHT' : 'DEHORS DANS LA NIGHT';
  String get laylow => _isEn ? 'Laylow' : 'Laylow';
  String get dislike => _isEn ? 'Dislike' : 'Dislike';
  String get favorite => _isEn ? 'Favorite' : 'Favorite';
  String get like => _isEn ? 'Like' : 'Like';
  String get select => _isEn ? 'Select' : 'Sélectionner';
  String get tracks => _isEn ? 'tracks' : 'morceaux';
  String get loadingPlaylists => _isEn ? 'Loading playlists...' : 'Chargement des playlists...';
  String get errorLoadingPlaylists => _isEn ? 'Error loading playlists' : 'Erreur lors du chargement des playlists';
  String get noPlaylistsFound => _isEn ? 'No playlists found' : 'Aucune playlist trouvée';
  String get language => _isEn ? 'Language' : 'Langue';
  String get theme => _isEn ? 'Theme' : 'Thème';
  String get light => _isEn ? 'Light' : 'Clair';
  String get dark => _isEn ? 'Dark' : 'Sombre';
  String get french => _isEn ? 'Français' : 'Français';
  String get english => _isEn ? 'English' : 'Anglais';
  String get close => _isEn ? 'Close' : 'Fermer';
  String get settings => _isEn ? 'Settings' : 'Paramètres';
  String get loginButton => _isEn ? 'Login' : 'Connexion';
  String get login => _isEn ? 'Login' : 'Connexion';
  String get logout => _isEn ? 'Logout' : 'Déconnexion';
  String get connectToAnotherApi => _isEn ? 'Connect to another API' : 'Se connecter à une autre API';
  String get search => _isEn ? 'Search' : 'Recherche';
  String get loginSpotify => _isEn ? 'Login with Spotify' : 'Se connecter avec Spotify';
  String get loginAppleMusic => _isEn ? 'Login with Apple Music' : 'Se connecter avec Apple Music';
}

/// A delegate class that loads and provides [AppLocalizations] for supported locales.
///
/// This delegate is used by Flutter's localization system to load the appropriate
/// [AppLocalizations] instance based on the user's locale.
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  /// Returns `true` if the given [locale] is supported.
  @override
  bool isSupported(Locale locale) => ['fr', 'en'].contains(locale.languageCode);

  /// Loads the [AppLocalizations] for the given [locale].
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  /// Determines whether the delegate should reload.
  ///
  /// Always returns `false` as reloading is not necessary.
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}