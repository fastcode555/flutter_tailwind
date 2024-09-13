part of 'buttons.dart';

mixin ButtonIconBuilder {
  IconAlignment? _iconAlignment;
}

extension ButtonIconBuilderExt<T extends ButtonIconBuilder> on T {
  T get start => this.._iconAlignment = IconAlignment.start;

  T get end => this.._iconAlignment = IconAlignment.end;
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

abstract class _ButtonBuilder extends ClickBuilder<Widget>
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
    if (borderColor != null || borderWidth != null) {
      side = WidgetStateProperty.all(BorderSide(color: borderColor.opacity(innerOpacity)!, width: borderWidth ?? 1.0));
    }
    if (innerTextColor != null || borderColor != null) {
      foregroundColor = WidgetStateProperty.all((innerTextColor ?? borderColor).opacity(innerOpacity));
    }
    if (innerColor != null && !_isIconButton) {
      backgroundColor = WidgetStateProperty.all(innerColor.opacity(innerOpacity));
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

  _ButtonBuilder(this.text);
}
