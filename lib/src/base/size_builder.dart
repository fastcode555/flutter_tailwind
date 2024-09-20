import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/8/20
/// describe:
mixin SizeBuilder {
  double? width;
  double? height;
  double? size;
}

extension SizeBuilderExt<T extends SizeBuilder> on T {
  /// set the width
  T w(double width) => this..width = width;

  /// set the height
  T h(double height) => this..height = height;

  T s(double size) => this..size = size;

  double get _screenH => ScreenUtil().screenHeight;

  double get _screenW => ScreenUtil().screenHeight;

  double get _sFull => _screenW < _screenH ? _screenH : _screenW;

  /// set the height double.infini
  T get hInfinity => this..height = double.infinity;

  /// set the height _scree
  T get hFull => this..height = _screenH;

  /// set the height _screenH *
  T get hFull20 => this..height = _screenH * .2;

  /// set the height _screenH *
  T get hFull50 => this..height = _screenH * .5;

  /// set the height _screenH *
  T get hFull60 => this..height = _screenH * .6;

  /// set the height _screenH *
  T get hFull70 => this..height = _screenH * .7;

  /// set the height _screenH *
  T get hFull80 => this..height = _screenH * .8;

  /// set the width is screen width
  T get wFull => this..width = _screenW;

  T get wInfinity => this..width = double.infinity;

  /// set the width is screen width*0.2
  T get wFull20 => this..width = _screenW * .2;

  /// set the width is screen width*0.5
  T get wFull50 => this..width = _screenW * .5;

  /// set the width is screen width*0.6
  T get wFull60 => this..width = _screenW * .6;

  /// set the width is screen width*0.7
  T get wFull70 => this..width = _screenW * .7;

  /// set the width is screen width*0.8
  T get wFull80 => this..width = _screenW * .8;

  T get sFull => this..size = _screenW < _screenH ? _screenH : _screenW;

  T get sInfinity => this..size = double.infinity;

  /// set the width and the height is its 0.2
  T get sFull20 => this..size = _sFull * .2;

  /// set the width and the height is its 0.5
  T get sFull50 => this..size = _sFull * .5;

  /// set the width and the height is its 0.6
  T get sFull60 => this..size = _sFull * .6;

  /// set the width and the height is its 0.7
  T get sFull70 => this..size = _sFull * .7;

  /// set the width and the height is its 0.8
  T get sFull80 => this..size = _sFull * .8;

  T get sScreenH => this..size = _screenH;

  T get sScreenW => this..size = _screenW;

  /// set the height 1
  T get h1 => this..height = 1.h;

  /// set the height 2
  T get h2 => this..height = 2.h;

  /// set the height 3
  T get h3 => this..height = 3.h;

  /// set the height 4
  T get h4 => this..height = 4.h;

  /// set the height 5
  T get h5 => this..height = 5.h;

  /// set the height 6
  T get h6 => this..height = 6.h;

  /// set the height 7
  T get h7 => this..height = 7.h;

  /// set the height 8
  T get h8 => this..height = 8.h;

  /// set the height 8
  T get h9 => this..height = 9.h;

  /// set the height 10
  T get h10 => this..height = 10.h;

  /// set the height 12
  T get h12 => this..height = 12.h;

  /// set the height 14
  T get h14 => this..height = 14.h;

  /// set the height 16
  T get h16 => this..height = 16.h;

  /// set the height 18
  T get h18 => this..height = 18.h;

  /// set the height 20
  T get h20 => this..height = 20.h;

  /// set the height 22
  T get h22 => this..height = 22.h;

  /// set the height 24
  T get h24 => this..height = 24.h;

  /// set the height 26
  T get h26 => this..height = 26.h;

  /// set the height 28
  T get h28 => this..height = 28.h;

  /// set the height 30
  T get h30 => this..height = 30.h;

  /// set the height 32
  T get h32 => this..height = 32.h;

  /// set the height 34
  T get h34 => this..height = 34.h;

  /// set the height 36
  T get h36 => this..height = 36.h;

  /// set the height 38
  T get h38 => this..height = 38.h;

  /// set the height 40
  T get h40 => this..height = 40.h;

  /// set the height 42
  T get h42 => this..height = 42.h;

  /// set the height 44
  T get h44 => this..height = 44.h;

  /// set the height 46
  T get h46 => this..height = 46.h;

  /// set the height 48
  T get h48 => this..height = 48.h;

  /// set the height 50
  T get h50 => this..height = 50.h;

  /// set the height 52
  T get h52 => this..height = 52.h;

  /// set the height 54
  T get h54 => this..height = 54.h;

  /// set the height 56
  T get h56 => this..height = 56.h;

  /// set the height 58
  T get h58 => this..height = 58.h;

  /// set the height 60
  T get h60 => this..height = 60.h;

  /// set the height 62
  T get h62 => this..height = 62.h;

  /// set the height 64
  T get h64 => this..height = 64.h;

  /// set the height 66
  T get h66 => this..height = 66.h;

  /// set the height 68
  T get h68 => this..height = 68.h;

  /// set the height 70
  T get h70 => this..height = 70.h;

  /// set the height 72
  T get h72 => this..height = 72.h;

  /// set the height 74
  T get h74 => this..height = 74.h;

  /// set the height 76
  T get h76 => this..height = 76.h;

  /// set the height 78
  T get h78 => this..height = 78.h;

  /// set the height 80
  T get h80 => this..height = 80.h;

  /// set the height 82
  T get h82 => this..height = 82.h;

  /// set the height 84
  T get h84 => this..height = 84.h;

  /// set the height 86
  T get h86 => this..height = 86.h;

  /// set the height 88
  T get h88 => this..height = 88.h;

  /// set the height 90
  T get h90 => this..height = 90.h;

  /// set the height 92
  T get h92 => this..height = 92.h;

  /// set the height 94
  T get h94 => this..height = 94.h;

  /// set the height 96
  T get h96 => this..height = 96.h;

  /// set the height 98
  T get h98 => this..height = 98.h;

  /// set the height 100
  T get h100 => this..height = 100.h;

  /// set the height 120
  T get h120 => this..height = 120.h;

  /// set the height 150
  T get h150 => this..height = 150.h;

  /// set the height 200
  T get h200 => this..height = 200.h;

  /// set the height 250
  T get h250 => this..height = 250.h;

  /// set the height 300
  T get h300 => this..height = 300.h;

  /// set the height 350
  T get h350 => this..height = 350.h;

  ///set width=1
  T get w1 => this..width = 1.w;

  ///set width=2
  T get w2 => this..width = 2.w;

  ///set width=3
  T get w3 => this..width = 3.w;

  ///set width=4
  T get w4 => this..width = 4.w;

  ///set width=5
  T get w5 => this..width = 5.w;

  ///set width=6
  T get w6 => this..width = 6.w;

  ///set width=7
  T get w7 => this..width = 7.w;

  ///set width=8
  T get w8 => this..width = 8.w;

  ///set width=8
  T get w9 => this..width = 9.w;

  ///set width=10
  T get w10 => this..width = 10.w;

  ///set width=12
  T get w12 => this..width = 12.w;

  ///set width=14
  T get w14 => this..width = 14.w;

  ///set width=16
  T get w16 => this..width = 16.w;

  ///set width=18
  T get w18 => this..width = 18.w;

  ///set width=20
  T get w20 => this..width = 20.w;

  ///set width=22
  T get w22 => this..width = 22.w;

  ///set width=24
  T get w24 => this..width = 24.w;

  ///set width=26
  T get w26 => this..width = 26.w;

  ///set width=28
  T get w28 => this..width = 28.w;

  ///set width=30
  T get w30 => this..width = 30.w;

  ///set width=32
  T get w32 => this..width = 32.w;

  ///set width=34
  T get w34 => this..width = 34.w;

  ///set width=36
  T get w36 => this..width = 36.w;

  ///set width=38
  T get w38 => this..width = 38.w;

  ///set width=40
  T get w40 => this..width = 40.w;

  ///set width=42
  T get w42 => this..width = 42.w;

  ///set width=44
  T get w44 => this..width = 44.w;

  ///set width=46
  T get w46 => this..width = 46.w;

  ///set width=48
  T get w48 => this..width = 48.w;

  ///set width=50
  T get w50 => this..width = 50.w;

  ///set width=52
  T get w52 => this..width = 52.w;

  ///set width=54
  T get w54 => this..width = 54.w;

  ///set width=56
  T get w56 => this..width = 56.w;

  ///set width=58
  T get w58 => this..width = 58.w;

  ///set width=60
  T get w60 => this..width = 60.w;

  ///set width=62
  T get w62 => this..width = 62.w;

  ///set width=64
  T get w64 => this..width = 64.w;

  ///set width=66
  T get w66 => this..width = 66.w;

  ///set width=68
  T get w68 => this..width = 68.w;

  ///set width=70
  T get w70 => this..width = 70.w;

  ///set width=72
  T get w72 => this..width = 72.w;

  ///set width=74
  T get w74 => this..width = 74.w;

  ///set width=76
  T get w76 => this..width = 76.w;

  ///set width=78
  T get w78 => this..width = 78.w;

  ///set width=80
  T get w80 => this..width = 80.w;

  ///set width=82
  T get w82 => this..width = 82.w;

  ///set width=84
  T get w84 => this..width = 84.w;

  ///set width=86
  T get w86 => this..width = 86.w;

  ///set width=88
  T get w88 => this..width = 88.w;

  ///set width=90
  T get w90 => this..width = 90.w;

  ///set width=92
  T get w92 => this..width = 92.w;

  ///set width=94
  T get w94 => this..width = 94.w;

  ///set width=96
  T get w96 => this..width = 96.w;

  ///set width=98
  T get w98 => this..width = 98.w;

  ///1set width=00
  T get w100 => this..width = 100.w;

  ///1set width=20
  T get w120 => this..width = 120.w;

  ///1set width=50
  T get w150 => this..width = 150.w;

  ///2set width=00
  T get w200 => this..width = 200.w;

  ///2set width=50
  T get w250 => this..width = 250.w;

  ///3set width=00
  T get w300 => this..width = 300.w;

  ///3set width=50
  T get w350 => this..width = 350.w;

  /// set the size 2
  T get s2 => this..size = 2.r;

  /// set the size 1
  T get s3 => this..size = 3.r;

  /// set the size 4
  T get s4 => this..size = 4.r;

  /// set the size 4
  T get s5 => this..size = 5.r;

  /// set the size 6
  T get s6 => this..size = 6.r;

  /// set the size 7
  T get s7 => this..size = 7.r;

  /// set the size 8
  T get s8 => this..size = 8.r;

  /// set the size 9
  T get s9 => this..size = 9.r;

  /// set the size 10
  T get s10 => this..size = 10.r;

  /// set the size 12
  T get s12 => this..size = 12.r;

  /// set the size 14
  T get s14 => this..size = 14.r;

  /// set the size 16
  T get s16 => this..size = 16.r;

  /// set the size 18
  T get s18 => this..size = 18.r;

  /// set the size 20
  T get s20 => this..size = 20.r;

  /// set the size 22
  T get s22 => this..size = 22.r;

  /// set the size 24
  T get s24 => this..size = 24.r;

  /// set the size 26
  T get s26 => this..size = 26.r;

  /// set the size 28
  T get s28 => this..size = 28.r;

  /// set the size 30
  T get s30 => this..size = 30.r;

  /// set the size 32
  T get s32 => this..size = 32.r;

  /// set the size 34
  T get s34 => this..size = 34.r;

  /// set the size 36
  T get s36 => this..size = 36.r;

  /// set the size 38
  T get s38 => this..size = 38.r;

  /// set the size 40
  T get s40 => this..size = 40.r;

  /// set the size 42
  T get s42 => this..size = 42.r;

  /// set the size 44
  T get s44 => this..size = 44.r;

  /// set the size 46
  T get s46 => this..size = 46.r;

  /// set the size 48
  T get s48 => this..size = 48.r;

  /// set the size 50
  T get s50 => this..size = 50.r;

  /// set the size 52
  T get s52 => this..size = 52.r;

  /// set the size 54
  T get s54 => this..size = 54.r;

  /// set the size 56
  T get s56 => this..size = 56.r;

  /// set the size 58
  T get s58 => this..size = 58.r;

  /// set the size 60
  T get s60 => this..size = 60.r;

  /// set the size 62
  T get s62 => this..size = 62.r;

  /// set the size 64
  T get s64 => this..size = 64.r;

  /// set the size 66
  T get s66 => this..size = 66.r;

  /// set the size 68
  T get s68 => this..size = 68.r;

  /// set the size 70
  T get s70 => this..size = 70.r;

  /// set the size 72
  T get s72 => this..size = 72.r;

  /// set the size 74
  T get s74 => this..size = 74.r;

  /// set the size 76
  T get s76 => this..size = 76.r;

  /// set the size 78
  T get s78 => this..size = 78.r;

  /// set the size 80
  T get s80 => this..size = 80.r;

  /// set the size 82
  T get s82 => this..size = 82.r;

  /// set the size 84
  T get s84 => this..size = 84.r;

  /// set the size 86
  T get s86 => this..size = 86.r;

  /// set the size 88
  T get s88 => this..size = 88.r;

  /// set the size 90
  T get s90 => this..size = 90.r;

  /// set the size 92
  T get s92 => this..size = 92.r;

  /// set the size 94
  T get s94 => this..size = 94.r;

  /// set the size 96
  T get s96 => this..size = 96.r;

  /// set the size 98
  T get s98 => this..size = 98.r;

  /// set the size 100
  T get s100 => this..size = 100.r;

  /// set the size 120
  T get s120 => this..size = 120.r;

  /// set the size 150
  T get s150 => this..size = 150.r;

  /// set the size 200
  T get s200 => this..size = 200.r;

  /// set the size 250
  T get s250 => this..size = 250.r;

  /// set the size 300
  T get s300 => this..size = 300.r;

  /// set the size 350
  T get s350 => this..size = 350.r;
}
