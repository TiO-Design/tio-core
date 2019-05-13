import 'package:flutter/material.dart';
import 'package:tio_core/src/util/type_utils.dart';

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
