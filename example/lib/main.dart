import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/tio_core.dart';

class ExtendedDimensions extends DimensionsData {
  double additional() => 2;
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
                data: DimensionsData(scale: 2),
                child: Builder(builder: (context) {
                  return Scaffold(
                      body: SafeArea(
                          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "additional() - ExtendedDimensionsData: ${Dimensions
                                      .of<ExtendedDimensions>(context)
                                      .additional()}"),
                              Text(
                                  "scaledGridUnit() - DimensionsData: ${Dimensions
                                      .of(context).onGrid()}"),
                              Text(
                                  "scaledGridUnit() - ExtendedDimensionsData: ${Dimensions
                                      .of<ExtendedDimensions>(context)
                                      .onGrid()}"),
                              Text("textScaleFactor ${MediaQuery
                                  .of(context)
                                  .textScaleFactor
                                  .toString()}")
                              /*Text("throws DimensionsNotFound: ${Dimensions.of<NotFoundDimensions>(context)}")*/
                            ]),
                        TextBoxThatShouldScale(),
                        TextScaleAwareDimensions(
                            child: TextBoxThatShouldScale())
                      ],
                    ),
                  )));
                }))));
  }
}

class TextBoxThatShouldScale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dimensions = Dimensions.of(context);
    return Container(
        width: dimensions
            .scaled(30)
            .value,
        height: dimensions
            .onGrid(8)
            .scaled()
            .value,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Center(child: Text("scaaled")));
  }
}

class TextScaleAwareDimensions<D extends DimensionsData>
    extends StatelessWidget {
  final D data;
  final Widget child;

  TextScaleAwareDimensions({this.data, @required this.child});

  @override
  Widget build(BuildContext context) {
    var textScaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;
    var data = this.data ?? Dimensions.of<D>(context);
    return Dimensions<D>(
        data: data.copyWith(scale: data.scale * textScaleFactor), child: child);
  }
}
