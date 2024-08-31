import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/27
/// describe:

mixin ButtonIconBuilder {
  dynamic _icon;
  IconAlignment? _iconAlignment;
}

extension ButtonIconBuilderExt<T extends ButtonIconBuilder> on T {
  T get start => this.._iconAlignment = IconAlignment.start;

  T get end => this.._iconAlignment = IconAlignment.end;

  T icon(dynamic icon) => this.._icon = icon;
}

///[TextButton.icon]
TextButtonBuilder textButton(String text) => TextButtonBuilder._(text);

///[OutlinedButton.icon]
OutlinedButtonBuilder outlinedButton(String text) => OutlinedButtonBuilder._(text);

///[ElevatedButton.icon]
ElevatedButtonBuilder elevatedButton(String text) => ElevatedButtonBuilder._(text);

///[OutlinedButton.icon]
IconButtonBuilder get iconButton => IconButtonBuilder._();

extension ButtonStringExt on String? {
  ///[TextButton.icon]
  TextButtonBuilder get textButton => TextButtonBuilder._(this ?? '');

  ///[OutlinedButton.icon]
  OutlinedButtonBuilder get outlinedButton => OutlinedButtonBuilder._(this ?? '');

  ///[ElevatedButton.icon]
  ElevatedButtonBuilder get elevatedButton => ElevatedButtonBuilder._(this ?? '');
}

abstract class ButtonBuilder extends ClickBuilder<Widget>
    with
        ColorBuilder,
        TextColorBuilder,
        CompletedTextStyleBuilder,
        BorderRadiusBuilder,
        BorderWidthBuilder,
        BorderColorBuilder,
        ButtonIconBuilder,
        PaddingBuilder,
        SizeBuilder {
  final String text;

  Color? get _finalColor {
    if (_isIconButton) {
      return borderColor ?? innerColor;
    }
    return innerTextColor ?? borderColor ?? innerColor;
  }

  bool get _isIconButton => false;

  bool get _isSvg => _icon is String && (_icon as String).endsWith('.svg');

  Widget? get _finalIcon {
    if (_icon == null) return null;
    if (_icon is String && (_icon as String).trim().isEmpty) return null;
    if (_icon is IconData) return Icon(_icon);
    if (_icon is Widget) return _icon;
    if (_isSvg) {
      return SvgPicture.asset(
        _icon,
        width: size ?? width,
        height: size ?? height,
        colorFilter: _finalColor != null ? ColorFilter.mode(_finalColor!, BlendMode.srcIn) : null,
      );
    }
    return ImageLoader.image(_icon, width: size ?? width, height: size ?? height);
  }

  ButtonStyle? get _buttonStyle {
    WidgetStateProperty<BorderSide?>? side;
    WidgetStateProperty<Color?>? foregroundColor;
    WidgetStateProperty<Color?>? backgroundColor;
    WidgetStateProperty<EdgeInsetsGeometry?>? padding;
    ButtonStyle? buttonStyle;
    if (borderColor != null || borderWidth != null) {
      side = WidgetStateProperty.all(BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.0));
    }
    if (innerTextColor != null || borderColor != null) {
      foregroundColor = WidgetStateProperty.all(innerTextColor ?? borderColor);
    }
    if (innerColor != null && !_isIconButton) {
      backgroundColor = WidgetStateProperty.all(innerColor);
    }
    if (hasPadding) {
      padding = WidgetStateProperty.all(finalPadding);
    }
    if (side != null || foregroundColor != null || backgroundColor != null || radius != null) {
      buttonStyle = ButtonStyle(
        side: side,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: radius != null ? buttonShape : null,
        padding: padding,
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
      icon: _finalIcon,
      style: _buttonStyle,
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
      icon: _finalIcon,
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
      icon: _finalIcon,
      iconAlignment: _iconAlignment ?? IconAlignment.start,
      label: Text(super.text, style: style ?? TextStyle(fontSize: 14.csp)),
    );
  }
}

class IconButtonBuilder extends ButtonBuilder {
  IconButtonBuilder._() : super('');

  @override
  bool get _isIconButton => true;

  @override
  Widget click({GestureTapCallback? onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: _finalIcon ?? gapEmpty,
      padding: finalPadding,
      iconSize: size ?? width ?? height,
      color: borderColor ?? innerColor,
      style: _buttonStyle,
    );
  }
}
