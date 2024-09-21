import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/8/26
/// describe:
mixin PaddingBuilder {
  double? paddingValue;
  double? paddingLeft;
  double? paddingRight;
  double? paddingTop;
  double? paddingBottom;

  double? paddingHorizontal;
  double? paddingVertical;

  EdgeInsetsGeometry? _innerPadding;

  bool get hasPadding =>
      _innerPadding != null ||
      paddingValue != null ||
      paddingHorizontal != null ||
      paddingVertical != null ||
      paddingLeft != null ||
      paddingRight != null ||
      paddingTop != null ||
      paddingBottom != null;

  EdgeInsetsGeometry? get finalPadding {
    if (_innerPadding != null) return _innerPadding;
    if (hasPadding) {
      return EdgeInsets.only(
        left: paddingLeft ?? paddingHorizontal ?? paddingValue ?? 0.0,
        right: paddingRight ?? paddingHorizontal ?? paddingValue ?? 0.0,
        top: paddingTop ?? paddingVertical ?? paddingValue ?? 0.0,
        bottom: paddingBottom ?? paddingVertical ?? paddingValue ?? 0.0,
      );
    }
    return null;
  }
}

extension PaddingBuilderExt<T extends PaddingBuilder> on T {
  T padding(EdgeInsetsGeometry? padding) => this.._innerPadding = padding;

  ///padding all 2
  T get p2 => this..paddingValue = 2.r;

  ///padding all 4
  T get p4 => this..paddingValue = 4.r;

  ///padding all 6
  T get p6 => this..paddingValue = 6.r;

  ///padding all 8
  T get p8 => this..paddingValue = 8.r;

  ///padding all 10
  T get p10 => this..paddingValue = 10.r;

  ///padding all 12
  T get p12 => this..paddingValue = 12.r;

  ///padding all 14
  T get p14 => this..paddingValue = 14.r;

  ///padding all 16
  T get p16 => this..paddingValue = 16.r;

  ///padding all 18
  T get p18 => this..paddingValue = 18.r;

  ///padding all 20
  T get p20 => this..paddingValue = 20.r;

  ///padding all 22
  T get p22 => this..paddingValue = 22.r;

  ///padding all 24
  T get p24 => this..paddingValue = 24.r;

  ///padding all 26
  T get p26 => this..paddingValue = 26.r;

  ///padding all 28
  T get p28 => this..paddingValue = 28.r;

  ///padding all 30
  T get p30 => this..paddingValue = 30.r;

  ///padding all 32
  T get p32 => this..paddingValue = 32.r;

  ///padding all 34
  T get p34 => this..paddingValue = 34.r;

  ///padding all 36
  T get p36 => this..paddingValue = 36.r;

  ///padding all 38
  T get p38 => this..paddingValue = 38.r;

  ///padding all 40
  T get p40 => this..paddingValue = 40.r;

  ///padding all 42
  T get p42 => this..paddingValue = 42.r;

  ///padding all 44
  T get p44 => this..paddingValue = 44.r;

  ///padding all 46
  T get p46 => this..paddingValue = 46.r;

  ///padding all 48
  T get p48 => this..paddingValue = 48.r;

  ///padding all 50
  T get p50 => this..paddingValue = 50.r;

  /// padding all 52
  T get p52 => this..paddingValue = 52.r;

  /// padding all 54
  T get p54 => this..paddingValue = 54.r;

  /// padding all 56
  T get p56 => this..paddingValue = 56.r;

  /// padding all 58
  T get p58 => this..paddingValue = 58.r;

  /// padding all 60
  T get p60 => this..paddingValue = 60.r;

  /// padding all 62
  T get p62 => this..paddingValue = 62.r;

  /// padding all 64
  T get p64 => this..paddingValue = 64.r;

  /// padding all 66
  T get p66 => this..paddingValue = 66.r;

  /// padding all 68
  T get p68 => this..paddingValue = 68.r;

  /// padding all 70
  T get p70 => this..paddingValue = 70.r;

  /// padding all 72
  T get p72 => this..paddingValue = 72.r;

  /// padding all 74
  T get p74 => this..paddingValue = 74.r;

  /// padding all 76
  T get p76 => this..paddingValue = 76.r;

  /// padding all 78
  T get p78 => this..paddingValue = 78.r;

  /// padding all 80
  T get p80 => this..paddingValue = 80.r;

  ///padding left 2
  T get pl2 => this..paddingLeft = 2.r;

  ///padding left 4
  T get pl4 => this..paddingLeft = 4.r;

  ///padding left 6
  T get pl6 => this..paddingLeft = 6.r;

  ///padding left 8
  T get pl8 => this..paddingLeft = 8.r;

  ///padding left 10
  T get pl10 => this..paddingLeft = 10.r;

  ///padding left 12
  T get pl12 => this..paddingLeft = 12.r;

  ///padding left 14
  T get pl14 => this..paddingLeft = 14.r;

  ///padding left 16
  T get pl16 => this..paddingLeft = 16.r;

  ///padding left 18
  T get pl18 => this..paddingLeft = 18.r;

  ///padding left 20
  T get pl20 => this..paddingLeft = 20.r;

  ///padding left 22
  T get pl22 => this..paddingLeft = 22.r;

  ///padding left 24
  T get pl24 => this..paddingLeft = 24.r;

  ///padding left 26
  T get pl26 => this..paddingLeft = 26.r;

  ///padding left 28
  T get pl28 => this..paddingLeft = 28.r;

  ///padding left 30
  T get pl30 => this..paddingLeft = 30.r;

  ///padding left 32
  T get pl32 => this..paddingLeft = 32.r;

  ///padding left 34
  T get pl34 => this..paddingLeft = 34.r;

  ///padding left 36
  T get pl36 => this..paddingLeft = 36.r;

  ///padding left 38
  T get pl38 => this..paddingLeft = 38.r;

  ///padding left 40
  T get pl40 => this..paddingLeft = 40.r;

  ///padding left 42
  T get pl42 => this..paddingLeft = 42.r;

  ///padding left 44
  T get pl44 => this..paddingLeft = 44.r;

  ///padding left 46
  T get pl46 => this..paddingLeft = 46.r;

  ///padding left 48
  T get pl48 => this..paddingLeft = 48.r;

  ///padding left 50
  T get pl50 => this..paddingLeft = 50.r;

  /// set the padding left is 52
  T get pl52 => this..paddingLeft = 52.r;

  /// set the padding left is 54
  T get pl54 => this..paddingLeft = 54.r;

  /// set the padding left is 56
  T get pl56 => this..paddingLeft = 56.r;

  /// set the padding left is 58
  T get pl58 => this..paddingLeft = 58.r;

  /// set the padding left is 60
  T get pl60 => this..paddingLeft = 60.r;

  /// set the padding left is 62
  T get pl62 => this..paddingLeft = 62.r;

  /// set the padding left is 64
  T get pl64 => this..paddingLeft = 64.r;

  /// set the padding left is 66
  T get pl66 => this..paddingLeft = 66.r;

  /// set the padding left is 68
  T get pl68 => this..paddingLeft = 68.r;

  /// set the padding left is 70
  T get pl70 => this..paddingLeft = 70.r;

  /// set the padding left is 72
  T get pl72 => this..paddingLeft = 72.r;

  /// set the padding left is 74
  T get pl74 => this..paddingLeft = 74.r;

  /// set the padding left is 76
  T get pl76 => this..paddingLeft = 76.r;

  /// set the padding left is 78
  T get pl78 => this..paddingLeft = 78.r;

  /// set the padding left is 80
  T get pl80 => this..paddingLeft = 80.r;

  ///padding right 2
  T get pr2 => this..paddingRight = 2.r;

  ///padding right 4
  T get pr4 => this..paddingRight = 4.r;

  ///padding right 6
  T get pr6 => this..paddingRight = 6.r;

  ///padding right 8
  T get pr8 => this..paddingRight = 8.r;

  ///padding right 10
  T get pr10 => this..paddingRight = 10.r;

  ///padding right 12
  T get pr12 => this..paddingRight = 12.r;

  ///padding right 14
  T get pr14 => this..paddingRight = 14.r;

  ///padding right 16
  T get pr16 => this..paddingRight = 16.r;

  ///padding right 18
  T get pr18 => this..paddingRight = 18.r;

  ///padding right 20
  T get pr20 => this..paddingRight = 20.r;

  ///padding right 22
  T get pr22 => this..paddingRight = 22.r;

  ///padding right 24
  T get pr24 => this..paddingRight = 24.r;

  ///padding right 26
  T get pr26 => this..paddingRight = 26.r;

  ///padding right 28
  T get pr28 => this..paddingRight = 28.r;

  ///padding right 30
  T get pr30 => this..paddingRight = 30.r;

  ///padding right 32
  T get pr32 => this..paddingRight = 32.r;

  ///padding right 34
  T get pr34 => this..paddingRight = 34.r;

  ///padding right 36
  T get pr36 => this..paddingRight = 36.r;

  ///padding right 38
  T get pr38 => this..paddingRight = 38.r;

  ///padding right 40
  T get pr40 => this..paddingRight = 40.r;

  ///padding right 42
  T get pr42 => this..paddingRight = 42.r;

  ///padding right 44
  T get pr44 => this..paddingRight = 44.r;

  ///padding right 46
  T get pr46 => this..paddingRight = 46.r;

  ///padding right 48
  T get pr48 => this..paddingRight = 48.r;

  ///padding right 50
  T get pr50 => this..paddingRight = 50.r;

  /// set the padding right is 52
  T get pr52 => this..paddingRight = 52.r;

  /// set the padding right is 54
  T get pr54 => this..paddingRight = 54.r;

  /// set the padding right is 56
  T get pr56 => this..paddingRight = 56.r;

  /// set the padding right is 58
  T get pr58 => this..paddingRight = 58.r;

  /// set the padding right is 60
  T get pr60 => this..paddingRight = 60.r;

  /// set the padding right is 62
  T get pr62 => this..paddingRight = 62.r;

  /// set the padding right is 64
  T get pr64 => this..paddingRight = 64.r;

  /// set the padding right is 66
  T get pr66 => this..paddingRight = 66.r;

  /// set the padding right is 68
  T get pr68 => this..paddingRight = 68.r;

  /// set the padding right is 70
  T get pr70 => this..paddingRight = 70.r;

  /// set the padding right is 72
  T get pr72 => this..paddingRight = 72.r;

  /// set the padding right is 74
  T get pr74 => this..paddingRight = 74.r;

  /// set the padding right is 76
  T get pr76 => this..paddingRight = 76.r;

  /// set the padding right is 78
  T get pr78 => this..paddingRight = 78.r;

  /// set the padding right is 80
  T get pr80 => this..paddingRight = 80.r;

  ///padding top 2
  T get pt2 => this..paddingTop = 2.r;

  ///padding top 4
  T get pt4 => this..paddingTop = 4.r;

  ///padding top 6
  T get pt6 => this..paddingTop = 6.r;

  ///padding top 8
  T get pt8 => this..paddingTop = 8.r;

  ///padding top 10
  T get pt10 => this..paddingTop = 10.r;

  ///padding top 12
  T get pt12 => this..paddingTop = 12.r;

  ///padding top 14
  T get pt14 => this..paddingTop = 14.r;

  ///padding top 16
  T get pt16 => this..paddingTop = 16.r;

  ///padding top 18
  T get pt18 => this..paddingTop = 18.r;

  ///padding top 20
  T get pt20 => this..paddingTop = 20.r;

  ///padding top 22
  T get pt22 => this..paddingTop = 22.r;

  ///padding top 24
  T get pt24 => this..paddingTop = 24.r;

  ///padding top 26
  T get pt26 => this..paddingTop = 26.r;

  ///padding top 28
  T get pt28 => this..paddingTop = 28.r;

  ///padding top 30
  T get pt30 => this..paddingTop = 30.r;

  ///padding top 32
  T get pt32 => this..paddingTop = 32.r;

  ///padding top 34
  T get pt34 => this..paddingTop = 34.r;

  ///padding top 36
  T get pt36 => this..paddingTop = 36.r;

  ///padding top 38
  T get pt38 => this..paddingTop = 38.r;

  ///padding top 40
  T get pt40 => this..paddingTop = 40.r;

  ///padding top 42
  T get pt42 => this..paddingTop = 42.r;

  ///padding top 44
  T get pt44 => this..paddingTop = 44.r;

  ///padding top 46
  T get pt46 => this..paddingTop = 46.r;

  ///padding top 48
  T get pt48 => this..paddingTop = 48.r;

  ///padding top 50
  T get pt50 => this..paddingTop = 50.r;

  /// set the padding top is 52
  T get pt52 => this..paddingTop = 52.r;

  /// set the padding top is 54
  T get pt54 => this..paddingTop = 54.r;

  /// set the padding top is 56
  T get pt56 => this..paddingTop = 56.r;

  /// set the padding top is 58
  T get pt58 => this..paddingTop = 58.r;

  /// set the padding top is 60
  T get pt60 => this..paddingTop = 60.r;

  /// set the padding top is 62
  T get pt62 => this..paddingTop = 62.r;

  /// set the padding top is 64
  T get pt64 => this..paddingTop = 64.r;

  /// set the padding top is 66
  T get pt66 => this..paddingTop = 66.r;

  /// set the padding top is 68
  T get pt68 => this..paddingTop = 68.r;

  /// set the padding top is 70
  T get pt70 => this..paddingTop = 70.r;

  /// set the padding top is 72
  T get pt72 => this..paddingTop = 72.r;

  /// set the padding top is 74
  T get pt74 => this..paddingTop = 74.r;

  /// set the padding top is 76
  T get pt76 => this..paddingTop = 76.r;

  /// set the padding top is 78
  T get pt78 => this..paddingTop = 78.r;

  /// set the padding top is 80
  T get pt80 => this..paddingTop = 80.r;

  ///padding bottom 2
  T get pb2 => this..paddingBottom = 2.r;

  ///padding bottom 4
  T get pb4 => this..paddingBottom = 4.r;

  ///padding bottom 6
  T get pb6 => this..paddingBottom = 6.r;

  ///padding bottom 8
  T get pb8 => this..paddingBottom = 8.r;

  ///padding bottom 10
  T get pb10 => this..paddingBottom = 10.r;

  ///padding bottom 12
  T get pb12 => this..paddingBottom = 12.r;

  ///padding bottom 14
  T get pb14 => this..paddingBottom = 14.r;

  ///padding bottom 16
  T get pb16 => this..paddingBottom = 16.r;

  ///padding bottom 18
  T get pb18 => this..paddingBottom = 18.r;

  ///padding bottom 20
  T get pb20 => this..paddingBottom = 20.r;

  ///padding bottom 22
  T get pb22 => this..paddingBottom = 22.r;

  ///padding bottom 24
  T get pb24 => this..paddingBottom = 24.r;

  ///padding bottom 26
  T get pb26 => this..paddingBottom = 26.r;

  ///padding bottom 28
  T get pb28 => this..paddingBottom = 28.r;

  ///padding bottom 30
  T get pb30 => this..paddingBottom = 30.r;

  ///padding bottom 32
  T get pb32 => this..paddingBottom = 32.r;

  ///padding bottom 34
  T get pb34 => this..paddingBottom = 34.r;

  ///padding bottom 36
  T get pb36 => this..paddingBottom = 36.r;

  ///padding bottom 38
  T get pb38 => this..paddingBottom = 38.r;

  ///padding bottom 40
  T get pb40 => this..paddingBottom = 40.r;

  ///padding bottom 42
  T get pb42 => this..paddingBottom = 42.r;

  ///padding bottom 44
  T get pb44 => this..paddingBottom = 44.r;

  ///padding bottom 46
  T get pb46 => this..paddingBottom = 46.r;

  ///padding bottom 48
  T get pb48 => this..paddingBottom = 48.r;

  ///padding bottom 50
  T get pb50 => this..paddingBottom = 50.r;

  /// set the padding bottom is 52
  T get pb52 => this..paddingBottom = 52.r;

  /// set the padding bottom is 54
  T get pb54 => this..paddingBottom = 54.r;

  /// set the padding bottom is 56
  T get pb56 => this..paddingBottom = 56.r;

  /// set the padding bottom is 58
  T get pb58 => this..paddingBottom = 58.r;

  /// set the padding bottom is 60
  T get pb60 => this..paddingBottom = 60.r;

  /// set the padding bottom is 62
  T get pb62 => this..paddingBottom = 62.r;

  /// set the padding bottom is 64
  T get pb64 => this..paddingBottom = 64.r;

  /// set the padding bottom is 66
  T get pb66 => this..paddingBottom = 66.r;

  /// set the padding bottom is 68
  T get pb68 => this..paddingBottom = 68.r;

  /// set the padding bottom is 70
  T get pb70 => this..paddingBottom = 70.r;

  /// set the padding bottom is 72
  T get pb72 => this..paddingBottom = 72.r;

  /// set the padding bottom is 74
  T get pb74 => this..paddingBottom = 74.r;

  /// set the padding bottom is 76
  T get pb76 => this..paddingBottom = 76.r;

  /// set the padding bottom is 78
  T get pb78 => this..paddingBottom = 78.r;

  /// set the padding bottom is 80
  T get pb80 => this..paddingBottom = 80.r;

  /// padding horizontal value 2
  T get ph2 => this..paddingHorizontal = 2.r;

  /// padding horizontal value 4
  T get ph4 => this..paddingHorizontal = 4.r;

  /// padding horizontal value 6
  T get ph6 => this..paddingHorizontal = 6.r;

  /// padding horizontal value 8
  T get ph8 => this..paddingHorizontal = 8.r;

  /// padding horizontal value 10
  T get ph10 => this..paddingHorizontal = 10.r;

  /// padding horizontal value 12
  T get ph12 => this..paddingHorizontal = 12.r;

  /// padding horizontal value 14
  T get ph14 => this..paddingHorizontal = 14.r;

  /// padding horizontal value 16
  T get ph16 => this..paddingHorizontal = 16.r;

  /// padding horizontal value 18
  T get ph18 => this..paddingHorizontal = 18.r;

  /// padding horizontal value 20
  T get ph20 => this..paddingHorizontal = 20.r;

  /// padding horizontal value 22
  T get ph22 => this..paddingHorizontal = 22.r;

  /// padding horizontal value 24
  T get ph24 => this..paddingHorizontal = 24.r;

  /// padding horizontal value 26
  T get ph26 => this..paddingHorizontal = 26.r;

  /// padding horizontal value 28
  T get ph28 => this..paddingHorizontal = 28.r;

  /// padding horizontal value 30
  T get ph30 => this..paddingHorizontal = 30.r;

  /// padding horizontal value 32
  T get ph32 => this..paddingHorizontal = 32.r;

  /// padding horizontal value 34
  T get ph34 => this..paddingHorizontal = 34.r;

  /// padding horizontal value 36
  T get ph36 => this..paddingHorizontal = 36.r;

  /// padding horizontal value 38
  T get ph38 => this..paddingHorizontal = 38.r;

  /// padding horizontal value 40
  T get ph40 => this..paddingHorizontal = 40.r;

  /// padding horizontal value 42
  T get ph42 => this..paddingHorizontal = 42.r;

  /// padding horizontal value 44
  T get ph44 => this..paddingHorizontal = 44.r;

  /// padding horizontal value 46
  T get ph46 => this..paddingHorizontal = 46.r;

  /// padding horizontal value 48
  T get ph48 => this..paddingHorizontal = 48.r;

  /// padding horizontal value 50
  T get ph50 => this..paddingHorizontal = 50.r;

  /// set the padding horizontal value is 52
  T get ph52 => this..paddingHorizontal = 52.r;

  /// set the padding horizontal value is 54
  T get ph54 => this..paddingHorizontal = 54.r;

  /// set the padding horizontal value is 56
  T get ph56 => this..paddingHorizontal = 56.r;

  /// set the padding horizontal value is 58
  T get ph58 => this..paddingHorizontal = 58.r;

  /// set the padding horizontal value is 60
  T get ph60 => this..paddingHorizontal = 60.r;

  /// set the padding horizontal value is 62
  T get ph62 => this..paddingHorizontal = 62.r;

  /// set the padding horizontal value is 64
  T get ph64 => this..paddingHorizontal = 64.r;

  /// set the padding horizontal value is 66
  T get ph66 => this..paddingHorizontal = 66.r;

  /// set the padding horizontal value is 68
  T get ph68 => this..paddingHorizontal = 68.r;

  /// set the padding horizontal value is 70
  T get ph70 => this..paddingHorizontal = 70.r;

  /// set the padding horizontal value is 72
  T get ph72 => this..paddingHorizontal = 72.r;

  /// set the padding horizontal value is 74
  T get ph74 => this..paddingHorizontal = 74.r;

  /// set the padding horizontal value is 76
  T get ph76 => this..paddingHorizontal = 76.r;

  /// set the padding horizontal value is 78
  T get ph78 => this..paddingHorizontal = 78.r;

  /// set the padding horizontal value is 80
  T get ph80 => this..paddingHorizontal = 80.r;

  ///padding vertical value = 2
  T get pv2 => this..paddingVertical = 2.r;

  ///padding vertical value = 4
  T get pv4 => this..paddingVertical = 4.r;

  ///padding vertical value = 6
  T get pv6 => this..paddingVertical = 6.r;

  ///padding vertical value = 8
  T get pv8 => this..paddingVertical = 8.r;

  ///padding vertical value 10
  T get pv10 => this..paddingVertical = 10.r;

  ///padding vertical value 12
  T get pv12 => this..paddingVertical = 12.r;

  ///padding vertical value 14
  T get pv14 => this..paddingVertical = 14.r;

  ///padding vertical value 16
  T get pv16 => this..paddingVertical = 16.r;

  ///padding vertical value 18
  T get pv18 => this..paddingVertical = 18.r;

  ///padding vertical value 20
  T get pv20 => this..paddingVertical = 20.r;

  ///padding vertical value 22
  T get pv22 => this..paddingVertical = 22.r;

  ///padding vertical value 24
  T get pv24 => this..paddingVertical = 24.r;

  ///padding vertical value 26
  T get pv26 => this..paddingVertical = 26.r;

  ///padding vertical value 28
  T get pv28 => this..paddingVertical = 28.r;

  ///padding vertical value 30
  T get pv30 => this..paddingVertical = 30.r;

  ///padding vertical value 32
  T get pv32 => this..paddingVertical = 32.r;

  ///padding vertical value 34
  T get pv34 => this..paddingVertical = 34.r;

  ///padding vertical value 36
  T get pv36 => this..paddingVertical = 36.r;

  ///padding vertical value 38
  T get pv38 => this..paddingVertical = 38.r;

  ///padding vertical value 40
  T get pv40 => this..paddingVertical = 40.r;

  ///padding vertical value 42
  T get pv42 => this..paddingVertical = 42.r;

  ///padding vertical value 44
  T get pv44 => this..paddingVertical = 44.r;

  ///padding vertical value 46
  T get pv46 => this..paddingVertical = 46.r;

  ///padding vertical value 48
  T get pv48 => this..paddingVertical = 48.r;

  ///padding vertical value 50
  T get pv50 => this..paddingVertical = 50.r;

  /// set the padding vertical value is 52
  T get pv52 => this..paddingVertical = 52.r;

  /// set the padding vertical value is 54
  T get pv54 => this..paddingVertical = 54.r;

  /// set the padding vertical value is 56
  T get pv56 => this..paddingVertical = 56.r;

  /// set the padding vertical value is 58
  T get pv58 => this..paddingVertical = 58.r;

  /// set the padding vertical value is 60
  T get pv60 => this..paddingVertical = 60.r;

  /// set the padding vertical value is 62
  T get pv62 => this..paddingVertical = 62.r;

  /// set the padding vertical value is 64
  T get pv64 => this..paddingVertical = 64.r;

  /// set the padding vertical value is 66
  T get pv66 => this..paddingVertical = 66.r;

  /// set the padding vertical value is 68
  T get pv68 => this..paddingVertical = 68.r;

  /// set the padding vertical value is 70
  T get pv70 => this..paddingVertical = 70.r;

  /// set the padding vertical value is 72
  T get pv72 => this..paddingVertical = 72.r;

  /// set the padding vertical value is 74
  T get pv74 => this..paddingVertical = 74.r;

  /// set the padding vertical value is 76
  T get pv76 => this..paddingVertical = 76.r;

  /// set the padding vertical value is 78
  T get pv78 => this..paddingVertical = 78.r;

  /// set the padding vertical value is 80
  T get pv80 => this..paddingVertical = 80.r;
}
