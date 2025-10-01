import 'package:flutter/material.dart';

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  String get appTitle => 'SwipeZ';
  String get selectPlaylist => 'Sélectionnez une playlist';
  String get playlists => 'Playlists';
  String get songs => 'Sons';
  String get history => 'Historique';
  String get profile => 'Profil';
  String get outsideInTheNight => 'DEHORS DANS LA NIGHT';
  String get laylow => 'Laylow';
  String get dislike => 'Dislike';
  String get favorite => 'Favorite';
  String get like => 'Like';
  String get select => 'Sélectionner';
  String get tracks => 'morceaux';
  String get loadingPlaylists => 'Chargement des playlists...';
  String get errorLoadingPlaylists => 'Erreur lors du chargement des playlists';
  String get noPlaylistsFound => 'Aucune playlist trouvée';
  String get language => 'Langue';
  String get theme => 'Thème';
  String get light => 'Clair';
  String get dark => 'Sombre';
  String get french => 'Français';
  String get english => 'Anglais';
  String get close => 'Fermer';
  String get settings => 'Paramètres';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations();
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}