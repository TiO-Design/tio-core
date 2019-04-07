import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

ColorSwatch<int> constantSwatchFromColor(Color color) => ColorSwatch(
      color.value,
      {
        50: Color(color.value),
        100: Color(color.value),
        200: Color(color.value),
        300: Color(color.value),
        400: Color(color.value),
        500: Color(color.value),
        600: Color(color.value),
        700: Color(color.value),
        800: Color(color.value),
        900: Color(color.value),
      },
    );

//TODO (julian) implement or remove
ColorSwatch<int> linearSwatchFromColor(Color color) =>
    throw Exception("not implemented");

//TODO (julian) implement or remove
ColorSwatch<int> curvedSwatchFromColor(Color color, Curve curve) =>
    throw Exception("not implemented");
