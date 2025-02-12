part of 'buttons.dart';

mixin ButtonIconBuilder {
  IconAlignment? _iconAlignment;
}

extension ButtonIconBuilderExt<T extends ButtonIconBuilder> on T {
  T get start => this.._iconAlignment = IconAlignment.start;

  T get end => this.._iconAlignment = IconAlignment.end;
}

///[TextButton.icon]
_TextButtonBuilder textButton(String? text) => _TextButtonBuilder._(text ?? '');

///[OutlinedButton.icon]
_OutlinedButtonBuilder outlinedButton(String? text) => _OutlinedButtonBuilder._(text ?? '');

///[ElevatedButton.icon]
_ElevatedButtonBuilder elevatedButton(String? text) => _ElevatedButtonBuilder._(text ?? '');

///[OutlinedButton.icon]
_IconButtonBuilder get iconButton => _IconButtonBuilder._();

extension ButtonStringExt on String? {
  ///[TextButton.icon]
  ///# eg:
  ///- textButton('Text Button').textWhite.redAccent.borderGreen.click(),
  ///- textButton('Text Button').textWhite.redAccent.opacity50.borderGreen.click(),
  ///- textButton('Text Button').yellow.rounded8.borderGreen.click(),
  ///- textButton('Text Button').yellow.rounded8.opacity50.borderGreen.click(),
  ///- 'Text Button'.textButton.yellow.icon(Icons.ac_unit).rounded8.borderGreen.click(onTap: () {}),
  ///- 'Text Button'.textButton.yellow.icon(Icons.ac_unit).end.rounded8.borderGreen.click(onTap: () {}),
  ///- 'Text Button'.textButton.yellow.icon(R.icAirPlay).end.rounded8.borderGreen.click(onTap: () {}),
  ///- 'Text Button'.textButton.yellow.icon(R.icDefAvatar).s18.end.rounded8.borderGreen.click(onTap: () {}),
  ///- 'Text Button'.textButton.yellow.icon(R.icDefPlaylist).s18.end.rounded8.borderGreen.click(onTap: () {}),
  ///- 'Text Button'.textButton.yellow.icon(_link).s18.end.rounded8.borderGreen.click(onTap: () {}),
  ///- 'Text Button'.textButton.textColor(Colours.redAccent).rounded8.borderGreen.click(onTap: () {}),
  ///- 'Text Button'.textButton.textColor(Colours.redAccent).opacity50.rounded8.borderGreen.click(onTap: () {}),
  ///![](https://github.com/fastcode555/flutter_tailwind/blob/master/link_image/button_image.png?raw=true)
  _TextButtonBuilder get textButton => _TextButtonBuilder._(this ?? '');

  ///[OutlinedButton.icon]
  ///# eg:
  ///- 'Outline Button'.outlinedButton.borderRedColor.textWhite.blue.border2.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.borderRedColor.border2.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.icon(Icons.ac_unit).borderRedColor.border2.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.acUnit.borderRedColor.border2.opacity50.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.acUnit.end.borderRedColor.border2.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.icAirPlay.s18.end.borderRedColor.border2.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.icDefAvatar.s18.end.borderRedColor.border2.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.icDefPlaylist.s18.end.borderRedColor.border2.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.icon(_link).s18.end.borderRedColor.border2.click(onTap: () {}),
  ///- 'Outline Button'.outlinedButton.icon('${_link}2342').s18.end.borderRedColor.border2.click(onTap: () {}),
  ///![](https://github.com/fastcode555/flutter_tailwind/blob/master/link_image/button_image.png?raw=true)
  _OutlinedButtonBuilder get outlinedButton => _OutlinedButtonBuilder._(this ?? '');

  ///[ElevatedButton.icon]
  ///# eg:
  ///- 'Elevated Button'.elevatedButton.blue.textWhite.click(),
  ///- 'Elevated Button'.elevatedButton.icon(Icons.ac_unit).blue.borderRedColor.textWhite.click(),
  ///- 'Elevated Button'.elevatedButton.icon(Icons.ac_unit).end.blue.borderRedColor.textWhite.click(),
  ///- 'Elevated Button'.elevatedButton.icon(R.icAirPlay).s20.end.blue.borderRedColor.textWhite.click(),
  ///- 'Elevated Button'.elevatedButton.icon(R.icDefAvatar).s18.end.blue.borderRedColor.textWhite.click(),
  ///- 'Elevated Button'.elevatedButton.icon(R.icDefPlaylist).s20.end.blue.borderRedColor.textWhite.click(),
  ///- 'Elevated Button'.elevatedButton.icDefPlaylist.s20.end.blue.borderRedColor.textWhite.click(),
  ///- 'Elevated Button'.elevatedButton.icon(_link).s20.end.blue.borderRedColor.textWhite.click(),
  ///- 'Elevated Button'.elevatedButton.icon(_link).s20.end.blue.borderRedColor.opacity50.textWhite.click(),
  ///![](https://github.com/fastcode555/flutter_tailwind/blob/master/link_image/button_image.png?raw=true)
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
        MarginBuilder,
        SizeBuilder,
        OpacityBuilder,
        IconBuilder,
        FontSizeBuilder {
  final String text;

  ButtonBuilder(this.text);

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
    WidgetStateProperty<TextStyle?>? textStyle;
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

    if (fontSize != null) {
      textStyle = WidgetStateProperty.all(TextStyle(fontSize: fontSize));
    }

    if (hasPadding) {
      padding = WidgetStateProperty.all(finalPadding);
    }
    if (side != null || foregroundColor != null || backgroundColor != null || radius != null || textStyle != null) {
      buttonStyle = ButtonStyle(
        side: side,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: radius != null ? buttonShape : null,
        padding: padding,
        textStyle: textStyle,
      );
    }
    return buttonStyle;
  }
}
