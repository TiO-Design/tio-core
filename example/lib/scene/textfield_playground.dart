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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(24),
        color: TioTheme.of(context).surfaceColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.search), hintText: "Search something"),
            ),
            SizedBox(height: 32),
            TioTextField(
              leading: Icon(Icons.search),
              hint: "Search something",
            ),
          ],
        ),
      ),
    );
  }
}
