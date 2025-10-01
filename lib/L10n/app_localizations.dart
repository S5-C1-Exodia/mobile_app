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
  String get playlists => _isEn ? 'Playlists' : 'Playlists';
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
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}