/// Holds the size and unit values for an app.
///
/// Use this class to configure a [Dimension] widget.
///
/// To obtain the current dimensions, use [Dimensions.of].
///
/// You can extend this class to to add additional values.
///
/// {@tool sample}
///
/// ```dart
/// class ExtendedDimensionsData extends DimensionsData {
///   final double additionalValue = 32.0;
/// }
/// ```
///
/// To obtain ExtendedDimensionsData, use [Dimensions.of] with
/// ExtendedDimensionsData as the generic type.
///
/// {@tool sample}
/// ```dart
/// Dimensions.of<ExtendedDimensionsData>(context).additionalValue;
/// ```
///
/// This assumes that you have a [Dimensions] ancestor somewhere in your
/// ancestor tree with the same generic type, else [DimensionsNotFound] will be
/// thrown.
///
/// {@tool sample}
/// ```dart
/// Dimensions<ExtendedDimensionsData>(
///   data: ExtendedDimensionsData(),
///   child: ...
/// )
/// ```
class DimensionsData {
  DimensionsData({this.scale = 1, this.gridSpacing = 4});

  final double fontSize = 16;

  double scale;

  /// The base grid unit that gets scaled by [scaling].
  final int gridSpacing;

  /// Returns a [gridUnit] that got scaled by [scale].
  /// The default [scale] is 2.
  ///
  double scaledGridUnit([double scale = 2]) => gridSpacing * scale;

  Dimen scaled(double value) => ScaledDimension(this, value);
}


class MyFancyDimens extends DimensionsData {
  double get fabSize => scaled(16).value;
  double get heightOfbutton => 16;
}

abstract class Dimen {
  double get value;
}

class ScaledDimension implements Dimen {
  final DimensionsData parent;
  final double initialValue;

  ScaledDimension(this.parent, this.initialValue);

  @override
  double get value => initialValue * parent.scale;
}


class MyDimensions {
  MyDimensions({this.fontSize = 16, this.gridSpacing = 0.5});
  final double fontSize;
  final double gridSpacing;
}