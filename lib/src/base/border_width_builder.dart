import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin BorderWidthBuilder {
  double? innerBorderWidth;

  double? innerBorderT;
  double? innerBorderB;
  double? innerBorderL;
  double? innerBorderR;

  Color? innerBorderTColor;
  Color? innerBorderRColor;
  Color? innerBorderBColor;
  Color? innerBorderLColor;

  Border createBorder([Color? borderColor]) {
    final borderTop = innerBorderT ?? innerBorderWidth ?? 0;
    final borderLeft = innerBorderL ?? innerBorderWidth ?? 0;
    final borderRight = innerBorderR ?? innerBorderWidth ?? 0;
    final borderBottom = innerBorderB ?? innerBorderWidth ?? 0;

    final borderT = BorderSide(color: innerBorderTColor ?? borderColor ?? Colors.white, width: borderTop);
    final borderL = BorderSide(color: innerBorderLColor ?? borderColor ?? Colors.white, width: borderLeft);
    final borderR = BorderSide(color: innerBorderRColor ?? borderColor ?? Colors.white, width: borderRight);
    final borderB = BorderSide(color: innerBorderBColor ?? borderColor ?? Colors.white, width: borderBottom);
    return Border(
      top: borderTop <= 0 ? BorderSide.none : borderT,
      bottom: borderBottom <= 0 ? BorderSide.none : borderB,
      left: borderLeft <= 0 ? BorderSide.none : borderL,
      right: borderRight <= 0 ? BorderSide.none : borderR,
    );
  }
}

extension BorderWidthBuilderExt<T extends BorderWidthBuilder> on T {
  T borderWidth(double borderWidth) => this..innerBorderWidth = borderWidth;

  ///border width 0
  T get border0 => this..innerBorderWidth = 0;

  ///border width 1
  T get border1 => this..innerBorderWidth = 1.r;

  ///border width 2
  T get border2 => this..innerBorderWidth = 2.r;

  ///border width 3
  T get border3 => this..innerBorderWidth = 3.r;

  ///border width 4
  T get border4 => this..innerBorderWidth = 4.r;

  ///border width 5
  T get border5 => this..innerBorderWidth = 5.r;

  ///border width 6
  T get border6 => this..innerBorderWidth = 6.r;

  ///border width 7
  T get border7 => this..innerBorderWidth = 7.r;

  ///border width 8
  T get border8 => this..innerBorderWidth = 8.r;

  ///border width 9
  T get border9 => this..innerBorderWidth = 9.r;

  ///border width 10
  T get border10 => this..innerBorderWidth = 10.r;

  ///border width 12
  T get border12 => this..innerBorderWidth = 12.r;

  ///border width 14
  T get border14 => this..innerBorderWidth = 14.r;

  ///border width 16
  T get border16 => this..innerBorderWidth = 16.r;

  ///border width 18
  T get border18 => this..innerBorderWidth = 18.r;

  ///border width 20
  T get border20 => this..innerBorderWidth = 20.r;

  ///border width 22
  T get border22 => this..innerBorderWidth = 22.r;

  ///border width 24
  T get border24 => this..innerBorderWidth = 24.r;

  ///border width 26
  T get border26 => this..innerBorderWidth = 26.r;

  ///border width 28
  T get border28 => this..innerBorderWidth = 28.r;

  ///border width 30
  T get border30 => this..innerBorderWidth = 30.r;

  ///border width 32
  T get border32 => this..innerBorderWidth = 32.r;

  ///border width 34
  T get border34 => this..innerBorderWidth = 34.r;

  ///border width 36
  T get border36 => this..innerBorderWidth = 36.r;

  ///border width 38
  T get border38 => this..innerBorderWidth = 38.r;

  ///border width 40
  T get border40 => this..innerBorderWidth = 40.r;

  ///border width 42
  T get border42 => this..innerBorderWidth = 42.r;

  ///border width 44
  T get border44 => this..innerBorderWidth = 44.r;

  ///border width 46
  T get border46 => this..innerBorderWidth = 46.r;

  ///border width 48
  T get border48 => this..innerBorderWidth = 48.r;

  ///border width 50
  T get border50 => this..innerBorderWidth = 50.r;

  ///set border top width 1
  T get borderT => this..innerBorderT = 1;

  T borderTop(double width, [Color? color]) {
    this..innerBorderT = width;
    this..innerBorderTColor = color;
    return this;
  }

  ///set border top width 0
  T get borderT0 => this..innerBorderT = 0;

  ///set border top width 1
  T get borderT1 => this..innerBorderT = 1;

  ///set border top width 2
  T get borderT2 => this..innerBorderT = 2;

  ///set border top width 3
  T get borderT3 => this..innerBorderT = 3;

  ///set border top width 4
  T get borderT4 => this..innerBorderT = 4;

  ///set border top width 5
  T get borderT5 => this..innerBorderT = 5;

  ///set border top width 6
  T get borderT6 => this..innerBorderT = 6;

  ///set border top width 7
  T get borderT7 => this..innerBorderT = 7;

  ///set border top width 8
  T get borderT8 => this..innerBorderT = 8;

  ///set border top width 9
  T get borderT9 => this..innerBorderT = 9;

  ///set border top width 10
  T get borderT10 => this..innerBorderT = 10;

  ///set border top width 11
  T get borderT11 => this..innerBorderT = 11;

  ///set border top width 12
  T get borderT12 => this..innerBorderT = 12;

  ///set border top width 13
  T get borderT13 => this..innerBorderT = 13;

  ///set border top width 14
  T get borderT14 => this..innerBorderT = 14;

  ///set border top width 15
  T get borderT15 => this..innerBorderT = 15;

  ///set border top width 16
  T get borderT16 => this..innerBorderT = 16;

  ///set border top width 17
  T get borderT17 => this..innerBorderT = 17;

  ///set border top width 18
  T get borderT18 => this..innerBorderT = 18;

  ///set border top width 19
  T get borderT19 => this..innerBorderT = 19;

  ///set border top width 20
  T get borderT20 => this..innerBorderT = 20;

  ///set border top width 21
  T get borderT21 => this..innerBorderT = 21;

  ///set border top width 22
  T get borderT22 => this..innerBorderT = 22;

  ///set border top width 23
  T get borderT23 => this..innerBorderT = 23;

  ///set border top width 24
  T get borderT24 => this..innerBorderT = 24;

  ///set border top width 25
  T get borderT25 => this..innerBorderT = 25;

  ///set border top width 26
  T get borderT26 => this..innerBorderT = 26;

  ///set border top width 27
  T get borderT27 => this..innerBorderT = 27;

  ///set border top width 28
  T get borderT28 => this..innerBorderT = 28;

  ///set border top width 29
  T get borderT29 => this..innerBorderT = 29;

  ///set border top width 30
  T get borderT30 => this..innerBorderT = 30;

  ///set border top width 31
  T get borderT31 => this..innerBorderT = 31;

  ///set border top width 32
  T get borderT32 => this..innerBorderT = 32;

  ///set border top width 33
  T get borderT33 => this..innerBorderT = 33;

  ///set border top width 34
  T get borderT34 => this..innerBorderT = 34;

  ///set border top width 35
  T get borderT35 => this..innerBorderT = 35;

  ///set border top width 36
  T get borderT36 => this..innerBorderT = 36;

  ///set border top width 37
  T get borderT37 => this..innerBorderT = 37;

  ///set border top width 38
  T get borderT38 => this..innerBorderT = 38;

  ///set border top width 39
  T get borderT39 => this..innerBorderT = 39;

  ///set border top width 40
  T get borderT40 => this..innerBorderT = 40;

  ///set border right width 1
  T get borderR => this..innerBorderR = 1;

  T borderRight(double width, [Color? color]) {
    this..innerBorderR = width;
    this..innerBorderRColor = color;
    return this;
  }

  ///set border right width 0
  T get borderR0 => this..innerBorderR = 0;

  ///set border right width 1
  T get borderR1 => this..innerBorderR = 1;

  ///set border right width 2
  T get borderR2 => this..innerBorderR = 2;

  ///set border right width 3
  T get borderR3 => this..innerBorderR = 3;

  ///set border right width 4
  T get borderR4 => this..innerBorderR = 4;

  ///set border right width 5
  T get borderR5 => this..innerBorderR = 5;

  ///set border right width 6
  T get borderR6 => this..innerBorderR = 6;

  ///set border right width 7
  T get borderR7 => this..innerBorderR = 7;

  ///set border right width 8
  T get borderR8 => this..innerBorderR = 8;

  ///set border right width 9
  T get borderR9 => this..innerBorderR = 9;

  ///set border right width 10
  T get borderR10 => this..innerBorderR = 10;

  ///set border right width 11
  T get borderR11 => this..innerBorderR = 11;

  ///set border right width 12
  T get borderR12 => this..innerBorderR = 12;

  ///set border right width 13
  T get borderR13 => this..innerBorderR = 13;

  ///set border right width 14
  T get borderR14 => this..innerBorderR = 14;

  ///set border right width 15
  T get borderR15 => this..innerBorderR = 15;

  ///set border right width 16
  T get borderR16 => this..innerBorderR = 16;

  ///set border right width 17
  T get borderR17 => this..innerBorderR = 17;

  ///set border right width 18
  T get borderR18 => this..innerBorderR = 18;

  ///set border right width 19
  T get borderR19 => this..innerBorderR = 19;

  ///set border right width 20
  T get borderR20 => this..innerBorderR = 20;

  ///set border right width 21
  T get borderR21 => this..innerBorderR = 21;

  ///set border right width 22
  T get borderR22 => this..innerBorderR = 22;

  ///set border right width 23
  T get borderR23 => this..innerBorderR = 23;

  ///set border right width 24
  T get borderR24 => this..innerBorderR = 24;

  ///set border right width 25
  T get borderR25 => this..innerBorderR = 25;

  ///set border right width 26
  T get borderR26 => this..innerBorderR = 26;

  ///set border right width 27
  T get borderR27 => this..innerBorderR = 27;

  ///set border right width 28
  T get borderR28 => this..innerBorderR = 28;

  ///set border right width 29
  T get borderR29 => this..innerBorderR = 29;

  ///set border right width 30
  T get borderR30 => this..innerBorderR = 30;

  ///set border right width 31
  T get borderR31 => this..innerBorderR = 31;

  ///set border right width 32
  T get borderR32 => this..innerBorderR = 32;

  ///set border right width 33
  T get borderR33 => this..innerBorderR = 33;

  ///set border right width 34
  T get borderR34 => this..innerBorderR = 34;

  ///set border right width 35
  T get borderR35 => this..innerBorderR = 35;

  ///set border right width 36
  T get borderR36 => this..innerBorderR = 36;

  ///set border right width 37
  T get borderR37 => this..innerBorderR = 37;

  ///set border right width 38
  T get borderR38 => this..innerBorderR = 38;

  ///set border right width 39
  T get borderR39 => this..innerBorderR = 39;

  ///set border right width 40
  T get borderR40 => this..innerBorderR = 40;

  T borderBottom(double width, [Color? color]) {
    this..innerBorderB = width;
    this..innerBorderBColor = color;
    return this;
  }

  ///set border bottom width 1
  T get borderB => this..innerBorderB = 1;

  ///set border bottom width 0
  T get borderB0 => this..innerBorderB = 0;

  ///set border bottom width 1
  T get borderB1 => this..innerBorderB = 1;

  ///set border bottom width 2
  T get borderB2 => this..innerBorderB = 2;

  ///set border bottom width 3
  T get borderB3 => this..innerBorderB = 3;

  ///set border bottom width 4
  T get borderB4 => this..innerBorderB = 4;

  ///set border bottom width 5
  T get borderB5 => this..innerBorderB = 5;

  ///set border bottom width 6
  T get borderB6 => this..innerBorderB = 6;

  ///set border bottom width 7
  T get borderB7 => this..innerBorderB = 7;

  ///set border bottom width 8
  T get borderB8 => this..innerBorderB = 8;

  ///set border bottom width 9
  T get borderB9 => this..innerBorderB = 9;

  ///set border bottom width 10
  T get borderB10 => this..innerBorderB = 10;

  ///set border bottom width 11
  T get borderB11 => this..innerBorderB = 11;

  ///set border bottom width 12
  T get borderB12 => this..innerBorderB = 12;

  ///set border bottom width 13
  T get borderB13 => this..innerBorderB = 13;

  ///set border bottom width 14
  T get borderB14 => this..innerBorderB = 14;

  ///set border bottom width 15
  T get borderB15 => this..innerBorderB = 15;

  ///set border bottom width 16
  T get borderB16 => this..innerBorderB = 16;

  ///set border bottom width 17
  T get borderB17 => this..innerBorderB = 17;

  ///set border bottom width 18
  T get borderB18 => this..innerBorderB = 18;

  ///set border bottom width 19
  T get borderB19 => this..innerBorderB = 19;

  ///set border bottom width 20
  T get borderB20 => this..innerBorderB = 20;

  ///set border bottom width 21
  T get borderB21 => this..innerBorderB = 21;

  ///set border bottom width 22
  T get borderB22 => this..innerBorderB = 22;

  ///set border bottom width 23
  T get borderB23 => this..innerBorderB = 23;

  ///set border bottom width 24
  T get borderB24 => this..innerBorderB = 24;

  ///set border bottom width 25
  T get borderB25 => this..innerBorderB = 25;

  ///set border bottom width 26
  T get borderB26 => this..innerBorderB = 26;

  ///set border bottom width 27
  T get borderB27 => this..innerBorderB = 27;

  ///set border bottom width 28
  T get borderB28 => this..innerBorderB = 28;

  ///set border bottom width 29
  T get borderB29 => this..innerBorderB = 29;

  ///set border bottom width 30
  T get borderB30 => this..innerBorderB = 30;

  ///set border bottom width 31
  T get borderB31 => this..innerBorderB = 31;

  ///set border bottom width 32
  T get borderB32 => this..innerBorderB = 32;

  ///set border bottom width 33
  T get borderB33 => this..innerBorderB = 33;

  ///set border bottom width 34
  T get borderB34 => this..innerBorderB = 34;

  ///set border bottom width 35
  T get borderB35 => this..innerBorderB = 35;

  ///set border bottom width 36
  T get borderB36 => this..innerBorderB = 36;

  ///set border bottom width 37
  T get borderB37 => this..innerBorderB = 37;

  ///set border bottom width 38
  T get borderB38 => this..innerBorderB = 38;

  ///set border bottom width 39
  T get borderB39 => this..innerBorderB = 39;

  ///set border bottom width 40
  T get borderB40 => this..innerBorderB = 40;

  T borderLeft(double width, [Color? color]) {
    this..innerBorderL = width;
    this..innerBorderLColor = color;
    return this;
  }

  ///set border left width 1
  T get borderL => this..innerBorderL = 1;

  ///set border left width 0
  T get borderL0 => this..innerBorderL = 0;

  ///set border left width 1
  T get borderL1 => this..innerBorderL = 1;

  ///set border left width 2
  T get borderL2 => this..innerBorderL = 2;

  ///set border left width 3
  T get borderL3 => this..innerBorderL = 3;

  ///set border left width 4
  T get borderL4 => this..innerBorderL = 4;

  ///set border left width 5
  T get borderL5 => this..innerBorderL = 5;

  ///set border left width 6
  T get borderL6 => this..innerBorderL = 6;

  ///set border left width 7
  T get borderL7 => this..innerBorderL = 7;

  ///set border left width 8
  T get borderL8 => this..innerBorderL = 8;

  ///set border left width 9
  T get borderL9 => this..innerBorderL = 9;

  ///set border left width 10
  T get borderL10 => this..innerBorderL = 10;

  ///set border left width 11
  T get borderL11 => this..innerBorderL = 11;

  ///set border left width 12
  T get borderL12 => this..innerBorderL = 12;

  ///set border left width 13
  T get borderL13 => this..innerBorderL = 13;

  ///set border left width 14
  T get borderL14 => this..innerBorderL = 14;

  ///set border left width 15
  T get borderL15 => this..innerBorderL = 15;

  ///set border left width 16
  T get borderL16 => this..innerBorderL = 16;

  ///set border left width 17
  T get borderL17 => this..innerBorderL = 17;

  ///set border left width 18
  T get borderL18 => this..innerBorderL = 18;

  ///set border left width 19
  T get borderL19 => this..innerBorderL = 19;

  ///set border left width 20
  T get borderL20 => this..innerBorderL = 20;

  ///set border left width 21
  T get borderL21 => this..innerBorderL = 21;

  ///set border left width 22
  T get borderL22 => this..innerBorderL = 22;

  ///set border left width 23
  T get borderL23 => this..innerBorderL = 23;

  ///set border left width 24
  T get borderL24 => this..innerBorderL = 24;

  ///set border left width 25
  T get borderL25 => this..innerBorderL = 25;

  ///set border left width 26
  T get borderL26 => this..innerBorderL = 26;

  ///set border left width 27
  T get borderL27 => this..innerBorderL = 27;

  ///set border left width 28
  T get borderL28 => this..innerBorderL = 28;

  ///set border left width 29
  T get borderL29 => this..innerBorderL = 29;

  ///set border left width 30
  T get borderL30 => this..innerBorderL = 30;

  ///set border left width 31
  T get borderL31 => this..innerBorderL = 31;

  ///set border left width 32
  T get borderL32 => this..innerBorderL = 32;

  ///set border left width 33
  T get borderL33 => this..innerBorderL = 33;

  ///set border left width 34
  T get borderL34 => this..innerBorderL = 34;

  ///set border left width 35
  T get borderL35 => this..innerBorderL = 35;

  ///set border left width 36
  T get borderL36 => this..innerBorderL = 36;

  ///set border left width 37
  T get borderL37 => this..innerBorderL = 37;

  ///set border left width 38
  T get borderL38 => this..innerBorderL = 38;

  ///set border left width 39
  T get borderL39 => this..innerBorderL = 39;

  ///set border left width 40
  T get borderL40 => this..innerBorderL = 40;
}
