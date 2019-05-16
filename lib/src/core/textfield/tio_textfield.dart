import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/src/core/tio_theme_aware.dart';

const textFieldHeight = 56.0;
const contentHeight = 24.0;
const horizontalPadding = 8.0;

class TioTextField extends StatefulWidget {
  /// This [Widget] will be displayed before the text fields content.
  //TODO information about max size in different dense modes
  final Widget leading;

  /// This [Widget] will be displayed after the text fields content
  //TODO information about max size in different dense modes
  final Widget trailing;

  final Color cursorColor;
  final Color backgroundCursorColor;
  final Color selectionColor;
  final FocusNode focusNode;
  final String hint;

  /// The [TextStyle] of inserted text.
  final TextStyle textStyle;

  final TextEditingController controller;

  TioTextField({
    this.leading,
    this.trailing,
    this.cursorColor,
    this.backgroundCursorColor,
    this.selectionColor,
    this.focusNode,
    this.textStyle,
    this.controller,
    this.hint,
  });

  @override
  _TioTextFieldState createState() => _TioTextFieldState();
}

class _TioTextFieldState extends State<TioTextField> with TioThemeAware {
  TextEditingController _controller;
  String _text = "";

  FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      setState(() => _text = _controller.text);
    });

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() => _hasFocus = _focusNode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: textFieldHeight,
        maxHeight: textFieldHeight,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: _textFieldDecoration,
      child: Row(
        children: [
          widget.leading ?? Container(),
          SizedBox(width: horizontalPadding),
          Expanded(child: _buildEditableText()),
          SizedBox(width: horizontalPadding),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  // -----
  // Widget Builders
  // -----

  Widget _buildHint() {
    if (widget.hint == null || _text.isNotEmpty) return Container();

    return IgnorePointer(
      child: Container(
        height: contentHeight,
        alignment: Alignment.centerLeft,
        child: Text(widget.hint,
            overflow: TextOverflow.ellipsis,
            style: tioTheme.textTheme.subhead.copyWith(
              fontSize: 16,
              color: _hintColor,
            )),
      ),
    );
  }

  Widget _buildEditableText() {
    final textStyle =
        widget.textStyle ?? tioTheme.textTheme.subhead.copyWith(fontSize: 16);

    return Stack(
      alignment: Alignment.center,
      children: [
        EditableText(
          controller: _controller,
          backgroundCursorColor:
              widget.backgroundCursorColor ?? Colors.transparent,
          cursorColor: widget.cursorColor ?? textStyle.color,
          selectionColor: widget.selectionColor ?? tioTheme.accentColor,
          focusNode: _focusNode,
          style: textStyle,
        ),
        _buildHint()
      ],
    );
  }

  // -----
  // Styling
  // -----

  Color get _tintColor {
    return _hasFocus ? Color(0xFF404040) : Color(0xFFD9D9D9);
  }

  Color get _hintColor {
    return _hasFocus ? Colors.grey : _tintColor;
  }

  BoxDecoration get _textFieldDecoration {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: _tintColor));
  }
}
