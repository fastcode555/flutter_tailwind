import 'package:flutter/material.dart';

/// Barry
/// describe: App-wide default appearance for `Input`.
///
/// Set once at startup so you don't repeat the same visual props on every
/// field:
/// ```dart
/// Tailwind.instance.configInput(const InputConfig(
///   fillColor: Colors.white,
///   unFocusColor: Color(0xFFF5F5F5),
///   border: OutlineInputBorder(),
///   contentPadding: EdgeInsets.all(12),
///   hintStyle: TextStyle(color: Colors.grey),
/// ));
/// ```
///
/// Resolution for every field is: **per-instance value ?? this config ??
/// the widget's hardcoded fallback**. Every field is optional; a field left
/// null here changes nothing (the field falls through to its existing
/// behavior). This holds appearance-only defaults — content, controllers,
/// callbacks and per-field semantics stay on the `Input` instance.
class InputConfig {
  // Fill / focus colors. When either resolves non-null the field becomes
  // `filled`; on focus [fillColor] is used, otherwise [unFocusColor].
  final Color? fillColor;
  final Color? unFocusColor;

  // Cursor.
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final double? cursorHeight;

  // Borders. [enabledBorder] falls back to [border] when null.
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;

  // Spacing.
  final EdgeInsetsGeometry? contentPadding;

  // Text styles.
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  final TextStyle? errorStyle;
  final int? errorMaxLines;

  // Floating label.
  final TextStyle? floatingLabelStyle;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final FloatingLabelBehavior? floatingLabelBehavior;

  // Icon box constraints.
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  const InputConfig({
    this.fillColor,
    this.unFocusColor,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorHeight,
    this.border,
    this.enabledBorder,
    this.disabledBorder,
    this.errorBorder,
    this.contentPadding,
    this.style,
    this.hintStyle,
    this.suffixStyle,
    this.errorStyle,
    this.errorMaxLines,
    this.floatingLabelStyle,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
  });
}
