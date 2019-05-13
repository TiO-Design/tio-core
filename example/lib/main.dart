import 'package:example/app_dimensions_data.dart';
import 'package:example/scene/dimension_scene.dart';
import 'package:example/scene/textfield_playground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/tio_core.dart';

class NotFoundDimensions extends DimensionsData {}

void main() => runApp(TiOCoreExample());

class TiOCoreExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TioApp(
      dimensions: AppDimensionsData(),
      theme: TioThemeData(
        accentColor: Colors.blueAccent,
        disabledColor: constantSwatchFromColor(Colors.black54),
        surfaceColor: constantSwatchFromColor(Colors.white),
        textTheme: Typography.blackMountainView,
      ),
      home: RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: TioTheme.of(context).surfaceColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            onPressed: () => _navigateToDimensionPage(context),
            child: Text("Dimensions"),
          ),
          FlatButton(
            onPressed: () => _navigateToTextfieldPage(context),
            child: Text("Textfields"),
          )
        ],
      ),
    );
  }

  // -----
  // Routing
  // -----

  void _navigateToDimensionPage(BuildContext context) =>
      _navigateTo(context, (context) => ScalingPlayground());

  void _navigateToTextfieldPage(BuildContext context) =>
      _navigateTo(context, (context) => TextFieldPlayground());

  void _navigateTo(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute<Object>(builder: builder));
  }
}
