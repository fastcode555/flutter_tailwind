import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'radio.g.dart';

/// Barry
/// @date 2024/9/12
/// describe:

/// # eg:
///- radio.onChanged(0, groupValue, _OnRadioChanged),
///- radio.onChanged(1, groupValue, _OnRadioChanged),
///- radio.onChanged(2, groupValue, _OnRadioChanged),
///- radio.circle.material.onChanged(0, groupValue, _OnRadioChanged),
///- radio.circle.material.onChanged(1, groupValue, _OnRadioChanged),
///- radio.circle.material.onChanged(2, groupValue, _OnRadioChanged),
///- radio.material.amberAccent.onChanged(0, groupValue, _OnRadioChanged),
///- radio.material.amberAccent.onChanged(1, groupValue, _OnRadioChanged),
///- radio.material.amberAccent.onChanged(2, groupValue, _OnRadioChanged),
///- radio.circle.green.material.onChanged(0, groupValue, _OnRadioChanged),
///- radio.circle.green.material.onChanged(1, groupValue, _OnRadioChanged),
///- radio.circle.green.material.onChanged(2, groupValue, _OnRadioChanged),
///- radio.enableBorder.orange.borderBlack.onChanged(0, groupValue, _OnRadioChanged),
///- radio.enableBorder.orange.borderBlack.onChanged(1, groupValue, _OnRadioChanged),
///- radio.enableBorder.orange.borderBlack.onChanged(2, groupValue, _OnRadioChanged),
///- radio.circle.onChanged(0, groupValue, _OnRadioChanged),
///- radio.circle.onChanged(1, groupValue, _OnRadioChanged),
///- radio.circle.onChanged(2, groupValue, _OnRadioChanged),
///- radio.circle.enableBorder.orange.borderBlack.onChanged(0, groupValue, _OnRadioChanged),
///- radio.circle.enableBorder.orange.borderBlack.onChanged(1, groupValue, _OnRadioChanged),
///- radio.circle.enableBorder.orange.borderBlack.onChanged(2, groupValue, _OnRadioChanged),
///- radio.circle.justIcon.onChanged(0, groupValue, _OnRadioChanged),
///- radio.circle.justIcon.onChanged(1, groupValue, _OnRadioChanged),
///- radio.circle.justIcon.onChanged(2, groupValue, _OnRadioChanged),
///- radio.circle.justIcon.red.icAwesomePen.onChanged(0, groupValue, _OnRadioChanged),
///- radio.circle.justIcon.red.icAwesomePen.onChanged(1, groupValue, _OnRadioChanged),
///- radio.circle.justIcon.red.icAwesomePen.onChanged(2, groupValue, _OnRadioChanged),
_RadioBuilder get radio => _RadioBuilder();

class _RadioBuilder extends _BaseRadioBuilder {
  @override
  Widget onChanged<T>(T initialValue, T groupValue, ValueChanged<T> onChanged) {
    return createPadding(
      AnimatedRadio<T>(
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
      ),
    );
  }
}
