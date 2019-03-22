import 'package:example/app_dimensions_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/tio_core.dart';

class NotFoundDimensions extends DimensionsData {}

void main() => runApp(TiOCoreExample());

class TiOCoreExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.blue,
        home: Dimensions<AppDimensionsData>(
            data: AppDimensionsData(),
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
                                  "screenWidthMedium - AppDimensionsData: ${Dimensions
                                      .of<AppDimensionsData>(context)
                                      .screenWidthMedium}"),
                              Text(
                                  "onGrid(1) - DimensionsData: ${Dimensions.of(
                                      context).onGrid(1)}"),
                              Text(
                                  "textScaleFactor: ${MediaQuery
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
        width: dimensions.scaled(30),
        height: dimensions.onGrid(8, scaled: true),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Center(child: Text("scaaled")));
  }
}
