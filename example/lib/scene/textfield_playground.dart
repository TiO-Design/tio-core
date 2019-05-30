import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tio_core/tio_textfield.dart';
import 'package:tio_core/tio_theme.dart';

class TextFieldPlayground extends StatefulWidget {
  @override
  _TextFieldPlaygroundState createState() => _TextFieldPlaygroundState();
}

class _TextFieldPlaygroundState extends State<TextFieldPlayground> {
  bool _isValid = false;

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
                  errorText: "fuck",
                  icon: Icon(Icons.search),
                  hintText: "Search something"),
            ),
            SizedBox(height: 32),
            TioTextField(
              leading: Icon(Icons.search),
              hint: "Text with max 5 characters",
              error: TextFieldError(
                text: "I said not more than 5! 🤬",
                isValid: _isValid,
                enabled: true,
              ),
              onChanged: (text) => setState(() => _isValid = text.length <= 5),
            ),
          ],
        ),
      ),
    );
  }
}
