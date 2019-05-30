import 'package:example/app_dimensions_data.dart';
import 'package:flutter/material.dart';
import 'package:tio_core/tio_dimensions.dart';

class ScalingPlayground extends StatelessWidget {
  final double scaleFactor = 2;

  @override
  Widget build(BuildContext context) {
    return Dimensions(
        data: DimensionsData(scale: scaleFactor),
        child: Builder(builder: (context) {
          return Scaffold(
              body: SafeArea(
                  child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildContent(context),
          )));
        }));
  }

  Widget _buildContent(BuildContext context) {
    var appDimensions = Dimensions.of<AppDimensionsData>(context);
    var scaledDimensions = Dimensions.of(context);

    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Column(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("ScaleFactor: $scaleFactor"),
          Text("textScaleFactor: $textScaleFactor"),
          Text("unscaled onGrid(1): ${appDimensions.onGrid(1)}"),
          Text("scaled onGrid(1): ${scaledDimensions.onGrid(1, scaled: true)}"),
        ]),
        SizedBox(height: 48),
        ScalingTextBox(description: "This box scales"),
        SizedBox(height: 16),
        TextScaleAwareDimensions(
          child: ScalingTextBox(
            description: "This box scales with the text",
          ),
        )
      ],
    );
  }
}

class ScalingTextBox extends StatelessWidget {
  final String description;

  ScalingTextBox({@required this.description});

  @override
  Widget build(BuildContext context) {
    var size = Dimensions.of(context).onGrid(16, scaled: true);
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Text(description, textAlign: TextAlign.center),
    );
  }
}
