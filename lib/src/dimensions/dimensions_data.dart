import 'package:meta/meta.dart';

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
class DimensionsData implements Alignable {
  DimensionsData({this.scale = 1, this.grid = 4});

  double scale;

  /// The base grid unit that gets scaled by [scaling].
  final double grid;

  /// Returns a value that aligns on the [grid].
  /// You can specify the size of the value by adjusting [scale].
  /// The default [scale] is 1.
  Dimen onGrid([double scale = 1]) => Dimen(data: this, value: grid * scale);

  Dimen scaled(double value) => Dimen(data: this, value: value * scale);

  //Dimen scaledJulian(double value) => ScaledDimension(this, value);

  // -----
  // Util
  // -----

  DimensionsData copyWith({double scale, double grid}) =>
      DimensionsData(scale: scale ?? this.scale, grid: grid ?? this.grid);
}

class BaseDimensionsData extends DimensionsData {
  /// Border radius scaled by 1.
  Dimen get borderRadiusSmall => onGrid(1);

  /// Border radius scaled by 2.
  Dimen get borderRadiusMedium => onGrid(2);

  /// Border radius scaled by 4.
  Dimen get borderRadiusBig => onGrid(4);

  /// Grid unit scaled by 1.
  Dimen get gridUnitTiny => onGrid(1);

  /// Grid unit scaled by 2.
  Dimen get gridUnitSmall => onGrid(2);

  /// Grid unit scaled by 4.
  Dimen get gridUnitMedium => onGrid(4);

  /// Grid unit scaled by 6.
  Dimen get gridUnitBig => onGrid(6);

  /// Grid unit scaled by 8.
  Dimen get gridUnitLarge => onGrid(8);

  Dimen get screenWidthMin => Dimen(data: this, value: 320);

  Dimen get screenWidthSmall => Dimen(data: this, value: 432);

  Dimen get screenWidthMedium => Dimen(data: this, value: 864);
}

abstract class Alignable {
  Dimen onGrid([double scale = 1]);
}

abstract class Scalable {
  Dimen scaled();
}

class Dimen implements Alignable, Scalable {
  final DimensionsData data;
  final double value;

  Dimen({@required this.data, @required this.value});

  Dimen onGrid([double scale = 1]) =>
      Dimen(data: data, value: data.grid * scale);

  Dimen scaled() => Dimen(data: data, value: value * data.scale);
}

/*class ScaledDimen implements Dimen {
  final DimensionsData parent;
  final double initialValue;

  ScaledDimen(this.parent, this.initialValue);

  @override
  double get value => initialValue * parent.scale;
}*/
