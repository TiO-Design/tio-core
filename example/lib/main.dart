import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/tio_core.dart';

class ExtendedDimensions extends DimensionsData {
  double additional() => 2;

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
