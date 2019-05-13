import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tio_core/tio_core.dart';

class TextFieldPlayground extends StatefulWidget {
  @override
  _TextFieldPlaygroundState createState() => _TextFieldPlaygroundState();
}

class _TextFieldPlaygroundState extends State<TextFieldPlayground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: TioTheme.of(context).surfaceColor,
    );
  }
}
