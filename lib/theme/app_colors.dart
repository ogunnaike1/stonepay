import 'package:flutter/material.dart';

abstract final class AppColors {
  // Exact swatches sampled from the supplied StonePay palette.
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const paleBlue = Color(0xFFBACAE2);
  static const blue = Color(0xFF3760B2);
  static const deepBlue = Color(0xFF00126B);

  static const background = deepBlue;
  // Tonal blends of the palette blues give surfaces subtle depth.
  static const backgroundHighlight = Color(0xFF162F87);
  static const surface = Color(0xFF0B2279);
  static const primaryText = white;
  static const secondaryText = paleBlue;
  static const accent = blue;
  static const onAccent = white;
  static const interactiveText = paleBlue;
  static const logo = paleBlue;
  static const border = blue;
  static const disabledSurface = Color(0xFF233F86);
  static const disabledText = paleBlue;
  static const error = Color(0xFFFFA8A8);
}
