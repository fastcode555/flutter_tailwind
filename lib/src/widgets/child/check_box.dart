import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'check_box.g.dart';

/// Barry
/// @date 2024/9/12
/// describe:

///eg: checkBox.blue.borderBlack.shadowMd.material.s50.onChanged(false, _onChanged)
///![](https://github.com/fastcode555/flutter_tailwind/blob/master/images/check_box_image.png?raw=true)
_CheckBoxBuilder get checkBox => _CheckBoxBuilder();

class _CheckBoxBuilder extends _BaseCheckBoxBuilder<bool> {
  @override
  Widget onChanged(bool initialValue, Function(bool value) onChanged) {
    return createPadding(
      AnimatedCheckBox(
        width: _width,
        height: _height,
        size: _size,
        color: innerColor,
        borderColor: borderColor,
        value: initialValue,
        onChanged: onChanged,
        borderRadius: isCircle ? null : (hasRadius ? borderRadius : BorderRadius.circular(4)),
        shape: innerShape ?? BoxShape.rectangle,
        enableBorder: _enableBorder,
        icon: _finalIcon,
        justIcon: _justIcon,
        boxShadow: boxShadow,
        systemStyle: _material,
        ratio: _ratio,
      ),
    );
  }
}
