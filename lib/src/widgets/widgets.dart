import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const SizedBox gapEmpty = SizedBox();
const HBox hb2 = HBox(2);
const HBox hb4 = HBox(4);
const HBox hb6 = HBox(6);
const HBox hb8 = HBox(8);
const HBox hb10 = HBox(10);
const HBox hb12 = HBox(12);
const HBox hb14 = HBox(14);
const HBox hb16 = HBox(16);
const HBox hb18 = HBox(18);
const HBox hb20 = HBox(20);
const HBox hb22 = HBox(22);
const HBox hb24 = HBox(24);
const HBox hb26 = HBox(26);
const HBox hb28 = HBox(28);
const HBox hb30 = HBox(30);
const HBox hb32 = HBox(32);
const HBox hb34 = HBox(34);
const HBox hb36 = HBox(36);
const HBox hb38 = HBox(38);
const HBox hb40 = HBox(40);
const HBox hb42 = HBox(42);
const HBox hb44 = HBox(44);
const HBox hb46 = HBox(46);
const HBox hb48 = HBox(48);
const HBox hb50 = HBox(50);
const HBox hb52 = HBox(52);
const HBox hb54 = HBox(54);
const HBox hb56 = HBox(56);
const HBox hb58 = HBox(58);
const HBox hb60 = HBox(60);
const HBox hb62 = HBox(62);
const HBox hb64 = HBox(64);
const HBox hb66 = HBox(66);
const HBox hb68 = HBox(68);
const HBox hb70 = HBox(70);
const HBox hb72 = HBox(72);
const HBox hb74 = HBox(74);
const HBox hb76 = HBox(76);
const HBox hb78 = HBox(78);
const HBox hb80 = HBox(80);
const HBox hb82 = HBox(82);
const HBox hb84 = HBox(84);
const HBox hb86 = HBox(86);
const HBox hb88 = HBox(88);
const HBox hb90 = HBox(90);
const HBox hb92 = HBox(92);
const HBox hb94 = HBox(94);
const HBox hb96 = HBox(96);
const HBox hb98 = HBox(98);
const HBox hb100 = HBox(100);

const WBox wb2 = WBox(2);
const WBox wb4 = WBox(4);
const WBox wb6 = WBox(6);
const WBox wb8 = WBox(8);
const WBox wb10 = WBox(10);
const WBox wb12 = WBox(12);
const WBox wb14 = WBox(14);
const WBox wb16 = WBox(16);
const WBox wb18 = WBox(18);
const WBox wb20 = WBox(20);
const WBox wb22 = WBox(22);
const WBox wb24 = WBox(24);
const WBox wb26 = WBox(26);
const WBox wb28 = WBox(28);
const WBox wb30 = WBox(30);
const WBox wb32 = WBox(32);
const WBox wb34 = WBox(34);
const WBox wb36 = WBox(36);
const WBox wb38 = WBox(38);
const WBox wb40 = WBox(40);
const WBox wb42 = WBox(42);
const WBox wb44 = WBox(44);
const WBox wb46 = WBox(46);
const WBox wb48 = WBox(48);
const WBox wb50 = WBox(50);
const WBox wb52 = WBox(52);
const WBox wb54 = WBox(54);
const WBox wb56 = WBox(56);
const WBox wb58 = WBox(58);
const WBox wb60 = WBox(60);
const WBox wb62 = WBox(62);
const WBox wb64 = WBox(64);
const WBox wb66 = WBox(66);
const WBox wb68 = WBox(68);
const WBox wb70 = WBox(70);
const WBox wb72 = WBox(72);
const WBox wb74 = WBox(74);
const WBox wb76 = WBox(76);
const WBox wb78 = WBox(78);
const WBox wb80 = WBox(80);
const WBox wb82 = WBox(82);
const WBox wb84 = WBox(84);
const WBox wb86 = WBox(86);
const WBox wb88 = WBox(88);
const WBox wb90 = WBox(90);
const WBox wb92 = WBox(92);
const WBox wb94 = WBox(94);
const WBox wb96 = WBox(96);
const WBox wb98 = WBox(98);
const WBox wb100 = WBox(100);

/// Barry
/// @date 9/11/23
/// describe:
class HBox extends SingleChildRenderObjectWidget {
  const HBox(this.height);

  final double height;

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(additionalConstraints: _additionalConstraints);
  }

  BoxConstraints get _additionalConstraints {
    return BoxConstraints.tightFor(width: 0, height: height.h);
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox renderObject) {
    renderObject.additionalConstraints = _additionalConstraints;
  }

  @override
  String toStringShort() {
    final String type;
    if (height == double.infinity) {
      type = '${objectRuntimeType(this, 'SizedBox')}.expand';
    } else if (height == 0.0) {
      type = '${objectRuntimeType(this, 'SizedBox')}.shrink';
    } else {
      type = objectRuntimeType(this, 'SizedBox');
    }
    return key == null ? type : '$type-$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final DiagnosticLevel level;
    if ((height == double.infinity) || height == 0.0) {
      level = DiagnosticLevel.hidden;
    } else {
      level = DiagnosticLevel.info;
    }
    properties.add(DoubleProperty('height', height.h, defaultValue: null, level: level));
  }
}

class WBox extends SingleChildRenderObjectWidget {
  const WBox(this.width);

  final double width;

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(additionalConstraints: _additionalConstraints);
  }

  BoxConstraints get _additionalConstraints {
    return BoxConstraints.tightFor(width: width.w, height: 0);
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox renderObject) {
    renderObject.additionalConstraints = _additionalConstraints;
  }

  @override
  String toStringShort() {
    final String type;
    if (width == double.infinity) {
      type = '${objectRuntimeType(this, 'SizedBox')}.expand';
    } else if (width == 0.0) {
      type = '${objectRuntimeType(this, 'SizedBox')}.shrink';
    } else {
      type = objectRuntimeType(this, 'SizedBox');
    }
    return key == null ? type : '$type-$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final DiagnosticLevel level;
    if ((width == double.infinity) || width == 0.0) {
      level = DiagnosticLevel.hidden;
    } else {
      level = DiagnosticLevel.info;
    }
    properties.add(DoubleProperty('width', width.w, defaultValue: null, level: level));
  }
}
