import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class TextFieldError {
  final String text;
  final bool isValid;
  final bool enabled;

  const TextFieldError({
    @required this.text,
    this.isValid = true,
    this.enabled,
  });

  // -----
  // Constructors
  // -----

  const TextFieldError.none()
      : this.text = "",
        this.isValid = false,
        this.enabled = false;

  // -----
  // Copy
  // -----

  TextFieldError copyWith({String text, bool enabled}) => TextFieldError(
        text: text ?? this.text,
        isValid: enabled ?? this.isValid,
      );
}
