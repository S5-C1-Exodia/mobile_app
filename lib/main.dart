import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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

import 'models/daos/fake_playlist_dao.dart';
import 'models/daos/api_user_dao.dart';
import 'models/daos/interfaces/i_playlist_dao.dart';

/// Entry point of the application.
/// Initializes required DAOs and sets up providers for state management.
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // User DAO required for ConnexionVM.
  final userDAO = ApiUserDAO();

  runApp(
    MultiProvider(
      providers: [
        // Provides the app-wide state (theme, locale, etc.).
        ChangeNotifierProvider(create: (_) => AppProvider()),
        // Provides the connection view model.
        ChangeNotifierProvider(create: (_) => ConnexionVM(userDAO)),
        // Provides a fake playlist DAO for testing/demo purposes.
        Provider<IPlaylistDAO>(
          create: (_) => FakePlaylistDAO(),
        ),
        // Provides the playlists view model, updating its DAO when needed.
        ChangeNotifierProxyProvider<IPlaylistDAO, PlaylistsVM>(
          create: (context) => PlaylistsVM(dao: context.read<IPlaylistDAO>()),
          update: (context, dao, vm) {
            vm!.updateDAO(dao);
            return vm;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

/// Root widget of the application.
///
/// Sets up theming, localization, and navigation routes.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the app provider for theme and locale.
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette currentPalette = isDark ? paletteDark : paletteLight;

    // Configure theme data based on current theme.
    final ThemeData themeData = (isDark ? ThemeData.dark() : ThemeData.light())
        .copyWith(
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