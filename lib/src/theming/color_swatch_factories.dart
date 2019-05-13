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
