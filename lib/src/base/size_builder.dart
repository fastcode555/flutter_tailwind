import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/8/20
/// describe:
mixin SizeBuilder {
  double? width;
  double? height;
  double? size;

  double? innerMaxWidth;
  double? innerMaxHeight;
  double? innerMinWidth;
  double? innerMinHeight;

  bool get hasConstraint =>
      innerMaxWidth != null || innerMaxHeight != null || innerMinWidth != null || innerMinHeight != null;

  Widget createSizedBox(Widget child) {
    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: child);
    }
    return child;
  }
}

extension SizeBuilderExt<T extends SizeBuilder> on T {
  ///set the max width
  T maxW(double width) => this..innerMaxWidth = width;

  ///set the max width
  T maxWidth(double width) => this..innerMaxWidth = width;

  ///set the max height
  T maxH(double height) => this..innerMaxHeight = height;

  ///set the max height
  T maxHeight(double height) => this..innerMaxHeight = height;

  ///set the min width
  T minW(double width) => this..innerMinWidth = width;

  ///set the min width
  T minWidth(double width) => this..innerMinWidth = width;

  ///set the min height
  T minH(double height) => this..innerMinHeight = height;

  ///set the min height
  T minHeight(double height) => this..innerMinHeight = height;

  /// set the width
  T w(double width) => this..width = width;

  /// set the height
  T h(double height) => this..height = height;

  /// set the size
  T s(double size) => this..size = size;

  /// set the width
  T width(double width) => this..width = width;

  /// set the height
  T height(double height) => this..height = height;

  /// set the size
  T size(double size) => this..size = size;

  double get _screenH => ScreenUtil().screenHeight;

  double get _screenW => ScreenUtil().screenWidth;

  double get _sFull => _screenW < _screenH ? _screenW : _screenH;

  /// set the height double.infini
  T get hInfinity => this..height = double.infinity;

  /// set the height _scree
  T get hFull => this..height = _screenH;

  /// set the height _screenH 5
  T get hFull5 => this..height = _screenH * .05;

  /// set the height _screenH 10
  T get hFull10 => this..height = _screenH * .1;

  /// set the height _screenH 15
  T get hFull15 => this..height = _screenH * .15;

  /// set the height _screenH 20
  T get hFull20 => this..height = _screenH * .2;

  /// set the height _screenH 25
  T get hFull25 => this..height = _screenH * .25;

  /// set the height _screenH 30
  T get hFull30 => this..height = _screenH * .3;

  /// set the height _screenH 35
  T get hFull35 => this..height = _screenH * .35;

  /// set the height _screenH 40
  T get hFull40 => this..height = _screenH * .4;

  /// set the height _screenH 45
  T get hFull45 => this..height = _screenH * .45;

  /// set the height _screenH 50
  T get hFull50 => this..height = _screenH * .5;

  /// set the height _screenH 55
  T get hFull55 => this..height = _screenH * .55;

  /// set the height _screenH 60
  T get hFull60 => this..height = _screenH * .6;

  /// set the height _screenH 65
  T get hFull65 => this..height = _screenH * .65;

  /// set the height _screenH 70
  T get hFull70 => this..height = _screenH * .7;

  /// set the height _screenH 75
  T get hFull75 => this..height = _screenH * .75;

  /// set the height _screenH 80
  T get hFull80 => this..height = _screenH * .8;

  /// set the height _screenH 85
  T get hFull85 => this..height = _screenH * .85;

  /// set the height _screenH 90
  T get hFull90 => this..height = _screenH * .9;

  /// set the height _screenH 95
  T get hFull95 => this..height = _screenH * .95;

  /// set the width is screen width
  T get wFull => this..width = _screenW;

  T get wInfinity => this..width = double.infinity;

  /// set the width is screen width*5
  T get wFull5 => this..width = _screenW * .05;

  /// set the width is screen width*10
  T get wFull10 => this..width = _screenW * .1;

  /// set the width is screen width*15
  T get wFull15 => this..width = _screenW * .15;

  /// set the width is screen width*20
  T get wFull20 => this..width = _screenW * .2;

  /// set the width is screen width*25
  T get wFull25 => this..width = _screenW * .25;

  /// set the width is screen width*30
  T get wFull30 => this..width = _screenW * .3;

  /// set the width is screen width*35
  T get wFull35 => this..width = _screenW * .35;

  /// set the width is screen width*40
  T get wFull40 => this..width = _screenW * .4;

  /// set the width is screen width*45
  T get wFull45 => this..width = _screenW * .45;

  /// set the width is screen width*50
  T get wFull50 => this..width = _screenW * .5;

  /// set the width is screen width*55
  T get wFull55 => this..width = _screenW * .55;

  /// set the width is screen width*60
  T get wFull60 => this..width = _screenW * .6;

  /// set the width is screen width*65
  T get wFull65 => this..width = _screenW * .65;

  /// set the width is screen width*70
  T get wFull70 => this..width = _screenW * .7;

  /// set the width is screen width*75
  T get wFull75 => this..width = _screenW * .75;

  /// set the width is screen width*80
  T get wFull80 => this..width = _screenW * .8;

  /// set the width is screen width*85
  T get wFull85 => this..width = _screenW * .85;

  /// set the width is screen width*90
  T get wFull90 => this..width = _screenW * .9;

  /// set the width is screen width*95
  T get wFull95 => this..width = _screenW * .95;

  T get sFull => this..size = _screenW < _screenH ? _screenH : _screenW;

  T get sInfinity => this..size = double.infinity;

  /// set the width and the width or height is its *5
  T get sFull5 => this..size = _sFull * .05;

  /// set the width and the width or height is its *10
  T get sFull10 => this..size = _sFull * .1;

  /// set the width and the width or height is its *15
  T get sFull15 => this..size = _sFull * .15;

  /// set the width and the width or height is its *20
  T get sFull20 => this..size = _sFull * .2;

  /// set the width and the width or height is its *25
  T get sFull25 => this..size = _sFull * .25;

  /// set the width and the width or height is its *30
  T get sFull30 => this..size = _sFull * .3;

  /// set the width and the width or height is its *35
  T get sFull35 => this..size = _sFull * .35;

  /// set the width and the width or height is its *40
  T get sFull40 => this..size = _sFull * .4;

  /// set the width and the width or height is its *45
  T get sFull45 => this..size = _sFull * .45;

  /// set the width and the width or height is its *50
  T get sFull50 => this..size = _sFull * .5;

  /// set the width and the width or height is its *55
  T get sFull55 => this..size = _sFull * .55;

  /// set the width and the width or height is its *60
  T get sFull60 => this..size = _sFull * .6;

  /// set the width and the width or height is its *65
  T get sFull65 => this..size = _sFull * .65;

  /// set the width and the width or height is its *70
  T get sFull70 => this..size = _sFull * .7;

  /// set the width and the width or height is its *75
  T get sFull75 => this..size = _sFull * .75;

  /// set the width and the width or height is its *80
  T get sFull80 => this..size = _sFull * .8;

  /// set the width and the width or height is its *85
  T get sFull85 => this..size = _sFull * .85;

  /// set the width and the width or height is its *90
  T get sFull90 => this..size = _sFull * .9;

  /// set the width and the width or height is its *95
  T get sFull95 => this..size = _sFull * .95;

  T get sScreenH => this..size = _screenH;

  T get sScreenW => this..size = _screenW;

  T get adaptH => this..height = this.height?.h;
  T get adaptW => this..width = this.width?.w;
  T get adaptR => this..size = this.size?.r;

  /// set the height 1
  T get h1 => this..height = 1;

  /// set the height 2
  T get h2 => this..height = 2;

  /// set the height 3
  T get h3 => this..height = 3;

  /// set the height 4
  T get h4 => this..height = 4;

  /// set the height 5
  T get h5 => this..height = 5;

  /// set the height 6
  T get h6 => this..height = 6;

  /// set the height 7
  T get h7 => this..height = 7;

  /// set the height 8
  T get h8 => this..height = 8;

  /// set the height 9
  T get h9 => this..height = 9;

  /// set the height 10
  T get h10 => this..height = 10;

  /// set the height 11
  T get h11 => this..height = 11;

  /// set the height 12
  T get h12 => this..height = 12;

  /// set the height 13
  T get h13 => this..height = 13;

  /// set the height 14
  T get h14 => this..height = 14;

  /// set the height 15
  T get h15 => this..height = 15;

  /// set the height 16
  T get h16 => this..height = 16;

  /// set the height 17
  T get h17 => this..height = 17;

  /// set the height 18
  T get h18 => this..height = 18;

  /// set the height 19
  T get h19 => this..height = 19;

  /// set the height 20
  T get h20 => this..height = 20;

  /// set the height 22
  T get h22 => this..height = 22;

  /// set the height 24
  T get h24 => this..height = 24;

  /// set the height 26
  T get h26 => this..height = 26;

  /// set the height 28
  T get h28 => this..height = 28;

  /// set the height 30
  T get h30 => this..height = 30;

  /// set the height 32
  T get h32 => this..height = 32;

  /// set the height 34
  T get h34 => this..height = 34;

  /// set the height 36
  T get h36 => this..height = 36;

  /// set the height 38
  T get h38 => this..height = 38;

  /// set the height 40
  T get h40 => this..height = 40;

  /// set the height 42
  T get h42 => this..height = 42;

  /// set the height 44
  T get h44 => this..height = 44;

  /// set the height 46
  T get h46 => this..height = 46;

  /// set the height 48
  T get h48 => this..height = 48;

  /// set the height 50
  T get h50 => this..height = 50;

  /// set the height 52
  T get h52 => this..height = 52;

  /// set the height 54
  T get h54 => this..height = 54;

  /// set the height 56
  T get h56 => this..height = 56;

  /// set the height 58
  T get h58 => this..height = 58;

  /// set the height 60
  T get h60 => this..height = 60;

  /// set the height 62
  T get h62 => this..height = 62;

  /// set the height 64
  T get h64 => this..height = 64;

  /// set the height 66
  T get h66 => this..height = 66;

  /// set the height 68
  T get h68 => this..height = 68;

  /// set the height 70
  T get h70 => this..height = 70;

  /// set the height 72
  T get h72 => this..height = 72;

  /// set the height 74
  T get h74 => this..height = 74;

  /// set the height 76
  T get h76 => this..height = 76;

  /// set the height 78
  T get h78 => this..height = 78;

  /// set the height 80
  T get h80 => this..height = 80;

  /// set the height 82
  T get h82 => this..height = 82;

  /// set the height 84
  T get h84 => this..height = 84;

  /// set the height 86
  T get h86 => this..height = 86;

  /// set the height 88
  T get h88 => this..height = 88;

  /// set the height 90
  T get h90 => this..height = 90;

  /// set the height 92
  T get h92 => this..height = 92;

  /// set the height 94
  T get h94 => this..height = 94;

  /// set the height 96
  T get h96 => this..height = 96;

  /// set the height 98
  T get h98 => this..height = 98;

  /// set the height 55
  T get h55 => this..height = 55;

  /// set the height 65
  T get h65 => this..height = 65;

  /// set the height 75
  T get h75 => this..height = 75;

  /// set the height 85
  T get h85 => this..height = 85;

  /// set the height 95
  T get h95 => this..height = 95;

  /// set the height 100
  T get h100 => this..height = 100;

  /// set the height 105
  T get h105 => this..height = 105;

  /// set the height 110
  T get h110 => this..height = 110;

  /// set the height 115
  T get h115 => this..height = 115;

  /// set the height 120
  T get h120 => this..height = 120;

  /// set the height 125
  T get h125 => this..height = 125;

  /// set the height 130
  T get h130 => this..height = 130;

  /// set the height 135
  T get h135 => this..height = 135;

  /// set the height 140
  T get h140 => this..height = 140;

  /// set the height 145
  T get h145 => this..height = 145;

  /// set the height 150
  T get h150 => this..height = 150;

  /// set the height 155
  T get h155 => this..height = 155;

  /// set the height 160
  T get h160 => this..height = 160;

  /// set the height 165
  T get h165 => this..height = 165;

  /// set the height 170
  T get h170 => this..height = 170;

  /// set the height 175
  T get h175 => this..height = 175;

  /// set the height 180
  T get h180 => this..height = 180;

  /// set the height 185
  T get h185 => this..height = 185;

  /// set the height 190
  T get h190 => this..height = 190;

  /// set the height 195
  T get h195 => this..height = 195;

  /// set the height 200
  T get h200 => this..height = 200;

  /// set the height 205
  T get h205 => this..height = 205;

  /// set the height 210
  T get h210 => this..height = 210;

  /// set the height 215
  T get h215 => this..height = 215;

  /// set the height 220
  T get h220 => this..height = 220;

  /// set the height 225
  T get h225 => this..height = 225;

  /// set the height 230
  T get h230 => this..height = 230;

  /// set the height 235
  T get h235 => this..height = 235;

  /// set the height 240
  T get h240 => this..height = 240;

  /// set the height 245
  T get h245 => this..height = 245;

  /// set the height 250
  T get h250 => this..height = 250;

  /// set the height 255
  T get h255 => this..height = 255;

  /// set the height 260
  T get h260 => this..height = 260;

  /// set the height 265
  T get h265 => this..height = 265;

  /// set the height 270
  T get h270 => this..height = 270;

  /// set the height 275
  T get h275 => this..height = 275;

  /// set the height 280
  T get h280 => this..height = 280;

  /// set the height 285
  T get h285 => this..height = 285;

  /// set the height 290
  T get h290 => this..height = 290;

  /// set the height 295
  T get h295 => this..height = 295;

  /// set the height 300
  T get h300 => this..height = 300;

  /// set the height 305
  T get h305 => this..height = 305;

  /// set the height 310
  T get h310 => this..height = 310;

  /// set the height 315
  T get h315 => this..height = 315;

  /// set the height 320
  T get h320 => this..height = 320;

  /// set the height 325
  T get h325 => this..height = 325;

  /// set the height 330
  T get h330 => this..height = 330;

  /// set the height 335
  T get h335 => this..height = 335;

  /// set the height 340
  T get h340 => this..height = 340;

  /// set the height 345
  T get h345 => this..height = 345;

  /// set the height 350
  T get h350 => this..height = 350;

  /// set the height 355
  T get h355 => this..height = 355;

  /// set the height 360
  T get h360 => this..height = 360;

  /// set the height 365
  T get h365 => this..height = 365;

  /// set the height 370
  T get h370 => this..height = 370;

  /// set the height 375
  T get h375 => this..height = 375;

  /// set the height 380
  T get h380 => this..height = 380;

  /// set the height 385
  T get h385 => this..height = 385;

  /// set the height 390
  T get h390 => this..height = 390;

  /// set the height 395
  T get h395 => this..height = 395;

  /// set the height 400
  T get h400 => this..height = 400;

  /// set the width 1
  T get w1 => this..width = 1;

  /// set the width 2
  T get w2 => this..width = 2;

  /// set the width 3
  T get w3 => this..width = 3;

  /// set the width 4
  T get w4 => this..width = 4;

  /// set the width 5
  T get w5 => this..width = 5;

  /// set the width 6
  T get w6 => this..width = 6;

  /// set the width 7
  T get w7 => this..width = 7;

  /// set the width 8
  T get w8 => this..width = 8;

  /// set the width 9
  T get w9 => this..width = 9;

  /// set the width 10
  T get w10 => this..width = 10;

  /// set the width 11
  T get w11 => this..width = 11;

  /// set the width 12
  T get w12 => this..width = 12;

  /// set the width 13
  T get w13 => this..width = 13;

  /// set the width 14
  T get w14 => this..width = 14;

  /// set the width 15
  T get w15 => this..width = 15;

  /// set the width 16
  T get w16 => this..width = 16;

  /// set the width 17
  T get w17 => this..width = 17;

  /// set the width 18
  T get w18 => this..width = 18;

  /// set the width 19
  T get w19 => this..width = 19;

  /// set the width 20
  T get w20 => this..width = 20;

  /// set the width 22
  T get w22 => this..width = 22;

  /// set the width 24
  T get w24 => this..width = 24;

  /// set the width 26
  T get w26 => this..width = 26;

  /// set the width 28
  T get w28 => this..width = 28;

  /// set the width 30
  T get w30 => this..width = 30;

  /// set the width 32
  T get w32 => this..width = 32;

  /// set the width 34
  T get w34 => this..width = 34;

  /// set the width 36
  T get w36 => this..width = 36;

  /// set the width 38
  T get w38 => this..width = 38;

  /// set the width 40
  T get w40 => this..width = 40;

  /// set the width 42
  T get w42 => this..width = 42;

  /// set the width 44
  T get w44 => this..width = 44;

  /// set the width 46
  T get w46 => this..width = 46;

  /// set the width 48
  T get w48 => this..width = 48;

  /// set the width 50
  T get w50 => this..width = 50;

  /// set the width 52
  T get w52 => this..width = 52;

  /// set the width 54
  T get w54 => this..width = 54;

  /// set the width 56
  T get w56 => this..width = 56;

  /// set the width 58
  T get w58 => this..width = 58;

  /// set the width 60
  T get w60 => this..width = 60;

  /// set the width 62
  T get w62 => this..width = 62;

  /// set the width 64
  T get w64 => this..width = 64;

  /// set the width 66
  T get w66 => this..width = 66;

  /// set the width 68
  T get w68 => this..width = 68;

  /// set the width 70
  T get w70 => this..width = 70;

  /// set the width 72
  T get w72 => this..width = 72;

  /// set the width 74
  T get w74 => this..width = 74;

  /// set the width 76
  T get w76 => this..width = 76;

  /// set the width 78
  T get w78 => this..width = 78;

  /// set the width 80
  T get w80 => this..width = 80;

  /// set the width 82
  T get w82 => this..width = 82;

  /// set the width 84
  T get w84 => this..width = 84;

  /// set the width 86
  T get w86 => this..width = 86;

  /// set the width 88
  T get w88 => this..width = 88;

  /// set the width 90
  T get w90 => this..width = 90;

  /// set the width 92
  T get w92 => this..width = 92;

  /// set the width 94
  T get w94 => this..width = 94;

  /// set the width 96
  T get w96 => this..width = 96;

  /// set the width 98
  T get w98 => this..width = 98;

  /// set the width 55
  T get w55 => this..width = 55;

  /// set the width 65
  T get w65 => this..width = 65;

  /// set the width 75
  T get w75 => this..width = 75;

  /// set the width 85
  T get w85 => this..width = 85;

  /// set the width 95
  T get w95 => this..width = 95;

  /// set the width 100
  T get w100 => this..width = 100;

  /// set the width 105
  T get w105 => this..width = 105;

  /// set the width 110
  T get w110 => this..width = 110;

  /// set the width 115
  T get w115 => this..width = 115;

  /// set the width 120
  T get w120 => this..width = 120;

  /// set the width 125
  T get w125 => this..width = 125;

  /// set the width 130
  T get w130 => this..width = 130;

  /// set the width 135
  T get w135 => this..width = 135;

  /// set the width 140
  T get w140 => this..width = 140;

  /// set the width 145
  T get w145 => this..width = 145;

  /// set the width 150
  T get w150 => this..width = 150;

  /// set the width 155
  T get w155 => this..width = 155;

  /// set the width 160
  T get w160 => this..width = 160;

  /// set the width 165
  T get w165 => this..width = 165;

  /// set the width 170
  T get w170 => this..width = 170;

  /// set the width 175
  T get w175 => this..width = 175;

  /// set the width 180
  T get w180 => this..width = 180;

  /// set the width 185
  T get w185 => this..width = 185;

  /// set the width 190
  T get w190 => this..width = 190;

  /// set the width 195
  T get w195 => this..width = 195;

  /// set the width 200
  T get w200 => this..width = 200;

  /// set the width 205
  T get w205 => this..width = 205;

  /// set the width 210
  T get w210 => this..width = 210;

  /// set the width 215
  T get w215 => this..width = 215;

  /// set the width 220
  T get w220 => this..width = 220;

  /// set the width 225
  T get w225 => this..width = 225;

  /// set the width 230
  T get w230 => this..width = 230;

  /// set the width 235
  T get w235 => this..width = 235;

  /// set the width 240
  T get w240 => this..width = 240;

  /// set the width 245
  T get w245 => this..width = 245;

  /// set the width 250
  T get w250 => this..width = 250;

  /// set the width 255
  T get w255 => this..width = 255;

  /// set the width 260
  T get w260 => this..width = 260;

  /// set the width 265
  T get w265 => this..width = 265;

  /// set the width 270
  T get w270 => this..width = 270;

  /// set the width 275
  T get w275 => this..width = 275;

  /// set the width 280
  T get w280 => this..width = 280;

  /// set the width 285
  T get w285 => this..width = 285;

  /// set the width 290
  T get w290 => this..width = 290;

  /// set the width 295
  T get w295 => this..width = 295;

  /// set the width 300
  T get w300 => this..width = 300;

  /// set the width 305
  T get w305 => this..width = 305;

  /// set the width 310
  T get w310 => this..width = 310;

  /// set the width 315
  T get w315 => this..width = 315;

  /// set the width 320
  T get w320 => this..width = 320;

  /// set the width 325
  T get w325 => this..width = 325;

  /// set the width 330
  T get w330 => this..width = 330;

  /// set the width 335
  T get w335 => this..width = 335;

  /// set the width 340
  T get w340 => this..width = 340;

  /// set the width 345
  T get w345 => this..width = 345;

  /// set the width 350
  T get w350 => this..width = 350;

  /// set the width 355
  T get w355 => this..width = 355;

  /// set the width 360
  T get w360 => this..width = 360;

  /// set the width 365
  T get w365 => this..width = 365;

  /// set the width 370
  T get w370 => this..width = 370;

  /// set the width 375
  T get w375 => this..width = 375;

  /// set the width 380
  T get w380 => this..width = 380;

  /// set the width 385
  T get w385 => this..width = 385;

  /// set the width 390
  T get w390 => this..width = 390;

  /// set the width 395
  T get w395 => this..width = 395;

  /// set the width 400
  T get w400 => this..width = 400;

  /// set the size 1
  T get s1 => this..size = 1;

  /// set the size 2
  T get s2 => this..size = 2;

  /// set the size 3
  T get s3 => this..size = 3;

  /// set the size 4
  T get s4 => this..size = 4;

  /// set the size 5
  T get s5 => this..size = 5;

  /// set the size 6
  T get s6 => this..size = 6;

  /// set the size 7
  T get s7 => this..size = 7;

  /// set the size 8
  T get s8 => this..size = 8;

  /// set the size 9
  T get s9 => this..size = 9;

  /// set the size 10
  T get s10 => this..size = 10;

  /// set the size 11
  T get s11 => this..size = 11;

  /// set the size 12
  T get s12 => this..size = 12;

  /// set the size 13
  T get s13 => this..size = 13;

  /// set the size 14
  T get s14 => this..size = 14;

  /// set the size 15
  T get s15 => this..size = 15;

  /// set the size 16
  T get s16 => this..size = 16;

  /// set the size 17
  T get s17 => this..size = 17;

  /// set the size 18
  T get s18 => this..size = 18;

  /// set the size 19
  T get s19 => this..size = 19;

  /// set the size 20
  T get s20 => this..size = 20;

  /// set the size 22
  T get s22 => this..size = 22;

  /// set the size 24
  T get s24 => this..size = 24;

  /// set the size 26
  T get s26 => this..size = 26;

  /// set the size 28
  T get s28 => this..size = 28;

  /// set the size 30
  T get s30 => this..size = 30;

  /// set the size 32
  T get s32 => this..size = 32;

  /// set the size 34
  T get s34 => this..size = 34;

  /// set the size 36
  T get s36 => this..size = 36;

  /// set the size 38
  T get s38 => this..size = 38;

  /// set the size 40
  T get s40 => this..size = 40;

  /// set the size 42
  T get s42 => this..size = 42;

  /// set the size 44
  T get s44 => this..size = 44;

  /// set the size 46
  T get s46 => this..size = 46;

  /// set the size 48
  T get s48 => this..size = 48;

  /// set the size 50
  T get s50 => this..size = 50;

  /// set the size 52
  T get s52 => this..size = 52;

  /// set the size 54
  T get s54 => this..size = 54;

  /// set the size 56
  T get s56 => this..size = 56;

  /// set the size 58
  T get s58 => this..size = 58;

  /// set the size 60
  T get s60 => this..size = 60;

  /// set the size 62
  T get s62 => this..size = 62;

  /// set the size 64
  T get s64 => this..size = 64;

  /// set the size 66
  T get s66 => this..size = 66;

  /// set the size 68
  T get s68 => this..size = 68;

  /// set the size 70
  T get s70 => this..size = 70;

  /// set the size 72
  T get s72 => this..size = 72;

  /// set the size 74
  T get s74 => this..size = 74;

  /// set the size 76
  T get s76 => this..size = 76;

  /// set the size 78
  T get s78 => this..size = 78;

  /// set the size 80
  T get s80 => this..size = 80;

  /// set the size 82
  T get s82 => this..size = 82;

  /// set the size 84
  T get s84 => this..size = 84;

  /// set the size 86
  T get s86 => this..size = 86;

  /// set the size 88
  T get s88 => this..size = 88;

  /// set the size 90
  T get s90 => this..size = 90;

  /// set the size 92
  T get s92 => this..size = 92;

  /// set the size 94
  T get s94 => this..size = 94;

  /// set the size 96
  T get s96 => this..size = 96;

  /// set the size 98
  T get s98 => this..size = 98;

  /// set the size 55
  T get s55 => this..size = 55;

  /// set the size 65
  T get s65 => this..size = 65;

  /// set the size 75
  T get s75 => this..size = 75;

  /// set the size 85
  T get s85 => this..size = 85;

  /// set the size 95
  T get s95 => this..size = 95;

  /// set the size 100
  T get s100 => this..size = 100;

  /// set the size 105
  T get s105 => this..size = 105;

  /// set the size 110
  T get s110 => this..size = 110;

  /// set the size 115
  T get s115 => this..size = 115;

  /// set the size 120
  T get s120 => this..size = 120;

  /// set the size 125
  T get s125 => this..size = 125;

  /// set the size 130
  T get s130 => this..size = 130;

  /// set the size 135
  T get s135 => this..size = 135;

  /// set the size 140
  T get s140 => this..size = 140;

  /// set the size 145
  T get s145 => this..size = 145;

  /// set the size 150
  T get s150 => this..size = 150;

  /// set the size 155
  T get s155 => this..size = 155;

  /// set the size 160
  T get s160 => this..size = 160;

  /// set the size 165
  T get s165 => this..size = 165;

  /// set the size 170
  T get s170 => this..size = 170;

  /// set the size 175
  T get s175 => this..size = 175;

  /// set the size 180
  T get s180 => this..size = 180;

  /// set the size 185
  T get s185 => this..size = 185;

  /// set the size 190
  T get s190 => this..size = 190;

  /// set the size 195
  T get s195 => this..size = 195;

  /// set the size 200
  T get s200 => this..size = 200;

  /// set the size 205
  T get s205 => this..size = 205;

  /// set the size 210
  T get s210 => this..size = 210;

  /// set the size 215
  T get s215 => this..size = 215;

  /// set the size 220
  T get s220 => this..size = 220;

  /// set the size 225
  T get s225 => this..size = 225;

  /// set the size 230
  T get s230 => this..size = 230;

  /// set the size 235
  T get s235 => this..size = 235;

  /// set the size 240
  T get s240 => this..size = 240;

  /// set the size 245
  T get s245 => this..size = 245;

  /// set the size 250
  T get s250 => this..size = 250;

  /// set the size 255
  T get s255 => this..size = 255;

  /// set the size 260
  T get s260 => this..size = 260;

  /// set the size 265
  T get s265 => this..size = 265;

  /// set the size 270
  T get s270 => this..size = 270;

  /// set the size 275
  T get s275 => this..size = 275;

  /// set the size 280
  T get s280 => this..size = 280;

  /// set the size 285
  T get s285 => this..size = 285;

  /// set the size 290
  T get s290 => this..size = 290;

  /// set the size 295
  T get s295 => this..size = 295;

  /// set the size 300
  T get s300 => this..size = 300;

  /// set the size 305
  T get s305 => this..size = 305;

  /// set the size 310
  T get s310 => this..size = 310;

  /// set the size 315
  T get s315 => this..size = 315;

  /// set the size 320
  T get s320 => this..size = 320;

  /// set the size 325
  T get s325 => this..size = 325;

  /// set the size 330
  T get s330 => this..size = 330;

  /// set the size 335
  T get s335 => this..size = 335;

  /// set the size 340
  T get s340 => this..size = 340;

  /// set the size 345
  T get s345 => this..size = 345;

  /// set the size 350
  T get s350 => this..size = 350;

  /// set the size 355
  T get s355 => this..size = 355;

  /// set the size 360
  T get s360 => this..size = 360;

  /// set the size 365
  T get s365 => this..size = 365;

  /// set the size 370
  T get s370 => this..size = 370;

  /// set the size 375
  T get s375 => this..size = 375;

  /// set the size 380
  T get s380 => this..size = 380;

  /// set the size 385
  T get s385 => this..size = 385;

  /// set the size 390
  T get s390 => this..size = 390;

  /// set the size 395
  T get s395 => this..size = 395;

  /// set the size 400
  T get s400 => this..size = 400;
}
