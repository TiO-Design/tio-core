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
  final int gridUnit;

  double scaledGridUnit([double scale = 1]) => gridUnit * scale;

  DimensionsData({this.gridUnit = 4});
}
