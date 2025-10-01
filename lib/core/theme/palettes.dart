import 'package:flutter/material.dart';
import '../constants/colors_clear.dart';
import '../constants/colors_dark.dart';

class AppPalette {
  final Color background;
  final Color card;
  final Color accentGreen;
  final Color white;
  final Color white70;
  final Color white60;
  final Color white30;
  const AppPalette({
    required this.background,
    required this.card,
    required this.accentGreen,
    required this.white,
    required this.white70,
    required this.white60,
    required this.white30,
  });
}

const AppPalette paletteDark = AppPalette(
  background: AppColorsDark.background,
  card: AppColorsDark.card,
  accentGreen: AppColorsDark.accentGreen,
  white: AppColorsDark.white,
  white70: AppColorsDark.white70,
  white60: AppColorsDark.white60,
  white30: AppColorsDark.white30,
);

const AppPalette paletteLight = AppPalette(
  background: AppColorsClear.background,
  card: AppColorsClear.card,
  accentGreen: AppColorsClear.accentPink,
  white: AppColorsClear.white,
  white70: AppColorsClear.white70,
  white60: AppColorsClear.white60,
  white30: AppColorsClear.white30,
);
