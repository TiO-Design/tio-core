import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppDimensions extends Dimensions {
  double get detailPagePadding => 22;

  double get iconSize => scaled(32).value;

  double get indicatorHeight => onOrientation(landscape: 4, portrait: 2).value;

  double get circularRevealOverlaySize => onPlatform(
          fallback: 84,
          android: 112,
          desktop: 450,
          fuchsia: 112,
          iOS: 148,
          web: 448)
      .value;
}

class Dimensions {
  final BuildContext Function() obtainContext;

  final double grid;
  final double scale;

  Dimensions({@required this.obtainContext, this.grid = 1, this.scale = 1});

  double onGrid(double value) => value * grid;

  // -----
  // Dimen Factories
  // -----

  Dimension scaled(double value) => _ScaledDimension(this, value);

  Dimension onPlatform({
    @required double fallback,
    double iOS,
    double android,
    double fuchsia,
    double web,
    double desktop,
  }) =>
      _PlatformAwareDimension(
          obtainContext(), iOS, android, fuchsia, web, desktop, fallback);

  Dimension onOrientation(
          {@required double landscape, @required double portrait}) =>
      _OrientationDimension(obtainContext(), landscape, portrait);

  // -----
  // Copy
  // -----

  Dimensions copyWith({double scale, double grid}) => Dimensions(
        obtainContext: obtainContext,
        scale: scale ?? this.scale,
        grid: grid ?? this.grid,
      );
}

abstract class Dimension {
  double get value;
}

class _ScaledDimension implements Dimension {
  final Dimensions parent;
  final double initialValue;

  _ScaledDimension(this.parent, this.initialValue);

  @override
  double get value => this.parent.scale * value;
}

typedef double PlatformChooser(TargetPlatform platform);

class _PlatformAwareDimension implements Dimension {
  final BuildContext context;

  final double iOS;
  final double android;
  final double fuchsia;
  final double web;
  final double desktop;
  final double fallback;

  _PlatformAwareDimension(
    this.context,
    this.iOS,
    this.android,
    this.fuchsia,
    this.web,
    this.desktop,
    this.fallback,
  );

  @override
  double get value {
    var platform = Theme.of(context).platform;

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

class _OrientationDimension implements Dimension {
  final BuildContext context;
  final double landscape;
  final double portrait;

  _OrientationDimension(this.context, this.landscape, this.portrait);

  @override
  double get value {
    var orientation = MediaQuery.of(context).orientation;
    switch (orientation) {
      case Orientation.landscape:
        return landscape;
      case Orientation.portrait:
        return portrait;
    }

    throw Exception("fuck you compiler");
  }
}
