import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'radio.g.dart';

/// Barry
/// @date 2024/9/12
/// describe:

_RadioBuilder get radio => _RadioBuilder();

class _RadioBuilder extends _BaseRadioBuilder {
  @override
  Widget onChanged<T>(T initialValue, T groupValue, ValueChanged<T> onChanged) {
    return AnimatedRadio<T>(
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
      systemStyle: _material,
      ratio: _ratio,
      groupValue: groupValue,
    );
  }
}
