import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/tio_core.dart';

class TioTextField extends StatefulWidget {
  final Color cursorColor;
  final Color backgroundCursorColor;
  final Color selectionColor;
  final FocusNode focusNode;
  final TextStyle textStyle;

  final TextEditingController controller;

  TioTextField({
    this.cursorColor,
    this.backgroundCursorColor,
    this.selectionColor,
    this.focusNode,
    this.textStyle,
    this.controller,
  });

  @override
  _TioTextFieldState createState() => _TioTextFieldState();
}

class _TioTextFieldState extends State<TioTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tioTheme = TioTheme.of(context);

    final textStyle = widget.textStyle ?? tioTheme.textTheme.subhead;

    return Container(
      color: Colors.grey,
      margin: EdgeInsets.all(16),
      child: EditableText(
        controller: _controller,
        backgroundCursorColor:
            widget.backgroundCursorColor ?? Colors.transparent,
        cursorColor: widget.cursorColor ?? textStyle.color,
        selectionColor: widget.selectionColor ?? tioTheme.accentColor,
        focusNode: widget.focusNode ?? FocusNode(),
        style: textStyle,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
