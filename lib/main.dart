import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import 'package:mobile_app/core/theme/palettes.dart';
import 'package:mobile_app/providers/app_provider.dart';
import 'package:mobile_app/viewmodels/connexion_vm.dart';
import 'package:mobile_app/viewmodels/playlists_vm.dart';

import 'package:mobile_app/screens/splash_screen.dart';
import 'package:mobile_app/screens/search_screen.dart';
import 'package:mobile_app/screens/playlist_screen.dart';
import 'package:mobile_app/screens/profile_screen.dart';
import 'package:mobile_app/screens/history_screen.dart';

import 'package:mobile_app/models/daos/api_user_dao.dart';
import 'package:mobile_app/models/daos/api_playlist_dao.dart';
import 'package:mobile_app/models/daos/interfaces/i_playlist_dao.dart';

import 'package:provider/provider.dart';

/// Point d’entrée principal de l’application.
///
/// Initialise les différents DAO et configure les providers pour la gestion d’état.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DAO utilisateur (utilisé par ConnexionVM et APIPlaylistDAO)
  final userDAO = ApiUserDAO();

  // On utilise ici directement l’APIPlaylistDAO
  final playlistDAO = APIPlaylistDAO(userDAO: userDAO);

  runApp(
    MultiProvider(
      providers: [
        // Provider global pour la gestion du thème et de la langue
        ChangeNotifierProvider(create: (_) => AppProvider()),

        // Provider pour la connexion utilisateur
        ChangeNotifierProvider(create: (_) => ConnexionVM(userDAO)),

        // Fournit le DAO des playlists (API dans ce cas)
        Provider<IPlaylistDAO>.value(value: playlistDAO),

        // Fournit le ViewModel des playlists, lié au DAO
        ChangeNotifierProxyProvider<IPlaylistDAO, PlaylistsVM>(
          create: (context) => PlaylistsVM(dao: playlistDAO),
          update: (context, dao, vm) {
            vm ??= PlaylistsVM(dao: dao);
            vm.updateDAO(dao);
            return vm;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

/// Widget racine de l’application.
///
/// Configure le thème, la localisation et les routes principales.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette currentPalette = isDark ? paletteDark : paletteLight;

    final ThemeData themeData = (isDark ? ThemeData.dark() : ThemeData.light()).copyWith(
      scaffoldBackgroundColor: currentPalette.background,
      appBarTheme: AppBarTheme(
        backgroundColor: currentPalette.background,
        elevation: 0,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: appProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr'), Locale('en')],
      theme: themeData,
      routes: {
        '/search': (context) => const SearchScreen(),
        '/playlists': (context) {
          final appProvider = Provider.of<AppProvider>(context);
          final bool isDark = appProvider.themeMode == ThemeMode.dark;
          final AppPalette palette = isDark ? paletteDark : paletteLight;
          return PlaylistScreen(
            onToggleTheme: appProvider.toggleTheme,
            palette: palette,
          );
        },
        '/history': (context) => const HistoryScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      home: SplashScreen(
        palette: currentPalette,
        onToggleTheme: appProvider.toggleTheme,
      ),
    );
  }
}
