import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';
import '../widgets/search_bar.dart';
import '../L10n/app_localizations.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  final List<String> _allItems = const [
    'Laylow',
    'Damso',
    'PNL',
    'Booba',
    'SCH',
    'Ninho',
    'Orelsan',
    'Lomepal',
    'Kaaris',
    'Jul',
    'Soprano',
    'Vianney',
  ];

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;
    final appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);

    final filtered = _allItems
        .where((e) => e.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SearchBarWidget(
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      '${appLocalizations.search}: 0',
                      style: TextStyle(color: palette.white60),
                    ),
                  )
                : ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final name = filtered[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: palette.card,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person, color: palette.accentGreen),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                name,
                                style: TextStyle(
                                  color: palette.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}