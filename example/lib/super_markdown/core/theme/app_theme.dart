import 'package:flutter/material.dart';

class AppTheme {
  // 浅色主题
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
    ),
    scaffoldBackgroundColor: Colors.grey.shade50,
    dividerColor: Colors.grey.shade200,

    // 编辑器主题
    extensions: [
      EditorThemeData(
        backgroundColor: Colors.white,
        textColor: Colors.black,
        cursorColor: Colors.blue,
        selectionColor: Colors.blue.withOpacity(0.2),
        gutterBackgroundColor: Colors.grey.shade100,
        gutterTextColor: Colors.grey.shade600,
        lineNumberColor: Colors.grey.shade400,
        // 语法高亮
        syntaxHighlight: SyntaxHighlightTheme(
          comment: Colors.grey.shade600,
          keyword: Colors.blue,
          string: Colors.green,
          number: Colors.orange,
          punctuation: Colors.grey.shade700,
        ),
      ),
    ],
  );

  // 深色主题
  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    dividerColor: Colors.grey.shade700,

    // 编辑器主题
    extensions: [
      EditorThemeData(
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        cursorColor: Colors.blue,
        selectionColor: Colors.blue.withOpacity(0.3),
        gutterBackgroundColor: Colors.grey.shade900,
        gutterTextColor: Colors.grey.shade400,
        lineNumberColor: Colors.grey.shade500,
        // 语法高亮
        syntaxHighlight: SyntaxHighlightTheme(
          comment: Colors.grey.shade400,
          keyword: Colors.blue.shade300,
          string: Colors.green.shade300,
          number: Colors.orange.shade300,
          punctuation: Colors.grey.shade300,
        ),
      ),
    ],
  );
}

// 编辑器主题数据
class EditorThemeData extends ThemeExtension<EditorThemeData> {
  final Color backgroundColor;
  final Color textColor;
  final Color cursorColor;
  final Color selectionColor;
  final Color gutterBackgroundColor;
  final Color gutterTextColor;
  final Color lineNumberColor;
  final SyntaxHighlightTheme syntaxHighlight;

  EditorThemeData({
    required this.backgroundColor,
    required this.textColor,
    required this.cursorColor,
    required this.selectionColor,
    required this.gutterBackgroundColor,
    required this.gutterTextColor,
    required this.lineNumberColor,
    required this.syntaxHighlight,
  });

  @override
  ThemeExtension<EditorThemeData> copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? cursorColor,
    Color? selectionColor,
    Color? gutterBackgroundColor,
    Color? gutterTextColor,
    Color? lineNumberColor,
    SyntaxHighlightTheme? syntaxHighlight,
  }) {
    return EditorThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      cursorColor: cursorColor ?? this.cursorColor,
      selectionColor: selectionColor ?? this.selectionColor,
      gutterBackgroundColor: gutterBackgroundColor ?? this.gutterBackgroundColor,
      gutterTextColor: gutterTextColor ?? this.gutterTextColor,
      lineNumberColor: lineNumberColor ?? this.lineNumberColor,
      syntaxHighlight: syntaxHighlight ?? this.syntaxHighlight,
    );
  }

  @override
  ThemeExtension<EditorThemeData> lerp(
    ThemeExtension<EditorThemeData>? other,
    double t,
  ) {
    if (other is! EditorThemeData) return this;
    return EditorThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t)!,
      selectionColor: Color.lerp(selectionColor, other.selectionColor, t)!,
      gutterBackgroundColor: Color.lerp(gutterBackgroundColor, other.gutterBackgroundColor, t)!,
      gutterTextColor: Color.lerp(gutterTextColor, other.gutterTextColor, t)!,
      lineNumberColor: Color.lerp(lineNumberColor, other.lineNumberColor, t)!,
      syntaxHighlight: other.syntaxHighlight,
    );
  }
}

// 语法高亮主题
class SyntaxHighlightTheme {
  final Color comment;
  final Color keyword;
  final Color string;
  final Color number;
  final Color punctuation;

  const SyntaxHighlightTheme({
    required this.comment,
    required this.keyword,
    required this.string,
    required this.number,
    required this.punctuation,
  });
}
