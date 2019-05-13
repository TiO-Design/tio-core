import 'package:flutter/material.dart';
import 'package:tio_core/src/util/type_utils.dart';

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

class TioTheme<T extends TioThemeData> extends InheritedWidget {
  final T theme;

  const TioTheme({Key key, @required this.theme, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  static T of<T extends TioThemeData>(BuildContext context) {
    var inheritedWidget = context
        .inheritFromWidgetOfExactType(typeOf<TioTheme<T>>()) as TioTheme<T>;

    return inheritedWidget.theme;
  }

  @override
  bool updateShouldNotify(TioTheme old) {
    return old.theme != theme;
  }
}

class TioThemeData {
  final ColorSwatch<int> accentColor;
  final ColorSwatch<int> surfaceColor;
  final ColorSwatch<int> disabledColor;

  final TextTheme textTheme;

  TioThemeData({
    @required this.accentColor,
    @required this.surfaceColor,
    @required this.disabledColor,
    @required this.textTheme,
  });

  // -----
  // Material theme
  // -----

  ThemeData asMaterialTheme() => ThemeData(
      accentColor: accentColor,
      cardColor: surfaceColor,
      disabledColor: disabledColor,
      textTheme: textTheme);
}
