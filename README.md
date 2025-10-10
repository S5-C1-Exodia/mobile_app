# SwipeZ Mobile Application


---

## Sommaire

- [Présentation](#présentation)
- [Fonctionnalités](#fonctionnalités)
- [Architecture](#architecture)
- [Dépendances](#dépendances)
- [Structure du projet](#structure-du-projet)
- [Installation & Lancement](#installation--lancement)
- [Internationalisation](#internationalisation)
- [Thématisation](#thématisation)
- [Tests](#tests)
- [Contribuer](#contribuer)
- [Contact](#contact)

---

## Présentation

SwipeZ est une application mobile développée en Flutter permettant la gestion de playlists, l’authentification, la personnalisation du thème, et la navigation fluide entre différents écrans sur Spotify. Elle s’intègre dans l’écosystème Exodia.

---

## Fonctionnalités

- Authentification (connexion/déconnexion)
- Gestion et affichage de playlists
- Thème clair/sombre dynamique
- Navigation multi-écrans
- Support multilingue (internationalisation)
- Gestion d’état centralisée via Provider

---

## Architecture

L’application suit le modèle MVVM :

- **Model** : Représentation des données (ex : Playlist, Utilisateur)
- **View** : Widgets Flutter (UI)
- **ViewModel** : Logique métier, gestion d’état (ex : ConnexionVM)

La navigation est assurée par le `Navigator` de Flutter. L’état global (thème, utilisateur, etc.) est géré avec `Provider`.

---

## Dépendances

Principales dépendances utilisées :

- [`flutter`](https://flutter.dev/) : Framework principal
- [`provider`](https://pub.dev/packages/provider) : Gestion d’état
- [`http`](https://pub.dev/packages/http) : Requêtes réseau
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) : Stockage local
- [`intl`](https://pub.dev/packages/intl) : Internationalisation
- [`flutter_localizations`](https://docs.flutter.dev/accessibility-and-localization/internationalization) : Localisation Flutter
- [`equatable`](https://pub.dev/packages/equatable) : Comparaison d’objets
- [`json_annotation`](https://pub.dev/packages/json_annotation) : Sérialisation JSON

La liste complète est disponible dans le fichier `pubspec.yaml`.


---

## Installation & Lancement

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Un IDE compatible (Android Studio, VS Code, etc.)

### Installation

1. Clone le dépôt :
   ```sh
   git clone https://github.com/S5-C1-Exodia/mobile_app.git
   cd mobile_app
   

2. Installe les dépendances :
   ```sh
   flutter pub get
   ```
   
3. Lance l’application :
   ```sh
   flutter run
   ```



© 2025-2026 Exodia - Tous droits réservés.
