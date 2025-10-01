import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onDislike;
  final VoidCallback onFavorite;
  final VoidCallback onLike;

  const ActionButtons({
    super.key,
    required this.onDislike,
    required this.onFavorite,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    // Récupérer la palette courante depuis AppProvider pour que les couleurs
    // changent dynamiquement lorsque le thème est modifié.
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          icon: Icons.close,
          iconColor: palette.red,
          size: 60,
          borderColor: palette.white30,
          backgroundColor: palette.card,
          onPressed: onDislike,
        ),
        const SizedBox(width: 32),
        _buildActionButton(
          icon: Icons.star,
          iconColor: palette.yellow,
          size: 70,
          borderColor: palette.white30,
          backgroundColor: palette.card,
          onPressed: onFavorite,
        ),
        const SizedBox(width: 32),
        _buildActionButton(
          icon: Icons.favorite,
          iconColor: palette.accentGreen,
          size: 60,
          borderColor: palette.white30,
          backgroundColor: palette.card,
          onPressed: onLike,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color iconColor,
    required double size,
    required Color borderColor,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(size / 2),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}