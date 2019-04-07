import 'package:meta/meta.dart';
import 'package:tio_core/tio_core.dart';

/// Holds the size and unit values for an app.
///
/// Use this class to configure a [Dimension] widget.
///
/// To obtain the current dimensions, use [Dimensions.of].
///
/// You can extend this class to to add additional values.
///
/// Take a look at [Dimensions.of] for more information on how to obtain
/// [DimensionsData].
class DimensionsData {
  DimensionsData({this.scale = 1, this.grid = 4});

  /// The scale that gets used inside [scaled] and [unscaled]
  /// for scaling or unscaling dimensions.
  double scale;

  /// Specifies the spacing of your apps grid which is used to align your UI Elements.
  ///
  /// Use [onGrid] to get dimensions that align on the grid.
  final double grid;

  /// Returns a value that aligns on the [grid].
  ///
  /// You can specify the size of the value by adjusting [multiplier].
  /// Set [scaled] to true if you want the value to scale by [scale].
  double onGrid(double multiplier, {bool scaled = false}) {
    var value = grid * multiplier;
    if (scaled) {
      value = value * scale;
    }

    return value;
  }

  /// Scales [value] by [scale].
  ///
  /// Make sure [value] has been scaled before because this method will always scale.
  @experimental
  double scaled(double value) => value * scale;

  /// Unscales [value] by [scale].
  ///
  /// Make sure [value] has been scaled before because this method will always unscale.
  @experimental
  double unscaled(double value) => value / scale;

  // -----
  // Util
  // -----

  /// Creates a new instance and updates the given values.
  /// Be aware that null values will always be replaced by the current value of this instance.
  DimensionsData copyWith({double scale, double grid}) =>
      DimensionsData(scale: scale ?? this.scale, grid: grid ?? this.grid);
}

/// Empty dimensions that can be used if not dimensions are required
class EmptyDimensionsData extends DimensionsData {}

// -----
// Experimental api
// -----

/*
@experimental
class Dimensions {
  final double scale;

  Dimensions(this.scale);
}

@experimental
abstract class Dimension {
  double get value;
}

@experimental
class _ScaledDimension implements Dimension {
  final Dimensions parent;
  final double initialValue;

  _ScaledDimension(this.parent, this.initialValue);

  @override
  double get value => this.parent.scale * value;
}


@experimental
class _PlatformAwareDimension implements Dimension {
  final BuildContext context;

  final double iOS;
  final double android;
  final double fuchsia;
  final double web;
  final double desktop;
  final double fallback;

  _PlatformAwareDimension(this.context,
      this.iOS,
      this.android,
      this.fuchsia,
      this.web,
      this.desktop,
      this.fallback,);

  @override
  double get value {
    var platform = Theme
        .of(context)
        .platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return iOS ?? fallback;
      case TargetPlatform.android:
        return android ?? fallback;
      case TargetPlatform.fuchsia:
        return fuchsia ?? fallback;

    //TODO add cases for web and desktop as well
    }

    return fallback;
  }
}

@experimental
class _OrientationDimension implements Dimension {
  final BuildContext context;
  final double landscape;
  final double portrait;

  _OrientationDimension(this.context, this.landscape, this.portrait);

  @override
  double get value {
    var orientation = MediaQuery
        .of(context)
        .orientation;
    switch (orientation) {
      case Orientation.landscape:
        return landscape;
      case Orientation.portrait:
        return portrait;
    }

    throw Exception("fuck you compiler");
  }
}*/
