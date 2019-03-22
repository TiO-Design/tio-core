import 'package:flutter/material.dart';

/**
 * Feature/Ideas:
 *
 * Foundation:
 *    - lerp utils for animations
 *    - type adapter for material/cupertino
 *    - background color
 *    - add support for shaping
 *    - color for shapes/materials
 *    - IconTheme:
 *        - selected Color
 *        - unnselected Color
 *        - focus Color
 *    - TextTHeme:
 *        - font sizes
 *        - font color
 *        - font family
 *
 */


//ignore ugly draft
abstract class IconTheme {
  Color get unselected;

  Color get selected;

  Color get focused;
}

abstract class TextTheme {
  Color get title;

  Color get subtitle;
}

abstract class Theme {}

class MaterialTheme {
  final Color primary;
  final Color secondary;
  final Color accent;

  MaterialTheme({
    @required this.primary,
    @required this.secondary,
    @required this.accent,
  });
}