import 'package:example/app_dimensions_data.dart';
import 'package:example/scene/dimension_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/tio_core.dart';

class NotFoundDimensions extends DimensionsData {}

void main() => runApp(TiOCoreExample());

// Testing :
// - empty dimensions

class TiOCoreExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TioApp(
      dimensions: AppDimensionsData(),
      theme: TioThemeData(
        accentColor: Colors.blueAccent,
        disabledColor: constantSwatchFromColor(Colors.black54),
        surfaceColor: constantSwatchFromColor(Colors.white),
      ),
      home: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            FlatButton(
              onPressed: () => _navigateToDimensionPage(context),
              child: Text("Dimensions"),
            ),
          ],
        ),
      ),
    );
  }

  // -----
  // Routing
  // -----

  void _navigateToDimensionPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Object>(builder: (context) {
      return ScalingPlayground();
    }));
  }
}
