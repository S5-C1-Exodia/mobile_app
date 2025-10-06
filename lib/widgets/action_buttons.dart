import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';

/// A widget that displays a row of three action buttons: Dislike, Favorite, and Like.
///
/// Each button is represented by an icon and triggers a callback when pressed.
/// The appearance of the buttons adapts to the current theme using [AppPalette].
///
/// Parameters:
/// - [onDislike]: Callback triggered when the Dislike button is pressed.
/// - [onFavorite]: Callback triggered when the Favorite button is pressed.
/// - [onLike]: Callback triggered when the Like button is pressed.
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
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

    // Use LayoutBuilder to adapt button sizes and spacing to available width
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;

        // Determine button size and spacing based on available width
        double size;
        double spacing;
        if (maxWidth >= 500) {
          size = 70;
          spacing = 32;
        } else if (maxWidth >= 360) {
          size = 60;
          spacing = 24;
        } else {
          size = 48;
          spacing = 16;
        }

        // Use Wrap so buttons wrap to next line instead of overflowing
        return Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            runSpacing: 12,
            children: [
              _buildActionButton(
                icon: Icons.close,
                iconColor: palette.red,
                size: size,
                borderColor: palette.white30,
                backgroundColor: palette.card,
                onPressed: onDislike,
              ),
              _buildActionButton(
                icon: Icons.star,
                iconColor: palette.yellow,
                size: size * 1.15, // favorite slightly larger
                borderColor: palette.white30,
                backgroundColor: palette.card,
                onPressed: onFavorite,
              ),
              _buildActionButton(
                icon: Icons.favorite,
                iconColor: palette.accentGreen,
                size: size,
                borderColor: palette.white30,
                backgroundColor: palette.card,
                onPressed: onLike,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds a circular action button with the given icon and styling.
  ///
  /// Parameters:
  /// - [icon]: The icon to display.
  /// - [iconColor]: The color of the icon.
  /// - [size]: The diameter of the button.
  /// - [borderColor]: The color of the button's border.
  /// - [backgroundColor]: The background color of the button.
  /// - [onPressed]: Callback triggered when the button is pressed.
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
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(child: Icon(icon, color: iconColor, size: size * 0.5)),
        ),
      ),
    );
  }
}
