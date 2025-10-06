import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_app/screens/splash_screen.dart';
import 'package:mobile_app/screens/search_screen.dart';
import 'package:mobile_app/screens/playlist_screen.dart';
import 'package:mobile_app/screens/profile_screen.dart';
import 'package:mobile_app/screens/history_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import 'core/theme/palettes.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Log pour vérifier que MyApp.build est appelé quand la locale/theme change
    debugPrint('MyApp.build: locale=${Provider.of<AppProvider>(context).locale}, theme=${Provider.of<AppProvider>(context).themeMode}');
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
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      theme: themeData,
      routes: {
        '/search': (context) => const SearchScreen(),
        '/playlists': (context) => const PlaylistsScreen(),
        '/history': (context) => const HistoryScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      home: const SplashScreen(),
    );
  }
}