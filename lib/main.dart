import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import 'Screens/playlist_screen.dart';
import 'core/theme/palettes.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

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
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      theme: themeData,
      home: PlaylistsScreen(
        palette: currentPalette,
        onToggleTheme: appProvider.toggleTheme,
      ),
    );
  }
}