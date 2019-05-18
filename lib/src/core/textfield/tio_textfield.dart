import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tio_core/src/core/animation/color_animation_controller.dart';
import 'package:tio_core/src/core/tio_theme_mixin.dart';

const textFieldHeight = 56.0;
const contentHeight = 24.0;
const horizontalPadding = 16.0;

const Color borderColor = const Color(0xFFD9D9D9);
const Color errorColor = const Color(0xFFAF0120);
const Color disabledTint = const Color(0xFFCCCCCC);
const Color inActiveTint = const Color(0xFF8C8C8C);
const Color activeTint = const Color(0xFF404040);
const Color focusedBackground = const Color(0xFFFAFAFA);

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

  final Duration duration;
  final bool isValid;
  final String errorMessage;

  final Function(String) onChanged;

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
    this.isValid = true,
    this.errorMessage = "",
    this.duration = const Duration(milliseconds: 200),
    this.onChanged,
  });

  @override
  _TioTextFieldState createState() => _TioTextFieldState();
}

class _TioTextFieldState extends State<TioTextField>
    with TioThemeMixin, TickerProviderStateMixin {
  FocusNode _focusNode;
  TextEditingController _controller;

  // -----
  // Internal state
  // -----

  String _text = "";
  Color _backgroundColor;
  Color _tintColor;
  Color _borderColor;

  // -----
  // AnimationControllers
  // -----

  ColorAnimationController _borderColorController;
  ColorAnimationController _backgroundColorController;
  ColorAnimationController _tintColorController;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);

    _borderColor = borderColor;
    _borderColorController = ColorAnimationController(
      begin: borderColor,
      end: errorColor,
      duration: widget.duration,
      vsync: this,
    )..addListener(_onColorAnimationTick);

    _backgroundColor = Colors.white;
    _backgroundColorController = ColorAnimationController(
      begin: Colors.white,
      end: focusedBackground,
      duration: widget.duration,
      vsync: this,
    )..addListener(_onColorAnimationTick);

    _tintColor = inActiveTint;
    _tintColorController = ColorAnimationController(
      begin: inActiveTint,
      end: activeTint,
      duration: widget.duration,
      vsync: this,
    )..addListener(_onColorAnimationTick);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: textFieldHeight,
        maxHeight: textFieldHeight,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: _textFieldDecoration,
      child: Row(
        children: [
          _buildLeading(),
          SizedBox(width: horizontalPadding),
          Expanded(child: _buildEditableText()),
          SizedBox(width: horizontalPadding),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    _borderColorController.dispose();
    _backgroundColorController.dispose();
    _tintColorController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isValid == widget.isValid) return;
    _onValidationChanged();
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
        child: Text(
          widget.hint,
          overflow: TextOverflow.ellipsis,
          style: tioTheme.textTheme.subhead.copyWith(
            fontSize: 16,
            color: _tintColor,
          ),
        ),
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

  Widget _buildLeading() {
    if (widget.leading == null) return Container();

    return IconTheme(
      data: IconThemeData(color: _tintColor),
      child: widget.leading,
    );
  }

  // -----
  // Styling
  // -----

  BoxDecoration get _textFieldDecoration {
    return BoxDecoration(
      color: _backgroundColor,
      borderRadius: BorderRadius.all(Radius.circular(4)),
      border: Border.all(color: _borderColor),
    );
  }

  // -----
  // Helper
  // -----

  /// This method updates the colors of this text field and it should be called
  /// whenever a color animation controller changed.
  void _onColorAnimationTick() {
    setState(() {
      _backgroundColor = _backgroundColorController.animation.value;
      _tintColor = _tintColorController.animation.value;
      _borderColor = _borderColorController.animation.value;
    });
  }

  void _onFocusChanged() {
    _focusNode.hasFocus
        ? _backgroundColorController.forward()
        : _backgroundColorController.reverse();
  }

  void _onTextChanged() {
    _controller.text.isNotEmpty
        ? _tintColorController.forward()
        : _tintColorController.reverse();

    setState(() => _text = _controller.text);
    if (widget.onChanged != null) widget.onChanged(_text);
  }

  void _onValidationChanged() {
    !widget.isValid
        ? _borderColorController.forward()
        : _borderColorController.reverse();
  }
}
