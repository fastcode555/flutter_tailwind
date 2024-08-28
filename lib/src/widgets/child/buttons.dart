import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/27
/// describe:

mixin ButtonIconBuilder {
  Widget? _icon;
  IconAlignment? _iconAlignment;
}

extension ButtonIconBuilderExt<T extends ButtonIconBuilder> on T {
  T get start => this.._iconAlignment = IconAlignment.start;

  T get end => this.._iconAlignment = IconAlignment.end;

  T icon(dynamic icon) {
    if (icon is IconData) {
      _icon = Icon(icon);
    } else if (icon is Widget) {
      _icon = icon;
    }
    return this;
  }
}

extension IconDataExt on IconData {
  IconButtonBuilder get iconButton => IconButtonBuilder._(this);
}

TextButtonBuilder textButton(String text) => TextButtonBuilder._(text);

OutlinedButtonBuilder outlinedButton(String text) => OutlinedButtonBuilder._(text);

ElevatedButtonBuilder elevatedButton(String text) => ElevatedButtonBuilder._(text);

IconButtonBuilder iconButton(dynamic icon) => IconButtonBuilder._(icon);

extension ButtonStringExt on String? {
  TextButtonBuilder get textButton => TextButtonBuilder._(this ?? "");

  OutlinedButtonBuilder get outlinedButton => OutlinedButtonBuilder._(this ?? "");

  ElevatedButtonBuilder get elevatedButton => ElevatedButtonBuilder._(this ?? "");
}

abstract class ButtonBuilder extends ClickBuilder<Widget>
    with
        ColorBuilder,
        TextColorBuilder,
        CompletedTextStyleBuilder,
        BorderRadiusBuilder,
        BorderWidthBuilder,
        BorderColorBuilder,
        ButtonIconBuilder {
  final String text;

  ButtonStyle? get _buttonStyle {
    WidgetStateProperty<BorderSide?>? side;
    WidgetStateProperty<Color?>? foregroundColor;
    WidgetStateProperty<Color?>? backgroundColor;
    ButtonStyle? buttonStyle;
    if (borderColor != null || borderWidth != null) {
      side = WidgetStateProperty.all(BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.0));
    }
    if (innerTextColor != null || borderColor != null) {
      foregroundColor = WidgetStateProperty.all(innerTextColor ?? borderColor);
    }
    if (innerColor != null) {
      backgroundColor = WidgetStateProperty.all(innerColor);
    }
    if (side != null || foregroundColor != null || backgroundColor != null || radius != null) {
      buttonStyle = ButtonStyle(
        side: side,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: radius != null ? buttonShape : null,
      );
    }
    return buttonStyle;
  }

  ButtonBuilder(this.text);
}

class TextButtonBuilder extends ButtonBuilder {
  TextButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    return TextButton.icon(
      onPressed: onTap,
      icon: _icon,
      iconAlignment: _iconAlignment ?? IconAlignment.start,
      label: Text(super.text, style: style ?? TextStyle(fontSize: 14.csp)),
    );
  }
}

class OutlinedButtonBuilder extends ButtonBuilder {
  OutlinedButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: _buttonStyle,
      icon: _icon,
      iconAlignment: _iconAlignment ?? IconAlignment.start,
      label: Text(super.text, style: style ?? TextStyle(fontSize: 14.csp)),
    );
  }
}

class ElevatedButtonBuilder extends ButtonBuilder {
  ElevatedButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: _buttonStyle,
      icon: _icon,
      iconAlignment: _iconAlignment ?? IconAlignment.start,
      label: Text(super.text, style: style ?? TextStyle(fontSize: 14.csp)),
    );
  }
}

class IconButtonBuilder extends ClickBuilder<Widget>
    with PaddingBuilder, ColorBuilder, SizeBuilder, AlignmentBuilder, BorderWidthBuilder, BorderColorBuilder {
  final dynamic icon;

  IconButtonBuilder._(this.icon);

  ButtonStyle? get _buttonStyle {
    WidgetStateProperty<BorderSide?>? side;
    WidgetStateProperty<Color?>? foregroundColor;
    WidgetStateProperty<Color?>? backgroundColor;
    ButtonStyle? buttonStyle;
    if (borderColor != null || borderWidth != null) {
      side = WidgetStateProperty.all(BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.0));
    }
    if (borderColor != null) {
      foregroundColor = WidgetStateProperty.all(borderColor);
    }
    if (innerColor != null && borderColor != null) {
      backgroundColor = WidgetStateProperty.all(innerColor);
    }
    if (side != null || foregroundColor != null || backgroundColor != null) {
      buttonStyle = ButtonStyle(
        side: side,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      );
    }
    return buttonStyle;
  }

  @override
  Widget click({GestureTapCallback? onTap}) {
    Widget? child;
    if (icon is IconData) {
      child = Icon(icon);
    } else if (icon is Widget) {
      child = icon;
    }
    return IconButton(
      onPressed: onTap,
      icon: child ?? gapEmpty,
      padding: finalPadding,
      iconSize: size ?? width ?? height,
      color: borderColor ?? innerColor,
      alignment: alignment,
      style: _buttonStyle,
    );
  }
}
