import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import 'Screens/playlist_selection_screen.dart';
import 'core/theme/app_theme.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return MaterialApp(
          title: 'SwipeZ',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: appProvider.themeMode,
          locale: appProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr'),
            Locale('en'),
          ],
          home: PlaylistSelectionScreen(),
        );
      },
    );
  }
}