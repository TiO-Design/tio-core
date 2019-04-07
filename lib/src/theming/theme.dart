import 'package:flutter/material.dart';

/**
 * Foundation:
 *    - lerp utils for animations
 *    - type adapter for material/cupertino
 *    - background color
 *    - add support for shaping
 *    - color for shapes/materials
 *
 *    - IconTheme:
 *        - selected Color
 *        - unselected Color
 *        - focus Color
 *    - TextTHeme:
 *        - font sizes
 *        - font color
 *        - font family
 *
 *        BaseTheme:
 *          - accentColor -> Shadable
 *          - surfaceColor -> Shadable
 *          - (disabledColor -> Color)
 *
 *          - textTheme
 *            - font color -> Shadable
 *            - font family
 */

class TioThemeData {
  final ColorSwatch<int> accentColor;
  final ColorSwatch<int> surfaceColor;
  final ColorSwatch<int> disabledColor;

  TioThemeData({
    @required this.accentColor,
    @required this.surfaceColor,
    @required this.disabledColor,
  });

  // -----
  // Material theme
  // -----

  ThemeData asMaterialTheme() => ThemeData(
      accentColor: accentColor,
      cardColor: surfaceColor,
      disabledColor: disabledColor);
}
