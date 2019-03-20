import 'package:flutter/widgets.dart';
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
class DimensionsData {
  DimensionsData(
      {this.gridUnit = 4,
      this.borderRadius = 4,
      this.screenWidthMin = 320,
      this.screenWidthSmall = 432,
      this.screenWidthMedium = 864});

  /// The base grid unit that gets scaled by [scaledGridUnit].
  final int gridUnit;

  /// The base border radius that gets scaled by [scaledBorderRadius]
  final int borderRadius;

  /// The minimum screen width that the app will support.
  final int screenWidthMin;

  /// A breakpoint that marks when the screen width is considered small.
  ///
  /// Examples for devices with small screen sizes:
  /// SmartPhones, small sized application windows, split views.
  final int screenWidthSmall;

  /// A breakpoint that marks when the screen width is considered medium.
  ///
  /// Examples for devices with small screen sizes:
  /// Tablets, medium sized application windows, split views.
  final int screenWidthMedium;

  /// Border radius scaled by 1.
  double get borderRadiusSmall => scaledBorderRadius(1);

  /// Border radius scaled by 2.
  double get borderRadiusMedium => scaledBorderRadius(2);

  /// Border radius scaled by 4.
  double get borderRadiusBig => scaledBorderRadius(4);

  /// Grid unit scaled by 1.
  double get gridUnitTiny => scaledGridUnit(1);

  /// Grid unit scaled by 2.
  double get gridUnitSmall => scaledGridUnit(2);

  /// Grid unit scaled by 4.
  double get gridUnitMedium => scaledGridUnit(4);

  /// Grid unit scaled by 6.
  double get gridUnitBig => scaledGridUnit(6);

  /// Grid unit scaled by 8.
  double get gridUnitLarge => scaledGridUnit(8);

  /// Returns a [gridUnit] that got scaled by [scale].
  /// The default [scale] is 2.
  double scaledGridUnit([double scale = 2]) => gridUnit * scale;

  /// Returns a [borderRadius] that got scaled by [scale].
  /// The default [scale] is 2.
  double scaledBorderRadius([double scale = 2]) => borderRadius * scale;
}

class DimensionData2 {
  final double scale;
  final Grid grid;

  DimensionData2({@required this.scale, this.grid});
}

///
/// A grid would contain the configuration described here:
/// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-margins
@immutable
class Grid {
  final double spacing;
  final Margins margins;

  Grid({@required this.spacing, @required this.margins});
}

// -----
// Margins
// -----

@immutable
class Margins {
  final double left;
  final double right;

  Margins(this.left, this.right);
}

// -----
// Breakpoint System
// -----

@immutable
class BreakpointSystem {
  final List<Breakpoint> breakpoints;

  BreakpointSystem(this.breakpoints);

  factory BreakpointSystem.simple() {
    return BreakpointSystem([
      ScreenWidthBreakpoint(screenWidth: 359.0),
      ScreenWidthBreakpoint(screenWidth: 399.0),
      ScreenWidthBreakpoint(screenWidth: 479.0),
      ScreenWidthBreakpoint(screenWidth: 599.0),
      ScreenWidthBreakpoint(screenWidth: 719.0),
    ]);
  }
}

abstract class Breakpoint {
  bool shouldBreak(BuildContext context);
}

class ScreenWidthBreakpoint implements Breakpoint {
  final double screenWidth;

  ScreenWidthBreakpoint({@required this.screenWidth});

  @override
  bool shouldBreak(BuildContext context) {
    //TODO get width and compare
    return false;
  }
}

// -----
// Material example
// -----

class MaterialGrid implements Grid {
  @override
  double get spacing => 4.0;

  @override
  Margins get margins => Margins(16.0, 16.0);
}
