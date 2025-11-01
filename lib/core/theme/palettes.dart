import 'package:flutter/material.dart';
import '../constants/colors_clear.dart';
import '../constants/colors_dark.dart';

/// A class that defines a color palette for the application.
///
/// Contains all the main colors used throughout the app, such as background,
/// card, accent, and various shades of white, red, and yellow.
class AppPalette {
  final Color background;
  final Color card;
  final Color accentGreen;
  final Color white;
  final Color white70;
  final Color white60;
  final Color white30;
  final Color red;
  final Color yellow;

  /// Creates an [AppPalette] with the specified colors.
  ///
  /// All parameters are required and define the color scheme for the palette.
  const AppPalette({
    required this.background,
    required this.card,
    required this.accentGreen,
    required this.white,
    required this.white70,
    required this.white60,
    required this.white30,
    required this.red,
    required this.yellow,
  });
}

/// The color palette for the dark theme.
///
/// Uses colors defined in [AppColorsDark].
const AppPalette paletteDark = AppPalette(
  background: AppColorsDark.background,
  card: AppColorsDark.card,
  accentGreen: AppColorsDark.accentGreen,
  white: AppColorsDark.white,
  white70: AppColorsDark.white70,
  white60: AppColorsDark.white60,
  white30: AppColorsDark.white30,
  red: AppColorsDark.red,
  yellow: AppColorsDark.yellow,
);

/// The color palette for the light theme.
///
/// Uses colors defined in [AppColorsClear].
const AppPalette paletteLight = AppPalette(
  background: AppColorsClear.background,
  card: AppColorsClear.card,
  accentGreen: AppColorsClear.accentPink,
  white: AppColorsClear.white,
  white70: AppColorsClear.white70,
  white60: AppColorsClear.white60,
  white30: AppColorsClear.white30,
  red: AppColorsClear.red,
  yellow: AppColorsClear.yellow,
);
