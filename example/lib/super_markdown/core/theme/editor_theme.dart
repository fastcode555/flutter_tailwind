import 'package:flutter/material.dart';

class EditorTheme {
  final TextStyle h1TextStyle;
  final TextStyle h2TextStyle;
  final TextStyle h3TextStyle;
  final TextStyle paragraphStyle;
  final TextStyle codeStyle;
  final EdgeInsets blockSpacing;
  final ToolbarTheme toolbarTheme;
  final Color backgroundColor;
  final Color cursorColor;
  final Color selectionColor;

  const EditorTheme({
    this.h1TextStyle = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    this.h2TextStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    this.h3TextStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    this.paragraphStyle = const TextStyle(
      fontSize: 16,
      height: 1.5,
    ),
    this.codeStyle = const TextStyle(
      fontFamily: 'monospace',
      fontSize: 14,
    ),
    this.blockSpacing = const EdgeInsets.symmetric(vertical: 8),
    this.toolbarTheme = const ToolbarTheme(),
    this.backgroundColor = Colors.white,
    this.cursorColor = Colors.blue,
    this.selectionColor = Colors.lightBlueAccent,
  });

  EditorTheme copyWith({
    TextStyle? h1TextStyle,
    TextStyle? h2TextStyle,
    TextStyle? h3TextStyle,
    TextStyle? paragraphStyle,
    TextStyle? codeStyle,
    EdgeInsets? blockSpacing,
    ToolbarTheme? toolbarTheme,
    Color? backgroundColor,
    Color? cursorColor,
    Color? selectionColor,
  }) {
    return EditorTheme(
      h1TextStyle: h1TextStyle ?? this.h1TextStyle,
      h2TextStyle: h2TextStyle ?? this.h2TextStyle,
      h3TextStyle: h3TextStyle ?? this.h3TextStyle,
      paragraphStyle: paragraphStyle ?? this.paragraphStyle,
      codeStyle: codeStyle ?? this.codeStyle,
      blockSpacing: blockSpacing ?? this.blockSpacing,
      toolbarTheme: toolbarTheme ?? this.toolbarTheme,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cursorColor: cursorColor ?? this.cursorColor,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }
}

class ToolbarTheme {
  final Color backgroundColor;
  final Color iconColor;
  final Color activeIconColor;
  final Color dividerColor;
  final double iconSize;
  final EdgeInsets padding;

  const ToolbarTheme({
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.grey,
    this.activeIconColor = Colors.blue,
    this.dividerColor = Colors.grey,
    this.iconSize = 20,
    this.padding = const EdgeInsets.all(8),
  });
} 