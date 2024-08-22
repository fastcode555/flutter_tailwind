import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/src/widgets/icon.dart';
import 'package:flutter_tailwind/src/widgets/svg.dart';
import 'package:flutter_tailwind/src/widgets/text.dart';

/// Barry
/// @date 2024/8/19
/// describe:
extension StringTailWind on String? {
  TextBuilder get text => TextBuilder(this ?? "");

  SvgBuilder get svg => SvgBuilder(this ?? "");
}

extension IconTailWind on IconData {
  IconBuilder get icon => IconBuilder(this);
}
