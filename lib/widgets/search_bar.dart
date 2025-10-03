import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';
import '../L10n/app_localizations.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  const SearchBarWidget({super.key, this.onChanged});


  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String _query = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;
    final appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);

    return TextField(
      controller: _controller,
      onChanged: (value) {
        setState(() => _query = value);
        widget.onChanged?.call(value);
      },
      style: TextStyle(color: palette.white, fontSize: 16),
      cursorColor: palette.accentGreen,
      decoration: InputDecoration(
        label: Text(appLocalizations.search),
        hintStyle: TextStyle(color: palette.white60),
        prefixIcon: Icon(Icons.search, color: palette.accentGreen),
        filled: true,
        fillColor: palette.card,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.accentGreen, width: 2),
        ),
        suffixIcon: _query.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: palette.white60),
                onPressed: () {
                  _controller.clear();
                  setState(() => _query = '');
                  widget.onChanged?.call('');
                },
              )
            : null,
      ),
    );
  }
}

