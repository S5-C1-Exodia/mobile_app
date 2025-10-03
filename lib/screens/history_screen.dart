import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/recent_playlists.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

    return Scaffold(
      backgroundColor: palette.background,
      appBar: const CustomAppBar(titleKey: 'history'),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: RecentPlaylists(),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 2,
        onTap: (i) {},
      ),
    );
  }
}

