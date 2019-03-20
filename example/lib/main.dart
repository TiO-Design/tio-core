import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/tio_core.dart';

class ExtendedDimensions extends DimensionsData {
  double screenWidthMin = 320;
  double screenWidthSmall = 432;
  double screenWidthMedium = 864;

  double additional() => 2;

  /// The base border radius that gets scaled by [scaling].
  final double borderRadius;

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

  @override
  double scaledGridUnit([double scale = 2]) => 16;
}

class NotFoundDimensions extends DimensionsData {}

void main() => runApp(TiOCoreExample());

class TiOCoreExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.blue,
        home: Dimensions<ExtendedDimensions>(
            data: ExtendedDimensions(),
            child: Dimensions<DimensionsData>(
                data: DimensionsData(),
                child: Builder(builder: (context) {
                  return Scaffold(
                      body: SafeArea(
                          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "additional() - ExtendedDimensionsData: ${Dimensions.of<ExtendedDimensions>(context).additional()}"),
                          Text(
                              "scaledGridUnit() - DimensionsData: ${Dimensions.of(context).scaledGridUnit()}"),
                          Text(
                              "scaledGridUnit() - ExtendedDimensionsData: ${Dimensions.of<ExtendedDimensions>(context).scaledGridUnit()}"),
                          /*Text("throws DimensionsNotFound: ${Dimensions.of<NotFoundDimensions>(context)}")*/
                        ]),
                  )));
                }))));
  }
}