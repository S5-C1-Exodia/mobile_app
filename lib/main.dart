import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_app/models/daos/api_playlist_dao.dart';
import 'package:mobile_app/screens/splash_screen.dart';
import 'package:mobile_app/screens/search_screen.dart';
import 'package:mobile_app/screens/playlist_screen.dart';
import 'package:mobile_app/screens/profile_screen.dart';
import 'package:mobile_app/screens/history_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import 'core/theme/palettes.dart';
import 'package:mobile_app/models/daos/fake_user_dao.dart';
import 'package:mobile_app/viewmodels/connexion_vm.dart';
import 'package:mobile_app/viewmodels/playlists_vm.dart';

import 'models/daos/api_user_dao.dart';
// ou importe directement ton PlaylistsScreen si tu veux tester rapidement

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Crée et sauvegarde la session dans le même userDAO qui sera passé au DAO
  final userDAO = ApiUserDAO();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => ConnexionVM(userDAO)),

        // FutureProvider qui crée l'APIPlaylistDAO en utilisant userDAO
        FutureProvider<APIPlaylistDAO?>(
          create: (_) async {
            try {
              final dao = await APIPlaylistDAO.create(userDAO);
              return dao;
            } catch (e, stack) {
              print(stack);
              return null;
            }
          },
          initialData: null,
        ),

        // Proxy qui injecte le DAO dans le VM dès qu'il est disponible
        ChangeNotifierProxyProvider<APIPlaylistDAO?, PlaylistsVM>(
          create: (_) => PlaylistsVM(dao: null),
          update: (_, dao, vm) {
            vm = vm ?? PlaylistsVM(dao: dao);
            vm.updateDAO(dao);
            return vm;
          },
        ),
      ],
      child: const MyApp(), // garde ton MyApp existant
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Log pour vérifier que MyApp.build est appelé quand la locale/theme change
    debugPrint(
      'MyApp.build: locale=${Provider.of<AppProvider>(context).locale}, theme=${Provider.of<AppProvider>(context).themeMode}',
    );
    final appProvider = Provider.of<AppProvider>(context);
    final isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette currentPalette = isDark ? paletteDark : paletteLight;

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
