import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/8/26
/// describe:
mixin MarginBuilder {
  double? marginValue;
  double? marginLeft;
  double? marginRight;
  double? marginTop;
  double? marginBottom;

  double? marginHorizontal;
  double? marginVertical;

  EdgeInsetsGeometry? _innerMargin;

  bool get hasMargin =>
      _innerMargin != null ||
      marginValue != null ||
      marginHorizontal != null ||
      marginVertical != null ||
      marginLeft != null ||
      marginRight != null ||
      marginTop != null ||
      marginBottom != null;

  EdgeInsetsGeometry? get finalMargin {
    if (_innerMargin != null) return _innerMargin;
    if (hasMargin) {
      return EdgeInsets.only(
        left: marginLeft ?? marginHorizontal ?? marginValue ?? 0.0,
        right: marginRight ?? marginHorizontal ?? marginValue ?? 0.0,
        top: marginTop ?? marginVertical ?? marginValue ?? 0.0,
        bottom: marginBottom ?? marginVertical ?? marginValue ?? 0.0,
      );
    }
    return null;
  }
}

extension MarginBuilderBuilderExt<T extends MarginBuilder> on T {
  T margin(EdgeInsetsGeometry? padding) => this.._innerMargin = padding;

  ///set the margin value is 2
  T get m2 => this..marginValue = 2.r;

  ///set the margin value is 4
  T get m4 => this..marginValue = 4.r;

  ///set the margin value is 6
  T get m6 => this..marginValue = 6.r;

  ///set the margin value is 8
  T get m8 => this..marginValue = 8.r;

  ///set the margin value is 10
  T get m10 => this..marginValue = 10.r;

  ///set the margin value is 12
  T get m12 => this..marginValue = 12.r;

  ///set the margin value is 14
  T get m14 => this..marginValue = 14.r;

  ///set the margin value is 16
  T get m16 => this..marginValue = 16.r;

  ///set the margin value is 18
  T get m18 => this..marginValue = 18.r;

  ///set the margin value is 20
  T get m20 => this..marginValue = 20.r;

  ///set the margin value is 22
  T get m22 => this..marginValue = 22.r;

  ///set the margin value is 24
  T get m24 => this..marginValue = 24.r;

  ///set the margin value is 26
  T get m26 => this..marginValue = 26.r;

  ///set the margin value is 28
  T get m28 => this..marginValue = 28.r;

  ///set the margin value is 30
  T get m30 => this..marginValue = 30.r;

  ///set the margin value is 32
  T get m32 => this..marginValue = 32.r;

  /// set the margin value is 34
  T get m34 => this..marginValue = 34.r;

  /// set the margin value is 36
  T get m36 => this..marginValue = 36.r;

  /// set the margin value is 38
  T get m38 => this..marginValue = 38.r;

  /// set the margin value is 40
  T get m40 => this..marginValue = 40.r;

  /// set the margin value is 42
  T get m42 => this..marginValue = 42.r;

  /// set the margin value is 44
  T get m44 => this..marginValue = 44.r;

  /// set the margin value is 46
  T get m46 => this..marginValue = 46.r;

  /// set the margin value is 48
  T get m48 => this..marginValue = 48.r;

  /// set the margin value is 50
  T get m50 => this..marginValue = 50.r;

  /// set the margin value is 52
  T get m52 => this..marginValue = 52.r;

  /// set the margin value is 54
  T get m54 => this..marginValue = 54.r;

  /// set the margin value is 56
  T get m56 => this..marginValue = 56.r;

  /// set the margin value is 58
  T get m58 => this..marginValue = 58.r;

  /// set the margin value is 60
  T get m60 => this..marginValue = 60.r;

  /// set the margin value is 62
  T get m62 => this..marginValue = 62.r;

  /// set the margin value is 64
  T get m64 => this..marginValue = 64.r;

  /// set the margin value is 66
  T get m66 => this..marginValue = 66.r;

  /// set the margin value is 68
  T get m68 => this..marginValue = 68.r;

  /// set the margin value is 70
  T get m70 => this..marginValue = 70.r;

  /// set the margin value is 72
  T get m72 => this..marginValue = 72.r;

  /// set the margin value is 74
  T get m74 => this..marginValue = 74.r;

  /// set the margin value is 76
  T get m76 => this..marginValue = 76.r;

  /// set the margin value is 78
  T get m78 => this..marginValue = 78.r;

  /// set the margin value is 80
  T get m80 => this..marginValue = 80.r;

  /// set the margin left is 2
  T get ml2 => this..marginLeft = 2.r;

  /// set the margin left is 4
  T get ml4 => this..marginLeft = 4.r;

  /// set the margin left is 6
  T get ml6 => this..marginLeft = 6.r;

  /// set the margin left is 8
  T get ml8 => this..marginLeft = 8.r;

  /// set the margin left is 10
  T get ml10 => this..marginLeft = 10.r;

  /// set the margin left is 12
  T get ml12 => this..marginLeft = 12.r;

  /// set the margin left is 14
  T get ml14 => this..marginLeft = 14.r;

  /// set the margin left is 16
  T get ml16 => this..marginLeft = 16.r;

  /// set the margin left is 18
  T get ml18 => this..marginLeft = 18.r;

  /// set the margin left is 20
  T get ml20 => this..marginLeft = 20.r;

  /// set the margin left is 22
  T get ml22 => this..marginLeft = 22.r;

  /// set the margin left is 24
  T get ml24 => this..marginLeft = 24.r;

  /// set the margin left is 26
  T get ml26 => this..marginLeft = 26.r;

  /// set the margin left is 28
  T get ml28 => this..marginLeft = 28.r;

  /// set the margin left is 30
  T get ml30 => this..marginLeft = 30.r;

  /// set the margin left is 32
  T get ml32 => this..marginLeft = 32.r;

  /// set the margin left is 34
  T get ml34 => this..marginLeft = 34.r;

  /// set the margin left is 36
  T get ml36 => this..marginLeft = 36.r;

  /// set the margin left is 38
  T get ml38 => this..marginLeft = 38.r;

  /// set the margin left is 40
  T get ml40 => this..marginLeft = 40.r;

  /// set the margin left is 42
  T get ml42 => this..marginLeft = 42.r;

  /// set the margin left is 44
  T get ml44 => this..marginLeft = 44.r;

  /// set the margin left is 46
  T get ml46 => this..marginLeft = 46.r;

  /// set the margin left is 48
  T get ml48 => this..marginLeft = 48.r;

  /// set the margin left is 50
  T get ml50 => this..marginLeft = 50.r;

  /// set the margin left is 52
  T get ml52 => this..marginLeft = 52.r;

  /// set the margin left is 54
  T get ml54 => this..marginLeft = 54.r;

  /// set the margin left is 56
  T get ml56 => this..marginLeft = 56.r;

  /// set the margin left is 58
  T get ml58 => this..marginLeft = 58.r;

  /// set the margin left is 60
  T get ml60 => this..marginLeft = 60.r;

  /// set the margin left is 62
  T get ml62 => this..marginLeft = 62.r;

  /// set the margin left is 64
  T get ml64 => this..marginLeft = 64.r;

  /// set the margin left is 66
  T get ml66 => this..marginLeft = 66.r;

  /// set the margin left is 68
  T get ml68 => this..marginLeft = 68.r;

  /// set the margin left is 70
  T get ml70 => this..marginLeft = 70.r;

  /// set the margin left is 72
  T get ml72 => this..marginLeft = 72.r;

  /// set the margin left is 74
  T get ml74 => this..marginLeft = 74.r;

  /// set the margin left is 76
  T get ml76 => this..marginLeft = 76.r;

  /// set the margin left is 78
  T get ml78 => this..marginLeft = 78.r;

  /// set the margin left is 80
  T get ml80 => this..marginLeft = 80.r;

  /// set the margin right is 2
  T get mr2 => this..marginRight = 2.r;

  /// set the margin right is 4
  T get mr4 => this..marginRight = 4.r;

  /// set the margin right is 6
  T get mr6 => this..marginRight = 6.r;

  /// set the margin right is 8
  T get mr8 => this..marginRight = 8.r;

  /// set the margin right is 10
  T get mr10 => this..marginRight = 10.r;

  /// set the margin right is 12
  T get mr12 => this..marginRight = 12.r;

  /// set the margin right is 14
  T get mr14 => this..marginRight = 14.r;

  /// set the margin right is 16
  T get mr16 => this..marginRight = 16.r;

  /// set the margin right is 18
  T get mr18 => this..marginRight = 18.r;

  /// set the margin right is 20
  T get mr20 => this..marginRight = 20.r;

  /// set the margin right is 22
  T get mr22 => this..marginRight = 22.r;

  /// set the margin right is 24
  T get mr24 => this..marginRight = 24.r;

  /// set the margin right is 26
  T get mr26 => this..marginRight = 26.r;

  /// set the margin right is 28
  T get mr28 => this..marginRight = 28.r;

  /// set the margin right is 30
  T get mr30 => this..marginRight = 30.r;

  /// set the margin right is 32
  T get mr32 => this..marginRight = 32.r;

  /// set the margin right is 34
  T get mr34 => this..marginRight = 34.r;

  /// set the margin right is 36
  T get mr36 => this..marginRight = 36.r;

  /// set the margin right is 38
  T get mr38 => this..marginRight = 38.r;

  /// set the margin right is 40
  T get mr40 => this..marginRight = 40.r;

  /// set the margin right is 42
  T get mr42 => this..marginRight = 42.r;

  /// set the margin right is 44
  T get mr44 => this..marginRight = 44.r;

  /// set the margin right is 46
  T get mr46 => this..marginRight = 46.r;

  /// set the margin right is 48
  T get mr48 => this..marginRight = 48.r;

  /// set the margin right is 50
  T get mr50 => this..marginRight = 50.r;

  /// set the margin right is 52
  T get mr52 => this..marginRight = 52.r;

  /// set the margin right is 54
  T get mr54 => this..marginRight = 54.r;

  /// set the margin right is 56
  T get mr56 => this..marginRight = 56.r;

  /// set the margin right is 58
  T get mr58 => this..marginRight = 58.r;

  /// set the margin right is 60
  T get mr60 => this..marginRight = 60.r;

  /// set the margin right is 62
  T get mr62 => this..marginRight = 62.r;

  /// set the margin right is 64
  T get mr64 => this..marginRight = 64.r;

  /// set the margin right is 66
  T get mr66 => this..marginRight = 66.r;

  /// set the margin right is 68
  T get mr68 => this..marginRight = 68.r;

  /// set the margin right is 70
  T get mr70 => this..marginRight = 70.r;

  /// set the margin right is 72
  T get mr72 => this..marginRight = 72.r;

  /// set the margin right is 74
  T get mr74 => this..marginRight = 74.r;

  /// set the margin right is 76
  T get mr76 => this..marginRight = 76.r;

  /// set the margin right is 78
  T get mr78 => this..marginRight = 78.r;

  /// set the margin right is 80
  T get mr80 => this..marginRight = 80.r;

  /// set the margin top is 2
  T get mt2 => this..marginTop = 2.r;

  /// set the margin top is 4
  T get mt4 => this..marginTop = 4.r;

  /// set the margin top is 6
  T get mt6 => this..marginTop = 6.r;

  /// set the margin top is 8
  T get mt8 => this..marginTop = 8.r;

  /// set the margin top is 10
  T get mt10 => this..marginTop = 10.r;

  /// set the margin top is 12
  T get mt12 => this..marginTop = 12.r;

  /// set the margin top is 14
  T get mt14 => this..marginTop = 14.r;

  /// set the margin top is 16
  T get mt16 => this..marginTop = 16.r;

  /// set the margin top is 18
  T get mt18 => this..marginTop = 18.r;

  /// set the margin top is 20
  T get mt20 => this..marginTop = 20.r;

  /// set the margin top is 22
  T get mt22 => this..marginTop = 22.r;

  /// set the margin top is 24
  T get mt24 => this..marginTop = 24.r;

  /// set the margin top is 26
  T get mt26 => this..marginTop = 26.r;

  /// set the margin top is 28
  T get mt28 => this..marginTop = 28.r;

  /// set the margin top is 30
  T get mt30 => this..marginTop = 30.r;

  /// set the margin top is 32
  T get mt32 => this..marginTop = 32.r;

  /// set the margin top is 34
  T get mt34 => this..marginTop = 34.r;

  /// set the margin top is 36
  T get mt36 => this..marginTop = 36.r;

  /// set the margin top is 38
  T get mt38 => this..marginTop = 38.r;

  /// set the margin top is 40
  T get mt40 => this..marginTop = 40.r;

  /// set the margin top is 42
  T get mt42 => this..marginTop = 42.r;

  /// set the margin top is 44
  T get mt44 => this..marginTop = 44.r;

  /// set the margin top is 46
  T get mt46 => this..marginTop = 46.r;

  /// set the margin top is 48
  T get mt48 => this..marginTop = 48.r;

  /// set the margin top is 50
  T get mt50 => this..marginTop = 50.r;

  /// set the margin top is 52
  T get mt52 => this..marginTop = 52.r;

  /// set the margin top is 54
  T get mt54 => this..marginTop = 54.r;

  /// set the margin top is 56
  T get mt56 => this..marginTop = 56.r;

  /// set the margin top is 58
  T get mt58 => this..marginTop = 58.r;

  /// set the margin top is 60
  T get mt60 => this..marginTop = 60.r;

  /// set the margin top is 62
  T get mt62 => this..marginTop = 62.r;

  /// set the margin top is 64
  T get mt64 => this..marginTop = 64.r;

  /// set the margin top is 66
  T get mt66 => this..marginTop = 66.r;

  /// set the margin top is 68
  T get mt68 => this..marginTop = 68.r;

  /// set the margin top is 70
  T get mt70 => this..marginTop = 70.r;

  /// set the margin top is 72
  T get mt72 => this..marginTop = 72.r;

  /// set the margin top is 74
  T get mt74 => this..marginTop = 74.r;

  /// set the margin top is 76
  T get mt76 => this..marginTop = 76.r;

  /// set the margin top is 78
  T get mt78 => this..marginTop = 78.r;

  /// set the margin top is 80
  T get mt80 => this..marginTop = 80.r;

  /// set the margin bottom is 2
  T get mb2 => this..marginBottom = 2.r;

  /// set the margin bottom is 4
  T get mb4 => this..marginBottom = 4.r;

  /// set the margin bottom is 6
  T get mb6 => this..marginBottom = 6.r;

  /// set the margin bottom is 8
  T get mb8 => this..marginBottom = 8.r;

  /// set the margin bottom is 10
  T get mb10 => this..marginBottom = 10.r;

  /// set the margin bottom is 12
  T get mb12 => this..marginBottom = 12.r;

  /// set the margin bottom is 14
  T get mb14 => this..marginBottom = 14.r;

  /// set the margin bottom is 16
  T get mb16 => this..marginBottom = 16.r;

  /// set the margin bottom is 18
  T get mb18 => this..marginBottom = 18.r;

  /// set the margin bottom is 20
  T get mb20 => this..marginBottom = 20.r;

  /// set the margin bottom is 22
  T get mb22 => this..marginBottom = 22.r;

  /// set the margin bottom is 24
  T get mb24 => this..marginBottom = 24.r;

  /// set the margin bottom is 26
  T get mb26 => this..marginBottom = 26.r;

  /// set the margin bottom is 28
  T get mb28 => this..marginBottom = 28.r;

  /// set the margin bottom is 30
  T get mb30 => this..marginBottom = 30.r;

  /// set the margin bottom is 32
  T get mb32 => this..marginBottom = 32.r;

  /// set the margin bottom is 34
  T get mb34 => this..marginBottom = 34.r;

  /// set the margin bottom is 36
  T get mb36 => this..marginBottom = 36.r;

  /// set the margin bottom is 38
  T get mb38 => this..marginBottom = 38.r;

  /// set the margin bottom is 40
  T get mb40 => this..marginBottom = 40.r;

  /// set the margin bottom is 42
  T get mb42 => this..marginBottom = 42.r;

  /// set the margin bottom is 44
  T get mb44 => this..marginBottom = 44.r;

  /// set the margin bottom is 46
  T get mb46 => this..marginBottom = 46.r;

  /// set the margin bottom is 48
  T get mb48 => this..marginBottom = 48.r;

  /// set the margin bottom is 50
  T get mb50 => this..marginBottom = 50.r;

  /// set the margin bottom is 52
  T get mb52 => this..marginBottom = 52.r;

  /// set the margin bottom is 54
  T get mb54 => this..marginBottom = 54.r;

  /// set the margin bottom is 56
  T get mb56 => this..marginBottom = 56.r;

  /// set the margin bottom is 58
  T get mb58 => this..marginBottom = 58.r;

  /// set the margin bottom is 60
  T get mb60 => this..marginBottom = 60.r;

  /// set the margin bottom is 62
  T get mb62 => this..marginBottom = 62.r;

  /// set the margin bottom is 64
  T get mb64 => this..marginBottom = 64.r;

  /// set the margin bottom is 66
  T get mb66 => this..marginBottom = 66.r;

  /// set the margin bottom is 68
  T get mb68 => this..marginBottom = 68.r;

  /// set the margin bottom is 70
  T get mb70 => this..marginBottom = 70.r;

  /// set the margin bottom is 72
  T get mb72 => this..marginBottom = 72.r;

  /// set the margin bottom is 74
  T get mb74 => this..marginBottom = 74.r;

  /// set the margin bottom is 76
  T get mb76 => this..marginBottom = 76.r;

  /// set the margin bottom is 78
  T get mb78 => this..marginBottom = 78.r;

  /// set the margin bottom is 80
  T get mb80 => this..marginBottom = 80.r;

  /// set the margin horizontal value is 2
  T get mh2 => this..marginHorizontal = 2.r;

  /// set the margin horizontal value is 4
  T get mh4 => this..marginHorizontal = 4.r;

  /// set the margin horizontal value is 6
  T get mh6 => this..marginHorizontal = 6.r;

  /// set the margin horizontal value is 8
  T get mh8 => this..marginHorizontal = 8.r;

  /// set the margin horizontal value is 10
  T get mh10 => this..marginHorizontal = 10.r;

  /// set the margin horizontal value is 12
  T get mh12 => this..marginHorizontal = 12.r;

  /// set the margin horizontal value is 14
  T get mh14 => this..marginHorizontal = 14.r;

  /// set the margin horizontal value is 16
  T get mh16 => this..marginHorizontal = 16.r;

  /// set the margin horizontal value is 18
  T get mh18 => this..marginHorizontal = 18.r;

  /// set the margin horizontal value is 20
  T get mh20 => this..marginHorizontal = 20.r;

  /// set the margin horizontal value is 22
  T get mh22 => this..marginHorizontal = 22.r;

  /// set the margin horizontal value is 24
  T get mh24 => this..marginHorizontal = 24.r;

  /// set the margin horizontal value is 26
  T get mh26 => this..marginHorizontal = 26.r;

  /// set the margin horizontal value is 28
  T get mh28 => this..marginHorizontal = 28.r;

  /// set the margin horizontal value is 30
  T get mh30 => this..marginHorizontal = 30.r;

  /// set the margin horizontal value is 32
  T get mh32 => this..marginHorizontal = 32.r;

  /// set the margin horizontal value is 34
  T get mh34 => this..marginHorizontal = 34.r;

  /// set the margin horizontal value is 36
  T get mh36 => this..marginHorizontal = 36.r;

  /// set the margin horizontal value is 38
  T get mh38 => this..marginHorizontal = 38.r;

  /// set the margin horizontal value is 40
  T get mh40 => this..marginHorizontal = 40.r;

  /// set the margin horizontal value is 42
  T get mh42 => this..marginHorizontal = 42.r;

  /// set the margin horizontal value is 44
  T get mh44 => this..marginHorizontal = 44.r;

  /// set the margin horizontal value is 46
  T get mh46 => this..marginHorizontal = 46.r;

  /// set the margin horizontal value is 48
  T get mh48 => this..marginHorizontal = 48.r;

  /// set the margin horizontal value is 50
  T get mh50 => this..marginHorizontal = 50.r;

  /// set the margin horizontal value is 52
  T get mh52 => this..marginHorizontal = 52.r;

  /// set the margin horizontal value is 54
  T get mh54 => this..marginHorizontal = 54.r;

  /// set the margin horizontal value is 56
  T get mh56 => this..marginHorizontal = 56.r;

  /// set the margin horizontal value is 58
  T get mh58 => this..marginHorizontal = 58.r;

  /// set the margin horizontal value is 60
  T get mh60 => this..marginHorizontal = 60.r;

  /// set the margin horizontal value is 62
  T get mh62 => this..marginHorizontal = 62.r;

  /// set the margin horizontal value is 64
  T get mh64 => this..marginHorizontal = 64.r;

  /// set the margin horizontal value is 66
  T get mh66 => this..marginHorizontal = 66.r;

  /// set the margin horizontal value is 68
  T get mh68 => this..marginHorizontal = 68.r;

  /// set the margin horizontal value is 70
  T get mh70 => this..marginHorizontal = 70.r;

  /// set the margin horizontal value is 72
  T get mh72 => this..marginHorizontal = 72.r;

  /// set the margin horizontal value is 74
  T get mh74 => this..marginHorizontal = 74.r;

  /// set the margin horizontal value is 76
  T get mh76 => this..marginHorizontal = 76.r;

  /// set the margin horizontal value is 78
  T get mh78 => this..marginHorizontal = 78.r;

  /// set the margin horizontal value is 80
  T get mh80 => this..marginHorizontal = 80.r;

  /// set the margin vertical value is 2
  T get mv2 => this..marginVertical = 2.r;

  /// set the margin vertical value is 4
  T get mv4 => this..marginVertical = 4.r;

  /// set the margin vertical value is 6
  T get mv6 => this..marginVertical = 6.r;

  /// set the margin vertical value is 8
  T get mv8 => this..marginVertical = 8.r;

  /// set the margin vertical value is 10
  T get mv10 => this..marginVertical = 10.r;

  /// set the margin vertical value is 12
  T get mv12 => this..marginVertical = 12.r;

  /// set the margin vertical value is 14
  T get mv14 => this..marginVertical = 14.r;

  /// set the margin vertical value is 16
  T get mv16 => this..marginVertical = 16.r;

  /// set the margin vertical value is 18
  T get mv18 => this..marginVertical = 18.r;

  /// set the margin vertical value is 20
  T get mv20 => this..marginVertical = 20.r;

  /// set the margin vertical value is 22
  T get mv22 => this..marginVertical = 22.r;

  /// set the margin vertical value is 24
  T get mv24 => this..marginVertical = 24.r;

  /// set the margin vertical value is 26
  T get mv26 => this..marginVertical = 26.r;

  /// set the margin vertical value is 28
  T get mv28 => this..marginVertical = 28.r;

  /// set the margin vertical value is 30
  T get mv30 => this..marginVertical = 30.r;

  /// set the margin vertical value is 32
  T get mv32 => this..marginVertical = 32.r;

  /// set the margin vertical value is 34
  T get mv34 => this..marginVertical = 34.r;

  /// set the margin vertical value is 36
  T get mv36 => this..marginVertical = 36.r;

  /// set the margin vertical value is 38
  T get mv38 => this..marginVertical = 38.r;

  /// set the margin vertical value is 40
  T get mv40 => this..marginVertical = 40.r;

  /// set the margin vertical value is 42
  T get mv42 => this..marginVertical = 42.r;

  /// set the margin vertical value is 44
  T get mv44 => this..marginVertical = 44.r;

  /// set the margin vertical value is 46
  T get mv46 => this..marginVertical = 46.r;

  /// set the margin vertical value is 48
  T get mv48 => this..marginVertical = 48.r;

  /// set the margin vertical value is 50
  T get mv50 => this..marginVertical = 50.r;

  /// set the margin vertical value is 52
  T get mv52 => this..marginVertical = 52.r;

  /// set the margin vertical value is 54
  T get mv54 => this..marginVertical = 54.r;

  /// set the margin vertical value is 56
  T get mv56 => this..marginVertical = 56.r;

  /// set the margin vertical value is 58
  T get mv58 => this..marginVertical = 58.r;

  /// set the margin vertical value is 60
  T get mv60 => this..marginVertical = 60.r;

  /// set the margin vertical value is 62
  T get mv62 => this..marginVertical = 62.r;

  /// set the margin vertical value is 64
  T get mv64 => this..marginVertical = 64.r;

  /// set the margin vertical value is 66
  T get mv66 => this..marginVertical = 66.r;

  /// set the margin vertical value is 68
  T get mv68 => this..marginVertical = 68.r;

  /// set the margin vertical value is 70
  T get mv70 => this..marginVertical = 70.r;

  /// set the margin vertical value is 72
  T get mv72 => this..marginVertical = 72.r;

  /// set the margin vertical value is 74
  T get mv74 => this..marginVertical = 74.r;

  /// set the margin vertical value is 76
  T get mv76 => this..marginVertical = 76.r;

  /// set the margin vertical value is 78
  T get mv78 => this..marginVertical = 78.r;

  /// set the margin vertical value is 80
  T get mv80 => this..marginVertical = 80.r;
}
