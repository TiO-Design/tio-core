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
  DimensionsData({this.scale = 1, this.grid = 4});

  double scale;

  /// The base grid unit that gets scaled by [scaling].
  final double grid;

  /// Returns a value that aligns on the [grid].
  /// You can specify the size of the value by adjusting [scale].
  /// The default [scale] is 1.
  double onGrid([double scale = 1]) => grid * scale;

  double scaled(double value) => value * scale;

  //Dimen scaledJulian(double value) => ScaledDimension(this, value);

  // -----
  // Util
  // -----
  DimensionsData copyWith({double scale, double grid}) =>
      DimensionsData(scale: scale ?? this.scale, grid: grid ?? this.grid);
}

class BaseDimensionsData extends DimensionsData {
  /// Border radius scaled by 1.
  double get borderRadiusSmall => onGrid(1);

  /// Border radius scaled by 2.
  double get borderRadiusMedium => onGrid(2);

  /// Border radius scaled by 4.
  double get borderRadiusBig => onGrid(4);

  /// Grid unit scaled by 1.
  double get gridUnitTiny => onGrid(1);

  /// Grid unit scaled by 2.
  double get gridUnitSmall => onGrid(2);

  /// Grid unit scaled by 4.
  double get gridUnitMedium => onGrid(4);

  /// Grid unit scaled by 6.
  double get gridUnitBig => onGrid(6);

  /// Grid unit scaled by 8.
  double get gridUnitLarge => onGrid(8);

  double screenWidthMin = 320;
  double screenWidthSmall = 432;
  double screenWidthMedium = 864;
}

class ExampleDimensionsData extends BaseDimensionsData {
  double get fabSize => scaled(onGrid(4));

  double get paddingSmall => onGrid(2);
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
