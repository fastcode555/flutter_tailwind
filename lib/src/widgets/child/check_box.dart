import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'check_box.g.dart';

/// Barry
/// @date 2024/9/12
/// describe:

_CheckBoxBuilder get checkBox => _CheckBoxBuilder();

class _CheckBoxBuilder extends _BaseCheckBoxBuilder {
  @override
  Widget onChanged(bool initialValue, Function(bool value) onChanged) {
    return AnimatedCheckBox(
      width: _width,
      height: _height,
      size: _size,
      color: innerColor,
      borderColor: borderColor,
      value: initialValue,
      onChanged: onChanged,
      borderRadius: isCircle ? null : (hasRadius ? borderRadius : BorderRadius.circular(4.r)),
      shape: shape ?? BoxShape.rectangle,
      enableBorder: _enableBorder,
      icon: _finalIcon,
      justIcon: _justIcon,
      boxShadow: boxShadow,
      systemStyle: _systemStyle,
      ratio: _ratio,
    );
  }
}
