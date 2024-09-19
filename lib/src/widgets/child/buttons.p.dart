part of 'buttons.dart';

mixin ButtonIconBuilder {
  IconAlignment? _iconAlignment;
}

extension ButtonIconBuilderExt<T extends ButtonIconBuilder> on T {
  T get start => this.._iconAlignment = IconAlignment.start;

  T get end => this.._iconAlignment = IconAlignment.end;
}

///[TextButton.icon]
_TextButtonBuilder textButton(String text) => _TextButtonBuilder._(text);

///[OutlinedButton.icon]
_OutlinedButtonBuilder outlinedButton(String text) => _OutlinedButtonBuilder._(text);

///[ElevatedButton.icon]
_ElevatedButtonBuilder elevatedButton(String text) => _ElevatedButtonBuilder._(text);

///[OutlinedButton.icon]
_IconButtonBuilder get iconButton => _IconButtonBuilder._();

extension ButtonStringExt on String? {
  ///[TextButton.icon]
  _TextButtonBuilder get textButton => _TextButtonBuilder._(this ?? '');

  ///[OutlinedButton.icon]
  _OutlinedButtonBuilder get outlinedButton => _OutlinedButtonBuilder._(this ?? '');

  ///[ElevatedButton.icon]
  _ElevatedButtonBuilder get elevatedButton => _ElevatedButtonBuilder._(this ?? '');
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
        SizeBuilder,
        OpacityBuilder,
        IconBuilder {
  final String text;

  Color? get _finalColor {
    if (_isIconButton) {
      return (borderColor ?? innerColor).opacity(innerOpacity);
    }
    return (innerTextColor ?? borderColor ?? innerColor).opacity(innerOpacity);
  }

  bool get _isIconButton => false;

  bool get _isSvg => innerIcon is String && (innerIcon as String).endsWith('.svg');

  Widget? get _finalIcon {
    if (innerIcon == null) return null;
    if (innerIcon is String && (innerIcon as String).trim().isEmpty) return null;
    if (innerIcon is IconData) return Icon(innerIcon);
    if (innerIcon is Widget) return innerIcon;
    if (_isSvg) {
      return SvgPicture.asset(
        innerIcon,
        width: size ?? width,
        height: size ?? height,
        colorFilter: _finalColor != null ? ColorFilter.mode(_finalColor!, BlendMode.srcIn) : null,
      );
    }
    return ImageLoader.image(innerIcon, width: size ?? width, height: size ?? height);
  }

  ButtonStyle? get _buttonStyle {
    WidgetStateProperty<BorderSide?>? side;
    WidgetStateProperty<Color?>? foregroundColor;
    WidgetStateProperty<Color?>? backgroundColor;
    WidgetStateProperty<EdgeInsetsGeometry?>? padding;
    ButtonStyle? buttonStyle;
    if (borderColor != null || innerBorderWidth != null) {
      side = WidgetStateProperty.all(
        BorderSide(color: borderColor.opacity(innerOpacity)!, width: innerBorderWidth ?? 1.0),
      );
    }
    if (innerTextColor != null || borderColor != null) {
      foregroundColor = WidgetStateProperty.all(
        (innerTextColor ?? borderColor).opacity(innerOpacity),
      );
    }
    if (innerColor != null && !_isIconButton) {
      backgroundColor = WidgetStateProperty.all(
        innerColor.opacity(innerOpacity),
      );
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
