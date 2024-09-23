import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/utils/debouncer.dart';

part 'buttons.p.dart';

/// Barry
/// @date 2024/8/27
/// describe:
class _TextButtonBuilder extends ButtonBuilder {
  _TextButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    return createMargin(TextButton.icon(
      onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
      icon: _finalIcon,
      style: _buttonStyle,
      iconAlignment: _iconAlignment ?? IconAlignment.start,
      label: Text(super.text, style: style ?? TextStyle(fontSize: 14.sp)),
    ));
  }
}

class _OutlinedButtonBuilder extends ButtonBuilder {
  _OutlinedButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    return createMargin(OutlinedButton.icon(
      onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
      style: _buttonStyle,
      icon: _finalIcon,
      iconAlignment: _iconAlignment ?? IconAlignment.start,
      label: Text(super.text, style: style ?? TextStyle(fontSize: 14.sp)),
    ));
  }
}

class _ElevatedButtonBuilder extends ButtonBuilder {
  _ElevatedButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    return createMargin(ElevatedButton.icon(
      onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
      style: _buttonStyle,
      icon: _finalIcon,
      iconAlignment: _iconAlignment ?? IconAlignment.start,
      label: Text(super.text, style: style ?? TextStyle(fontSize: 14.sp)),
    ));
  }
}

class _IconButtonBuilder extends ButtonBuilder {
  _IconButtonBuilder._() : super('');

  @override
  bool get _isIconButton => true;

  @override
  Widget click({GestureTapCallback? onTap}) {
    return createMargin(IconButton(
      onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
      icon: _finalIcon ?? gapEmpty,
      padding: finalPadding,
      iconSize: size ?? width ?? height,
      color: (borderColor ?? innerColor).opacity(innerOpacity),
      style: _buttonStyle,
    ));
  }
}
