import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/8/26
/// describe:
mixin PositionedBuilder {
  double? left;
  double? right;
  double? top;
  double? bottom;

  EdgeInsetsGeometry? _innerMargin;

  bool get hasValue => _innerMargin != null || left != null || right != null || top != null || bottom != null;

  Widget createPositioned(Widget child) {
    return Positioned(left: left, right: right, top: top, bottom: bottom, child: child);
  }
}

extension PositionedBuilderBuilderExt<T extends PositionedBuilder> on T {
  /// set the margin left is 2
  T l(double value) => this..left = value;

  T r(double value) => this..right = value;

  T b(double value) => this..bottom = value;

  T t(double value) => this..top = value;

  T get l0 => this..left = 0.r;

  T get l1 => this..left = 1.r;

  T get l2 => this..left = 2.r;

  /// set the margin left is 4
  T get l4 => this..left = 4.r;

  /// set the margin left is 6
  T get l6 => this..left = 6.r;

  /// set the margin left is 8
  T get l8 => this..left = 8.r;

  /// set the margin left is 10
  T get l10 => this..left = 10.r;

  /// set the margin left is 12
  T get l12 => this..left = 12.r;

  /// set the margin left is 14
  T get l14 => this..left = 14.r;

  /// set the margin left is 16
  T get l16 => this..left = 16.r;

  /// set the margin left is 18
  T get l18 => this..left = 18.r;

  /// set the margin left is 20
  T get l20 => this..left = 20.r;

  /// set the margin left is 22
  T get l22 => this..left = 22.r;

  /// set the margin left is 24
  T get l24 => this..left = 24.r;

  /// set the margin left is 26
  T get l26 => this..left = 26.r;

  /// set the margin left is 28
  T get l28 => this..left = 28.r;

  /// set the margin left is 30
  T get l30 => this..left = 30.r;

  /// set the margin left is 32
  T get l32 => this..left = 32.r;

  /// set the margin left is 34
  T get l34 => this..left = 34.r;

  /// set the margin left is 36
  T get l36 => this..left = 36.r;

  /// set the margin left is 38
  T get l38 => this..left = 38.r;

  /// set the margin left is 40
  T get l40 => this..left = 40.r;

  /// set the margin left is 42
  T get l42 => this..left = 42.r;

  /// set the margin left is 44
  T get l44 => this..left = 44.r;

  /// set the margin left is 46
  T get l46 => this..left = 46.r;

  /// set the margin left is 48
  T get l48 => this..left = 48.r;

  /// set the margin left is 50
  T get l50 => this..left = 50.r;

  /// set the margin left is 52
  T get l52 => this..left = 52.r;

  /// set the margin left is 54
  T get l54 => this..left = 54.r;

  /// set the margin left is 56
  T get l56 => this..left = 56.r;

  /// set the margin left is 58
  T get l58 => this..left = 58.r;

  /// set the margin left is 60
  T get l60 => this..left = 60.r;

  /// set the margin left is 62
  T get l62 => this..left = 62.r;

  /// set the margin left is 64
  T get l64 => this..left = 64.r;

  /// set the margin left is 66
  T get l66 => this..left = 66.r;

  /// set the margin left is 68
  T get l68 => this..left = 68.r;

  /// set the margin left is 70
  T get l70 => this..left = 70.r;

  /// set the margin left is 72
  T get l72 => this..left = 72.r;

  /// set the margin left is 74
  T get l74 => this..left = 74.r;

  /// set the margin left is 76
  T get l76 => this..left = 76.r;

  /// set the margin left is 78
  T get l78 => this..left = 78.r;

  /// set the margin left is 80
  T get l80 => this..left = 80.r;

  /// set the margin left is 82
  T get l82 => this..left = 82.r;

  /// set the margin left is 84
  T get l84 => this..left = 84.r;

  /// set the margin left is 86
  T get l86 => this..left = 86.r;

  /// set the margin left is 88
  T get l88 => this..left = 88.r;

  /// set the margin left is 90
  T get l90 => this..left = 90.r;

  /// set the margin left is 92
  T get l92 => this..left = 92.r;

  /// set the margin left is 94
  T get l94 => this..left = 94.r;

  /// set the margin left is 96
  T get l96 => this..left = 96.r;

  /// set the margin left is 98
  T get l98 => this..left = 98.r;

  /// set the margin left is 100
  T get l100 => this..left = 100.r;

  /// set the margin right is 0
  T get r0 => this..right = 0.r;

  /// set the margin right is 1
  T get r1 => this..right = 1.r;

  /// set the margin right is 2
  T get r2 => this..right = 2.r;

  /// set the margin right is 4
  T get r4 => this..right = 4.r;

  /// set the margin right is 6
  T get r6 => this..right = 6.r;

  /// set the margin right is 8
  T get r8 => this..right = 8.r;

  /// set the margin right is 10
  T get r10 => this..right = 10.r;

  /// set the margin right is 12
  T get r12 => this..right = 12.r;

  /// set the margin right is 14
  T get r14 => this..right = 14.r;

  /// set the margin right is 16
  T get r16 => this..right = 16.r;

  /// set the margin right is 18
  T get r18 => this..right = 18.r;

  /// set the margin right is 20
  T get r20 => this..right = 20.r;

  /// set the margin right is 22
  T get r22 => this..right = 22.r;

  /// set the margin right is 24
  T get r24 => this..right = 24.r;

  /// set the margin right is 26
  T get r26 => this..right = 26.r;

  /// set the margin right is 28
  T get r28 => this..right = 28.r;

  /// set the margin right is 30
  T get r30 => this..right = 30.r;

  /// set the margin right is 32
  T get r32 => this..right = 32.r;

  /// set the margin right is 34
  T get r34 => this..right = 34.r;

  /// set the margin right is 36
  T get r36 => this..right = 36.r;

  /// set the margin right is 38
  T get r38 => this..right = 38.r;

  /// set the margin right is 40
  T get r40 => this..right = 40.r;

  /// set the margin right is 42
  T get r42 => this..right = 42.r;

  /// set the margin right is 44
  T get r44 => this..right = 44.r;

  /// set the margin right is 46
  T get r46 => this..right = 46.r;

  /// set the margin right is 48
  T get r48 => this..right = 48.r;

  /// set the margin right is 50
  T get r50 => this..right = 50.r;

  /// set the margin right is 52
  T get r52 => this..right = 52.r;

  /// set the margin right is 54
  T get r54 => this..right = 54.r;

  /// set the margin right is 56
  T get r56 => this..right = 56.r;

  /// set the margin right is 58
  T get r58 => this..right = 58.r;

  /// set the margin right is 60
  T get r60 => this..right = 60.r;

  /// set the margin right is 62
  T get r62 => this..right = 62.r;

  /// set the margin right is 64
  T get r64 => this..right = 64.r;

  /// set the margin right is 66
  T get r66 => this..right = 66.r;

  /// set the margin right is 68
  T get r68 => this..right = 68.r;

  /// set the margin right is 70
  T get r70 => this..right = 70.r;

  /// set the margin right is 72
  T get r72 => this..right = 72.r;

  /// set the margin right is 74
  T get r74 => this..right = 74.r;

  /// set the margin right is 76
  T get r76 => this..right = 76.r;

  /// set the margin right is 78
  T get r78 => this..right = 78.r;

  /// set the margin right is 80
  T get r80 => this..right = 80.r;

  /// set the margin right is 82
  T get r82 => this..right = 82.r;

  /// set the margin right is 84
  T get r84 => this..right = 84.r;

  /// set the margin right is 86
  T get r86 => this..right = 86.r;

  /// set the margin right is 88
  T get r88 => this..right = 88.r;

  /// set the margin right is 90
  T get r90 => this..right = 90.r;

  /// set the margin right is 92
  T get r92 => this..right = 92.r;

  /// set the margin right is 94
  T get r94 => this..right = 94.r;

  /// set the margin right is 96
  T get r96 => this..right = 96.r;

  /// set the margin right is 98
  T get r98 => this..right = 98.r;

  /// set the margin right is 100
  T get r100 => this..right = 100.r;

  /// set the margin top is 1
  T get t0 => this..top = 0.r;

  /// set the margin top is 1
  T get t1 => this..top = 1.r;

  /// set the margin top is 2
  T get t2 => this..top = 2.r;

  /// set the margin top is 4
  T get t4 => this..top = 4.r;

  /// set the margin top is 6
  T get t6 => this..top = 6.r;

  /// set the margin top is 8
  T get t8 => this..top = 8.r;

  /// set the margin top is 10
  T get t10 => this..top = 10.r;

  /// set the margin top is 12
  T get t12 => this..top = 12.r;

  /// set the margin top is 14
  T get t14 => this..top = 14.r;

  /// set the margin top is 16
  T get t16 => this..top = 16.r;

  /// set the margin top is 18
  T get t18 => this..top = 18.r;

  /// set the margin top is 20
  T get t20 => this..top = 20.r;

  /// set the margin top is 22
  T get t22 => this..top = 22.r;

  /// set the margin top is 24
  T get t24 => this..top = 24.r;

  /// set the margin top is 26
  T get t26 => this..top = 26.r;

  /// set the margin top is 28
  T get t28 => this..top = 28.r;

  /// set the margin top is 30
  T get t30 => this..top = 30.r;

  /// set the margin top is 32
  T get t32 => this..top = 32.r;

  /// set the margin top is 34
  T get t34 => this..top = 34.r;

  /// set the margin top is 36
  T get t36 => this..top = 36.r;

  /// set the margin top is 38
  T get t38 => this..top = 38.r;

  /// set the margin top is 40
  T get t40 => this..top = 40.r;

  /// set the margin top is 42
  T get t42 => this..top = 42.r;

  /// set the margin top is 44
  T get t44 => this..top = 44.r;

  /// set the margin top is 46
  T get t46 => this..top = 46.r;

  /// set the margin top is 48
  T get t48 => this..top = 48.r;

  /// set the margin top is 50
  T get t50 => this..top = 50.r;

  /// set the margin top is 52
  T get t52 => this..top = 52.r;

  /// set the margin top is 54
  T get t54 => this..top = 54.r;

  /// set the margin top is 56
  T get t56 => this..top = 56.r;

  /// set the margin top is 58
  T get t58 => this..top = 58.r;

  /// set the margin top is 60
  T get t60 => this..top = 60.r;

  /// set the margin top is 62
  T get t62 => this..top = 62.r;

  /// set the margin top is 64
  T get t64 => this..top = 64.r;

  /// set the margin top is 66
  T get t66 => this..top = 66.r;

  /// set the margin top is 68
  T get t68 => this..top = 68.r;

  /// set the margin top is 70
  T get t70 => this..top = 70.r;

  /// set the margin top is 72
  T get t72 => this..top = 72.r;

  /// set the margin top is 74
  T get t74 => this..top = 74.r;

  /// set the margin top is 76
  T get t76 => this..top = 76.r;

  /// set the margin top is 78
  T get t78 => this..top = 78.r;

  /// set the margin top is 80
  T get t80 => this..top = 80.r;

  /// set the margin top is 82
  T get t82 => this..top = 82.r;

  /// set the margin top is 84
  T get t84 => this..top = 84.r;

  /// set the margin top is 86
  T get t86 => this..top = 86.r;

  /// set the margin top is 88
  T get t88 => this..top = 88.r;

  /// set the margin top is 90
  T get t90 => this..top = 90.r;

  /// set the margin top is 92
  T get t92 => this..top = 92.r;

  /// set the margin top is 94
  T get t94 => this..top = 94.r;

  /// set the margin top is 96
  T get t96 => this..top = 96.r;

  /// set the margin top is 98
  T get t98 => this..top = 98.r;

  /// set the margin top is 100
  T get t100 => this..top = 100.r;

  /// set the margin bottom is 0
  T get b0 => this..bottom = 0.r;

  /// set the margin bottom is 1
  T get b1 => this..bottom = 1.r;

  /// set the margin bottom is 2
  T get b2 => this..bottom = 2.r;

  /// set the margin bottom is 4
  T get b4 => this..bottom = 4.r;

  /// set the margin bottom is 6
  T get b6 => this..bottom = 6.r;

  /// set the margin bottom is 8
  T get b8 => this..bottom = 8.r;

  /// set the margin bottom is 10
  T get b10 => this..bottom = 10.r;

  /// set the margin bottom is 12
  T get b12 => this..bottom = 12.r;

  /// set the margin bottom is 14
  T get b14 => this..bottom = 14.r;

  /// set the margin bottom is 16
  T get b16 => this..bottom = 16.r;

  /// set the margin bottom is 18
  T get b18 => this..bottom = 18.r;

  /// set the margin bottom is 20
  T get b20 => this..bottom = 20.r;

  /// set the margin bottom is 22
  T get b22 => this..bottom = 22.r;

  /// set the margin bottom is 24
  T get b24 => this..bottom = 24.r;

  /// set the margin bottom is 26
  T get b26 => this..bottom = 26.r;

  /// set the margin bottom is 28
  T get b28 => this..bottom = 28.r;

  /// set the margin bottom is 30
  T get b30 => this..bottom = 30.r;

  /// set the margin bottom is 32
  T get b32 => this..bottom = 32.r;

  /// set the margin bottom is 34
  T get b34 => this..bottom = 34.r;

  /// set the margin bottom is 36
  T get b36 => this..bottom = 36.r;

  /// set the margin bottom is 38
  T get b38 => this..bottom = 38.r;

  /// set the margin bottom is 40
  T get b40 => this..bottom = 40.r;

  /// set the margin bottom is 42
  T get b42 => this..bottom = 42.r;

  /// set the margin bottom is 44
  T get b44 => this..bottom = 44.r;

  /// set the margin bottom is 46
  T get b46 => this..bottom = 46.r;

  /// set the margin bottom is 48
  T get b48 => this..bottom = 48.r;

  /// set the margin bottom is 50
  T get b50 => this..bottom = 50.r;

  /// set the margin bottom is 52
  T get b52 => this..bottom = 52.r;

  /// set the margin bottom is 54
  T get b54 => this..bottom = 54.r;

  /// set the margin bottom is 56
  T get b56 => this..bottom = 56.r;

  /// set the margin bottom is 58
  T get b58 => this..bottom = 58.r;

  /// set the margin bottom is 60
  T get b60 => this..bottom = 60.r;

  /// set the margin bottom is 62
  T get b62 => this..bottom = 62.r;

  /// set the margin bottom is 64
  T get b64 => this..bottom = 64.r;

  /// set the margin bottom is 66
  T get b66 => this..bottom = 66.r;

  /// set the margin bottom is 68
  T get b68 => this..bottom = 68.r;

  /// set the margin bottom is 70
  T get b70 => this..bottom = 70.r;

  /// set the margin bottom is 72
  T get b72 => this..bottom = 72.r;

  /// set the margin bottom is 74
  T get b74 => this..bottom = 74.r;

  /// set the margin bottom is 76
  T get b76 => this..bottom = 76.r;

  /// set the margin bottom is 78
  T get b78 => this..bottom = 78.r;

  /// set the margin bottom is 80
  T get b80 => this..bottom = 80.r;

  /// set the margin bottom is 82
  T get b82 => this..bottom = 82.r;

  /// set the margin bottom is 84
  T get b84 => this..bottom = 84.r;

  /// set the margin bottom is 86
  T get b86 => this..bottom = 86.r;

  /// set the margin bottom is 88
  T get b88 => this..bottom = 88.r;

  /// set the margin bottom is 90
  T get b90 => this..bottom = 90.r;

  /// set the margin bottom is 92
  T get b92 => this..bottom = 92.r;

  /// set the margin bottom is 94
  T get b94 => this..bottom = 94.r;

  /// set the margin bottom is 96
  T get b96 => this..bottom = 96.r;

  /// set the margin bottom is 98
  T get b98 => this..bottom = 98.r;

  /// set the margin bottom is 100
  T get b100 => this..bottom = 100.r;
}
