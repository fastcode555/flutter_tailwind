import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

EdgeInsetsGeometry p16 = REdgeInsets.all(16);
EdgeInsetsGeometry p20 = REdgeInsets.all(20);

const Spacer spacer = Spacer();
const Spacer spacer2 = Spacer(flex: 2);
const Spacer spacer3 = Spacer(flex: 3);
const Spacer spacer4 = Spacer(flex: 4);
const Spacer spacer5 = Spacer(flex: 5);

const SizedBox gapEmpty = SizedBox();
const HBox h2 = HBox(2);
const HBox h4 = HBox(4);
const HBox h6 = HBox(6);
const HBox h8 = HBox(8);
const HBox h10 = HBox(10);
const HBox h12 = HBox(12);
const HBox h14 = HBox(14);
const HBox h16 = HBox(16);
const HBox h18 = HBox(18);
const HBox h20 = HBox(20);
const HBox h22 = HBox(22);
const HBox h24 = HBox(24);
const HBox h26 = HBox(26);
const HBox h28 = HBox(28);
const HBox h30 = HBox(30);
const HBox h32 = HBox(32);
const HBox h34 = HBox(34);
const HBox h36 = HBox(36);
const HBox h38 = HBox(38);
const HBox h40 = HBox(40);
const HBox h42 = HBox(42);
const HBox h44 = HBox(44);
const HBox h46 = HBox(46);
const HBox h48 = HBox(48);
const HBox h50 = HBox(50);
const HBox h52 = HBox(52);
const HBox h54 = HBox(54);
const HBox h56 = HBox(56);
const HBox h58 = HBox(58);
const HBox h60 = HBox(60);
const HBox h62 = HBox(62);
const HBox h64 = HBox(64);
const HBox h66 = HBox(66);
const HBox h68 = HBox(68);
const HBox h70 = HBox(70);
const HBox h72 = HBox(72);
const HBox h74 = HBox(74);
const HBox h76 = HBox(76);
const HBox h78 = HBox(78);
const HBox h80 = HBox(80);
const HBox h82 = HBox(82);
const HBox h84 = HBox(84);
const HBox h86 = HBox(86);
const HBox h88 = HBox(88);
const HBox h90 = HBox(90);
const HBox h92 = HBox(92);
const HBox h94 = HBox(94);
const HBox h96 = HBox(96);
const HBox h98 = HBox(98);
const HBox h100 = HBox(100);

const WBox w2 = WBox(2);
const WBox w4 = WBox(4);
const WBox w6 = WBox(6);
const WBox w8 = WBox(8);
const WBox w10 = WBox(10);
const WBox w12 = WBox(12);
const WBox w14 = WBox(14);
const WBox w16 = WBox(16);
const WBox w18 = WBox(18);
const WBox w20 = WBox(20);
const WBox w22 = WBox(22);
const WBox w24 = WBox(24);
const WBox w26 = WBox(26);
const WBox w28 = WBox(28);
const WBox w30 = WBox(30);
const WBox w32 = WBox(32);
const WBox w34 = WBox(34);
const WBox w36 = WBox(36);
const WBox w38 = WBox(38);
const WBox w40 = WBox(40);
const WBox w42 = WBox(42);
const WBox w44 = WBox(44);
const WBox w46 = WBox(46);
const WBox w48 = WBox(48);
const WBox w50 = WBox(50);
const WBox w52 = WBox(52);
const WBox w54 = WBox(54);
const WBox w56 = WBox(56);
const WBox w58 = WBox(58);
const WBox w60 = WBox(60);
const WBox w62 = WBox(62);
const WBox w64 = WBox(64);
const WBox w66 = WBox(66);
const WBox w68 = WBox(68);
const WBox w70 = WBox(70);
const WBox w72 = WBox(72);
const WBox w74 = WBox(74);
const WBox w76 = WBox(76);
const WBox w78 = WBox(78);
const WBox w80 = WBox(80);
const WBox w82 = WBox(82);
const WBox w84 = WBox(84);
const WBox w86 = WBox(86);
const WBox w88 = WBox(88);
const WBox w90 = WBox(90);
const WBox w92 = WBox(92);
const WBox w94 = WBox(94);
const WBox w96 = WBox(96);
const WBox w98 = WBox(98);
const WBox w100 = WBox(100);

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
