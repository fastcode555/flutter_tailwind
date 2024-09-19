import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin BorderRadiusBuilder {
  double? radius;
  double? topLeft;
  double? topRight;
  double? bottomRight;
  double? bottomLeft;

  double? top;
  double? bottom;
  double? left;
  double? right;

  bool get hasRadius =>
      radius != null ||
      topLeft != null ||
      topRight != null ||
      bottomLeft != null ||
      bottomRight != null ||
      top != null ||
      bottom != null ||
      left != null ||
      right != null;

  BorderRadiusGeometry get borderRadius => BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? top ?? left ?? radius ?? 0.0),
        topRight: Radius.circular(topRight ?? top ?? right ?? radius ?? 0.0),
        bottomLeft: Radius.circular(bottomLeft ?? bottom ?? left ?? radius ?? 0.0),
        bottomRight: Radius.circular(bottomRight ?? bottom ?? right ?? radius ?? 0.0),
      );

  WidgetStateProperty<OutlinedBorder?>? get buttonShape {
    return WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)));
  }
}

extension BorderRadiusBuilderExt<T extends BorderRadiusBuilder> on T {
  T r(double radius) => this..radius = radius;

  ///set all radius is 1
  T get rounded1 => this..radius = 1.r;

  ///set all radius is 2
  T get rounded2 => this..radius = 2.r;

  ///set all radius is 3
  T get rounded3 => this..radius = 3.r;

  ///set all radius is 4
  T get rounded4 => this..radius = 4.r;

  ///set all radius is 5
  T get rounded5 => this..radius = 5.r;

  ///set all radius is 6
  T get rounded6 => this..radius = 6.r;

  ///set all radius is 7
  T get rounded7 => this..radius = 7.r;

  ///set all radius is 8
  T get rounded8 => this..radius = 8.r;

  ///set all radius is 9
  T get rounded9 => this..radius = 9.r;

  ///set all radius is 10
  T get rounded10 => this..radius = 10.r;

  ///set all radius is 12
  T get rounded12 => this..radius = 12.r;

  ///set all radius is 14
  T get rounded14 => this..radius = 14.r;

  ///set all radius is 16
  T get rounded16 => this..radius = 16.r;

  ///set all radius is 18
  T get rounded18 => this..radius = 18.r;

  ///set all radius is 20
  T get rounded20 => this..radius = 20.r;

  ///set all radius is 22
  T get rounded22 => this..radius = 22.r;

  ///set all radius is 24
  T get rounded24 => this..radius = 24.r;

  ///set all radius is 26
  T get rounded26 => this..radius = 26.r;

  ///set all radius is 25
  T get rounded25 => this..radius = 25.r;

  ///set all radius is 28
  T get rounded28 => this..radius = 28.r;

  ///set all radius is 30
  T get rounded30 => this..radius = 30.r;

  ///set all radius is 32
  T get rounded32 => this..radius = 32.r;

  ///set all radius is 34
  T get rounded34 => this..radius = 34.r;

  ///set all radius is 36
  T get rounded36 => this..radius = 36.r;

  ///set all radius is 38
  T get rounded38 => this..radius = 38.r;

  ///set all radius is 40
  T get rounded40 => this..radius = 40.r;

  ///set all radius is 42
  T get rounded42 => this..radius = 42.r;

  ///set all radius is 44
  T get rounded44 => this..radius = 44.r;

  ///set all radius is 46
  T get rounded46 => this..radius = 46.r;

  ///set all radius is 48
  T get rounded48 => this..radius = 48.r;

  ///set all radius is 50
  T get rounded50 => this..radius = 50.r;

  ///set TopLeft radius 1
  T get roundedTl1 => this..topLeft = 1.r;

  ///set TopLeft radius 2
  T get roundedTl2 => this..topLeft = 2.r;

  ///set TopLeft radius 3
  T get roundedTl3 => this..topLeft = 3.r;

  ///set TopLeft radius 4
  T get roundedTl4 => this..topLeft = 4.r;

  ///set TopLeft radius 5
  T get roundedTl5 => this..topLeft = 5.r;

  ///set TopLeft radius 6
  T get roundedTl6 => this..topLeft = 6.r;

  ///set TopLeft radius 7
  T get roundedTl7 => this..topLeft = 7.r;

  ///set TopLeft radius 8
  T get roundedTl8 => this..topLeft = 8.r;

  ///set TopLeft radius 9
  T get roundedTl9 => this..topLeft = 9.r;

  ///set TopLeft radius 10
  T get roundedTl10 => this..topLeft = 10.r;

  ///set TopLeft radius 11
  T get roundedTl11 => this..topLeft = 11.r;

  ///set TopLeft radius 12
  T get roundedTl12 => this..topLeft = 12.r;

  ///set TopLeft radius 13
  T get roundedTl13 => this..topLeft = 13.r;

  ///set TopLeft radius 14
  T get roundedTl14 => this..topLeft = 14.r;

  ///set TopLeft radius 15
  T get roundedTl15 => this..topLeft = 15.r;

  ///set TopLeft radius 16
  T get roundedTl16 => this..topLeft = 16.r;

  ///set TopLeft radius 17
  T get roundedTl17 => this..topLeft = 17.r;

  ///set TopLeft radius 18
  T get roundedTl18 => this..topLeft = 18.r;

  ///set TopLeft radius 19
  T get roundedTl19 => this..topLeft = 19.r;

  ///set TopLeft radius 20
  T get roundedTl20 => this..topLeft = 20.r;

  ///set TopLeft radius 21
  T get roundedTl21 => this..topLeft = 21.r;

  ///set TopLeft radius 22
  T get roundedTl22 => this..topLeft = 22.r;

  ///set TopLeft radius 23
  T get roundedTl23 => this..topLeft = 23.r;

  ///set TopLeft radius 24
  T get roundedTl24 => this..topLeft = 24.r;

  ///set TopLeft radius 25
  T get roundedTl25 => this..topLeft = 25.r;

  ///set TopLeft radius 26
  T get roundedTl26 => this..topLeft = 26.r;

  ///set TopLeft radius 27
  T get roundedTl27 => this..topLeft = 27.r;

  ///set TopLeft radius 28
  T get roundedTl28 => this..topLeft = 28.r;

  ///set TopLeft radius 29
  T get roundedTl29 => this..topLeft = 29.r;

  ///set TopLeft radius 30
  T get roundedTl30 => this..topLeft = 30.r;

  ///set TopLeft radius 31
  T get roundedTl31 => this..topLeft = 31.r;

  ///set TopLeft radius 32
  T get roundedTl32 => this..topLeft = 32.r;

  ///set TopLeft radius 33
  T get roundedTl33 => this..topLeft = 33.r;

  ///set TopLeft radius 34
  T get roundedTl34 => this..topLeft = 34.r;

  ///set TopLeft radius 35
  T get roundedTl35 => this..topLeft = 35.r;

  ///set TopLeft radius 36
  T get roundedTl36 => this..topLeft = 36.r;

  ///set TopLeft radius 37
  T get roundedTl37 => this..topLeft = 37.r;

  ///set TopLeft radius 38
  T get roundedTl38 => this..topLeft = 38.r;

  ///set TopLeft radius 39
  T get roundedTl39 => this..topLeft = 39.r;

  ///set TopLeft radius 40
  T get roundedTl40 => this..topLeft = 40.r;

  ///set TopLeft radius 41
  T get roundedTl41 => this..topLeft = 41.r;

  ///set TopLeft radius 42
  T get roundedTl42 => this..topLeft = 42.r;

  ///set TopLeft radius 43
  T get roundedTl43 => this..topLeft = 43.r;

  ///set TopLeft radius 44
  T get roundedTl44 => this..topLeft = 44.r;

  ///set TopLeft radius 45
  T get roundedTl45 => this..topLeft = 45.r;

  ///set TopLeft radius 46
  T get roundedTl46 => this..topLeft = 46.r;

  ///set TopLeft radius 47
  T get roundedTl47 => this..topLeft = 47.r;

  ///set TopLeft radius 48
  T get roundedTl48 => this..topLeft = 48.r;

  ///set TopLeft radius 49
  T get roundedTl49 => this..topLeft = 49.r;

  ///set TopLeft radius 50
  T get roundedTl50 => this..topLeft = 50.r;

  ///set the Top Right radius is 1
  T get roundedTr1 => this..topRight = 1.r;

  ///set the Top Right radius is 2
  T get roundedTr2 => this..topRight = 2.r;

  ///set the Top Right radius is 3
  T get roundedTr3 => this..topRight = 3.r;

  ///set the Top Right radius is 4
  T get roundedTr4 => this..topRight = 4.r;

  ///set the Top Right radius is 5
  T get roundedTr5 => this..topRight = 5.r;

  ///set the Top Right radius is 6
  T get roundedTr6 => this..topRight = 6.r;

  ///set the Top Right radius is 7
  T get roundedTr7 => this..topRight = 7.r;

  ///set the Top Right radius is 8
  T get roundedTr8 => this..topRight = 8.r;

  ///set the Top Right radius is 9
  T get roundedTr9 => this..topRight = 9.r;

  ///set the Top Right radius is 10
  T get roundedTr10 => this..topRight = 10.r;

  ///set the Top Right radius is 11
  T get roundedTr11 => this..topRight = 11.r;

  ///set the Top Right radius is 12
  T get roundedTr12 => this..topRight = 12.r;

  ///set the Top Right radius is 13
  T get roundedTr13 => this..topRight = 13.r;

  ///set the Top Right radius is 14
  T get roundedTr14 => this..topRight = 14.r;

  ///set the Top Right radius is 15
  T get roundedTr15 => this..topRight = 15.r;

  ///set the Top Right radius is 16
  T get roundedTr16 => this..topRight = 16.r;

  ///set the Top Right radius is 17
  T get roundedTr17 => this..topRight = 17.r;

  ///set the Top Right radius is 18
  T get roundedTr18 => this..topRight = 18.r;

  ///set the Top Right radius is 19
  T get roundedTr19 => this..topRight = 19.r;

  ///set the Top Right radius is 20
  T get roundedTr20 => this..topRight = 20.r;

  ///set the Top Right radius is 21
  T get roundedTr21 => this..topRight = 21.r;

  ///set the Top Right radius is 22
  T get roundedTr22 => this..topRight = 22.r;

  ///set the Top Right radius is 23
  T get roundedTr23 => this..topRight = 23.r;

  ///set the Top Right radius is 24
  T get roundedTr24 => this..topRight = 24.r;

  ///set the Top Right radius is 25
  T get roundedTr25 => this..topRight = 25.r;

  ///set the Top Right radius is 26
  T get roundedTr26 => this..topRight = 26.r;

  ///set the Top Right radius is 27
  T get roundedTr27 => this..topRight = 27.r;

  ///set the Top Right radius is 28
  T get roundedTr28 => this..topRight = 28.r;

  ///set the Top Right radius is 29
  T get roundedTr29 => this..topRight = 29.r;

  ///set the Top Right radius is 30
  T get roundedTr30 => this..topRight = 30.r;

  ///set the Top Right radius is 31
  T get roundedTr31 => this..topRight = 31.r;

  ///set the Top Right radius is 32
  T get roundedTr32 => this..topRight = 32.r;

  ///set the Top Right radius is 33
  T get roundedTr33 => this..topRight = 33.r;

  ///set the Top Right radius is 34
  T get roundedTr34 => this..topRight = 34.r;

  ///set the Top Right radius is 35
  T get roundedTr35 => this..topRight = 35.r;

  ///set the Top Right radius is 36
  T get roundedTr36 => this..topRight = 36.r;

  ///set the Top Right radius is 37
  T get roundedTr37 => this..topRight = 37.r;

  ///set the Top Right radius is 38
  T get roundedTr38 => this..topRight = 38.r;

  ///set the Top Right radius is 39
  T get roundedTr39 => this..topRight = 39.r;

  ///set the Top Right radius is 40
  T get roundedTr40 => this..topRight = 40.r;

  ///set the Top Right radius is 41
  T get roundedTr41 => this..topRight = 41.r;

  ///set the Top Right radius is 42
  T get roundedTr42 => this..topRight = 42.r;

  ///set the Top Right radius is 43
  T get roundedTr43 => this..topRight = 43.r;

  ///set the Top Right radius is 44
  T get roundedTr44 => this..topRight = 44.r;

  ///set the Top Right radius is 45
  T get roundedTr45 => this..topRight = 45.r;

  ///set the Top Right radius is 46
  T get roundedTr46 => this..topRight = 46.r;

  ///set the Top Right radius is 47
  T get roundedTr47 => this..topRight = 47.r;

  ///set the Top Right radius is 48
  T get roundedTr48 => this..topRight = 48.r;

  ///set the Top Right radius is 49
  T get roundedTr49 => this..topRight = 49.r;

  ///set the Top Right radius is 50
  T get roundedTr50 => this..topRight = 50.r;

  ///set the bottom right radius is 1
  T get roundedBr1 => this..bottomRight = 1.r;

  ///set the bottom right radius is 2
  T get roundedBr2 => this..bottomRight = 2.r;

  ///set the bottom right radius is 3
  T get roundedBr3 => this..bottomRight = 3.r;

  ///set the bottom right radius is 4
  T get roundedBr4 => this..bottomRight = 4.r;

  ///set the bottom right radius is 5
  T get roundedBr5 => this..bottomRight = 5.r;

  ///set the bottom right radius is 6
  T get roundedBr6 => this..bottomRight = 6.r;

  ///set the bottom right radius is 7
  T get roundedBr7 => this..bottomRight = 7.r;

  ///set the bottom right radius is 8
  T get roundedBr8 => this..bottomRight = 8.r;

  ///set the bottom right radius is 9
  T get roundedBr9 => this..bottomRight = 9.r;

  ///set the bottom right radius is 10
  T get roundedBr10 => this..bottomRight = 10.r;

  ///set the bottom right radius is 11
  T get roundedBr11 => this..bottomRight = 11.r;

  ///set the bottom right radius is 12
  T get roundedBr12 => this..bottomRight = 12.r;

  ///set the bottom right radius is 13
  T get roundedBr13 => this..bottomRight = 13.r;

  ///set the bottom right radius is 14
  T get roundedBr14 => this..bottomRight = 14.r;

  ///set the bottom right radius is 15
  T get roundedBr15 => this..bottomRight = 15.r;

  ///set the bottom right radius is 16
  T get roundedBr16 => this..bottomRight = 16.r;

  ///set the bottom right radius is 17
  T get roundedBr17 => this..bottomRight = 17.r;

  ///set the bottom right radius is 18
  T get roundedBr18 => this..bottomRight = 18.r;

  ///set the bottom right radius is 19
  T get roundedBr19 => this..bottomRight = 19.r;

  ///set the bottom right radius is 20
  T get roundedBr20 => this..bottomRight = 20.r;

  ///set the bottom right radius is 21
  T get roundedBr21 => this..bottomRight = 21.r;

  ///set the bottom right radius is 22
  T get roundedBr22 => this..bottomRight = 22.r;

  ///set the bottom right radius is 23
  T get roundedBr23 => this..bottomRight = 23.r;

  ///set the bottom right radius is 24
  T get roundedBr24 => this..bottomRight = 24.r;

  ///set the bottom right radius is 25
  T get roundedBr25 => this..bottomRight = 25.r;

  ///set the bottom right radius is 26
  T get roundedBr26 => this..bottomRight = 26.r;

  ///set the bottom right radius is 27
  T get roundedBr27 => this..bottomRight = 27.r;

  ///set the bottom right radius is 28
  T get roundedBr28 => this..bottomRight = 28.r;

  ///set the bottom right radius is 29
  T get roundedBr29 => this..bottomRight = 29.r;

  ///set the bottom right radius is 30
  T get roundedBr30 => this..bottomRight = 30.r;

  ///set the bottom right radius is 31
  T get roundedBr31 => this..bottomRight = 31.r;

  ///set the bottom right radius is 32
  T get roundedBr32 => this..bottomRight = 32.r;

  ///set the bottom right radius is 33
  T get roundedBr33 => this..bottomRight = 33.r;

  ///set the bottom right radius is 34
  T get roundedBr34 => this..bottomRight = 34.r;

  ///set the bottom right radius is 35
  T get roundedBr35 => this..bottomRight = 35.r;

  ///set the bottom right radius is 36
  T get roundedBr36 => this..bottomRight = 36.r;

  ///set the bottom right radius is 37
  T get roundedBr37 => this..bottomRight = 37.r;

  ///set the bottom right radius is 38
  T get roundedBr38 => this..bottomRight = 38.r;

  ///set the bottom right radius is 39
  T get roundedBr39 => this..bottomRight = 39.r;

  ///set the bottom right radius is 40
  T get roundedBr40 => this..bottomRight = 40.r;

  ///set the bottom right radius is 41
  T get roundedBr41 => this..bottomRight = 41.r;

  ///set the bottom right radius is 42
  T get roundedBr42 => this..bottomRight = 42.r;

  ///set the bottom right radius is 43
  T get roundedBr43 => this..bottomRight = 43.r;

  ///set the bottom right radius is 44
  T get roundedBr44 => this..bottomRight = 44.r;

  ///set the bottom right radius is 45
  T get roundedBr45 => this..bottomRight = 45.r;

  ///set the bottom right radius is 46
  T get roundedBr46 => this..bottomRight = 46.r;

  ///set the bottom right radius is 47
  T get roundedBr47 => this..bottomRight = 47.r;

  ///set the bottom right radius is 48
  T get roundedBr48 => this..bottomRight = 48.r;

  ///set the bottom right radius is 49
  T get roundedBr49 => this..bottomRight = 49.r;

  ///set the bottom right radius is 50
  T get roundedBr50 => this..bottomRight = 50.r;

  ///set the Bottom Left radius is 1
  T get roundedBl1 => this..bottomLeft = 1.r;

  ///set the Bottom Left radius is 2
  T get roundedBl2 => this..bottomLeft = 2.r;

  ///set the Bottom Left radius is 3
  T get roundedBl3 => this..bottomLeft = 3.r;

  ///set the Bottom Left radius is 4
  T get roundedBl4 => this..bottomLeft = 4.r;

  ///set the Bottom Left radius is 5
  T get roundedBl5 => this..bottomLeft = 5.r;

  ///set the Bottom Left radius is 6
  T get roundedBl6 => this..bottomLeft = 6.r;

  ///set the Bottom Left radius is 7
  T get roundedBl7 => this..bottomLeft = 7.r;

  ///set the Bottom Left radius is 8
  T get roundedBl8 => this..bottomLeft = 8.r;

  ///set the Bottom Left radius is 9
  T get roundedBl9 => this..bottomLeft = 9.r;

  ///set the Bottom Left radius is 10
  T get roundedBl10 => this..bottomLeft = 10.r;

  ///set the Bottom Left radius is 11
  T get roundedBl11 => this..bottomLeft = 11.r;

  ///set the Bottom Left radius is 12
  T get roundedBl12 => this..bottomLeft = 12.r;

  ///set the Bottom Left radius is 13
  T get roundedBl13 => this..bottomLeft = 13.r;

  ///set the Bottom Left radius is 14
  T get roundedBl14 => this..bottomLeft = 14.r;

  ///set the Bottom Left radius is 15
  T get roundedBl15 => this..bottomLeft = 15.r;

  ///set the Bottom Left radius is 16
  T get roundedBl16 => this..bottomLeft = 16.r;

  ///set the Bottom Left radius is 17
  T get roundedBl17 => this..bottomLeft = 17.r;

  ///set the Bottom Left radius is 18
  T get roundedBl18 => this..bottomLeft = 18.r;

  ///set the Bottom Left radius is 19
  T get roundedBl19 => this..bottomLeft = 19.r;

  ///set the Bottom Left radius is 20
  T get roundedBl20 => this..bottomLeft = 20.r;

  ///set the Bottom Left radius is 21
  T get roundedBl21 => this..bottomLeft = 21.r;

  ///set the Bottom Left radius is 22
  T get roundedBl22 => this..bottomLeft = 22.r;

  ///set the Bottom Left radius is 23
  T get roundedBl23 => this..bottomLeft = 23.r;

  ///set the Bottom Left radius is 24
  T get roundedBl24 => this..bottomLeft = 24.r;

  ///set the Bottom Left radius is 25
  T get roundedBl25 => this..bottomLeft = 25.r;

  ///set the Bottom Left radius is 26
  T get roundedBl26 => this..bottomLeft = 26.r;

  ///set the Bottom Left radius is 27
  T get roundedBl27 => this..bottomLeft = 27.r;

  ///set the Bottom Left radius is 28
  T get roundedBl28 => this..bottomLeft = 28.r;

  ///set the Bottom Left radius is 29
  T get roundedBl29 => this..bottomLeft = 29.r;

  ///set the Bottom Left radius is 30
  T get roundedBl30 => this..bottomLeft = 30.r;

  ///set the Bottom Left radius is 31
  T get roundedBl31 => this..bottomLeft = 31.r;

  ///set the Bottom Left radius is 32
  T get roundedBl32 => this..bottomLeft = 32.r;

  ///set the Bottom Left radius is 33
  T get roundedBl33 => this..bottomLeft = 33.r;

  ///set the Bottom Left radius is 34
  T get roundedBl34 => this..bottomLeft = 34.r;

  ///set the Bottom Left radius is 35
  T get roundedBl35 => this..bottomLeft = 35.r;

  ///set the Bottom Left radius is 36
  T get roundedBl36 => this..bottomLeft = 36.r;

  ///set the Bottom Left radius is 37
  T get roundedBl37 => this..bottomLeft = 37.r;

  ///set the Bottom Left radius is 38
  T get roundedBl38 => this..bottomLeft = 38.r;

  ///set the Bottom Left radius is 39
  T get roundedBl39 => this..bottomLeft = 39.r;

  ///set the Bottom Left radius is 40
  T get roundedBl40 => this..bottomLeft = 40.r;

  ///set the Bottom Left radius is 41
  T get roundedBl41 => this..bottomLeft = 41.r;

  ///set the Bottom Left radius is 42
  T get roundedBl42 => this..bottomLeft = 42.r;

  ///set the Bottom Left radius is 43
  T get roundedBl43 => this..bottomLeft = 43.r;

  ///set the Bottom Left radius is 44
  T get roundedBl44 => this..bottomLeft = 44.r;

  ///set the Bottom Left radius is 45
  T get roundedBl45 => this..bottomLeft = 45.r;

  ///set the Bottom Left radius is 46
  T get roundedBl46 => this..bottomLeft = 46.r;

  ///set the Bottom Left radius is 47
  T get roundedBl47 => this..bottomLeft = 47.r;

  ///set the Bottom Left radius is 48
  T get roundedBl48 => this..bottomLeft = 48.r;

  ///set the Bottom Left radius is 49
  T get roundedBl49 => this..bottomLeft = 49.r;

  ///set the Bottom Left radius is 50
  T get roundedBl50 => this..bottomLeft = 50.r;

  ///set the top radius is 1
  T get roundedT1 => this..top = 1.r;

  ///set the top radius is 2
  T get roundedT2 => this..top = 2.r;

  ///set the top radius is 3
  T get roundedT3 => this..top = 3.r;

  ///set the top radius is 4
  T get roundedT4 => this..top = 4.r;

  ///set the top radius is 5
  T get roundedT5 => this..top = 5.r;

  ///set the top radius is 6
  T get roundedT6 => this..top = 6.r;

  ///set the top radius is 7
  T get roundedT7 => this..top = 7.r;

  ///set the top radius is 8
  T get roundedT8 => this..top = 8.r;

  ///set the top radius is 9
  T get roundedT9 => this..top = 9.r;

  ///set the top radius is 10
  T get roundedT10 => this..top = 10.r;

  ///set the top radius is 11
  T get roundedT11 => this..top = 11.r;

  ///set the top radius is 12
  T get roundedT12 => this..top = 12.r;

  ///set the top radius is 13
  T get roundedT13 => this..top = 13.r;

  ///set the top radius is 14
  T get roundedT14 => this..top = 14.r;

  ///set the top radius is 15
  T get roundedT15 => this..top = 15.r;

  ///set the top radius is 16
  T get roundedT16 => this..top = 16.r;

  ///set the top radius is 17
  T get roundedT17 => this..top = 17.r;

  ///set the top radius is 18
  T get roundedT18 => this..top = 18.r;

  ///set the top radius is 19
  T get roundedT19 => this..top = 19.r;

  ///set the top radius is 20
  T get roundedT20 => this..top = 20.r;

  ///set the top radius is 21
  T get roundedT21 => this..top = 21.r;

  ///set the top radius is 22
  T get roundedT22 => this..top = 22.r;

  ///set the top radius is 23
  T get roundedT23 => this..top = 23.r;

  ///set the top radius is 24
  T get roundedT24 => this..top = 24.r;

  ///set the top radius is 25
  T get roundedT25 => this..top = 25.r;

  ///set the top radius is 26
  T get roundedT26 => this..top = 26.r;

  ///set the top radius is 27
  T get roundedT27 => this..top = 27.r;

  ///set the top radius is 28
  T get roundedT28 => this..top = 28.r;

  ///set the top radius is 29
  T get roundedT29 => this..top = 29.r;

  ///set the top radius is 30
  T get roundedT30 => this..top = 30.r;

  ///set the top radius is 31
  T get roundedT31 => this..top = 31.r;

  ///set the top radius is 32
  T get roundedT32 => this..top = 32.r;

  ///set the top radius is 33
  T get roundedT33 => this..top = 33.r;

  ///set the top radius is 34
  T get roundedT34 => this..top = 34.r;

  ///set the top radius is 35
  T get roundedT35 => this..top = 35.r;

  ///set the top radius is 36
  T get roundedT36 => this..top = 36.r;

  ///set the top radius is 37
  T get roundedT37 => this..top = 37.r;

  ///set the top radius is 38
  T get roundedT38 => this..top = 38.r;

  ///set the top radius is 39
  T get roundedT39 => this..top = 39.r;

  ///set the top radius is 40
  T get roundedT40 => this..top = 40.r;

  ///set the top radius is 41
  T get roundedT41 => this..top = 41.r;

  ///set the top radius is 42
  T get roundedT42 => this..top = 42.r;

  ///set the top radius is 43
  T get roundedT43 => this..top = 43.r;

  ///set the top radius is 44
  T get roundedT44 => this..top = 44.r;

  ///set the top radius is 45
  T get roundedT45 => this..top = 45.r;

  ///set the top radius is 46
  T get roundedT46 => this..top = 46.r;

  ///set the top radius is 47
  T get roundedT47 => this..top = 47.r;

  ///set the top radius is 48
  T get roundedT48 => this..top = 48.r;

  ///set the top radius is 49
  T get roundedT49 => this..top = 49.r;

  ///set the top radius is 50
  T get roundedT50 => this..top = 50.r;

  ///set the bottom radius is 1
  T get roundedB1 => this..bottom = 1.r;

  ///set the bottom radius is 2
  T get roundedB2 => this..bottom = 2.r;

  ///set the bottom radius is 3
  T get roundedB3 => this..bottom = 3.r;

  ///set the bottom radius is 4
  T get roundedB4 => this..bottom = 4.r;

  ///set the bottom radius is 5
  T get roundedB5 => this..bottom = 5.r;

  ///set the bottom radius is 6
  T get roundedB6 => this..bottom = 6.r;

  ///set the bottom radius is 7
  T get roundedB7 => this..bottom = 7.r;

  ///set the bottom radius is 8
  T get roundedB8 => this..bottom = 8.r;

  ///set the bottom radius is 9
  T get roundedB9 => this..bottom = 9.r;

  ///set the bottom radius is 10
  T get roundedB10 => this..bottom = 10.r;

  ///set the bottom radius is 11
  T get roundedB11 => this..bottom = 11.r;

  ///set the bottom radius is 12
  T get roundedB12 => this..bottom = 12.r;

  ///set the bottom radius is 13
  T get roundedB13 => this..bottom = 13.r;

  ///set the bottom radius is 14
  T get roundedB14 => this..bottom = 14.r;

  ///set the bottom radius is 15
  T get roundedB15 => this..bottom = 15.r;

  ///set the bottom radius is 16
  T get roundedB16 => this..bottom = 16.r;

  ///set the bottom radius is 17
  T get roundedB17 => this..bottom = 17.r;

  ///set the bottom radius is 18
  T get roundedB18 => this..bottom = 18.r;

  ///set the bottom radius is 19
  T get roundedB19 => this..bottom = 19.r;

  ///set the bottom radius is 20
  T get roundedB20 => this..bottom = 20.r;

  ///set the bottom radius is 21
  T get roundedB21 => this..bottom = 21.r;

  ///set the bottom radius is 22
  T get roundedB22 => this..bottom = 22.r;

  ///set the bottom radius is 23
  T get roundedB23 => this..bottom = 23.r;

  ///set the bottom radius is 24
  T get roundedB24 => this..bottom = 24.r;

  ///set the bottom radius is 25
  T get roundedB25 => this..bottom = 25.r;

  ///set the bottom radius is 26
  T get roundedB26 => this..bottom = 26.r;

  ///set the bottom radius is 27
  T get roundedB27 => this..bottom = 27.r;

  ///set the bottom radius is 28
  T get roundedB28 => this..bottom = 28.r;

  ///set the bottom radius is 29
  T get roundedB29 => this..bottom = 29.r;

  ///set the bottom radius is 30
  T get roundedB30 => this..bottom = 30.r;

  ///set the bottom radius is 31
  T get roundedB31 => this..bottom = 31.r;

  ///set the bottom radius is 32
  T get roundedB32 => this..bottom = 32.r;

  ///set the bottom radius is 33
  T get roundedB33 => this..bottom = 33.r;

  ///set the bottom radius is 34
  T get roundedB34 => this..bottom = 34.r;

  ///set the bottom radius is 35
  T get roundedB35 => this..bottom = 35.r;

  ///set the bottom radius is 36
  T get roundedB36 => this..bottom = 36.r;

  ///set the bottom radius is 37
  T get roundedB37 => this..bottom = 37.r;

  ///set the bottom radius is 38
  T get roundedB38 => this..bottom = 38.r;

  ///set the bottom radius is 39
  T get roundedB39 => this..bottom = 39.r;

  ///set the bottom radius is 40
  T get roundedB40 => this..bottom = 40.r;

  ///set the bottom radius is 41
  T get roundedB41 => this..bottom = 41.r;

  ///set the bottom radius is 42
  T get roundedB42 => this..bottom = 42.r;

  ///set the bottom radius is 43
  T get roundedB43 => this..bottom = 43.r;

  ///set the bottom radius is 44
  T get roundedB44 => this..bottom = 44.r;

  ///set the bottom radius is 45
  T get roundedB45 => this..bottom = 45.r;

  ///set the bottom radius is 46
  T get roundedB46 => this..bottom = 46.r;

  ///set the bottom radius is 47
  T get roundedB47 => this..bottom = 47.r;

  ///set the bottom radius is 48
  T get roundedB48 => this..bottom = 48.r;

  ///set the bottom radius is 49
  T get roundedB49 => this..bottom = 49.r;

  ///set the bottom radius is 50
  T get roundedB50 => this..bottom = 50.r;

  ///set the left radius is 1
  T get roundedL1 => this..left = 1.r;

  ///set the left radius is 2
  T get roundedL2 => this..left = 2.r;

  ///set the left radius is 3
  T get roundedL3 => this..left = 3.r;

  ///set the left radius is 4
  T get roundedL4 => this..left = 4.r;

  ///set the left radius is 5
  T get roundedL5 => this..left = 5.r;

  ///set the left radius is 6
  T get roundedL6 => this..left = 6.r;

  ///set the left radius is 7
  T get roundedL7 => this..left = 7.r;

  ///set the left radius is 8
  T get roundedL8 => this..left = 8.r;

  ///set the left radius is 9
  T get roundedL9 => this..left = 9.r;

  ///set the left radius is 10
  T get roundedL10 => this..left = 10.r;

  ///set the left radius is 11
  T get roundedL11 => this..left = 11.r;

  ///set the left radius is 12
  T get roundedL12 => this..left = 12.r;

  ///set the left radius is 13
  T get roundedL13 => this..left = 13.r;

  ///set the left radius is 14
  T get roundedL14 => this..left = 14.r;

  ///set the left radius is 15
  T get roundedL15 => this..left = 15.r;

  ///set the left radius is 16
  T get roundedL16 => this..left = 16.r;

  ///set the left radius is 17
  T get roundedL17 => this..left = 17.r;

  ///set the left radius is 18
  T get roundedL18 => this..left = 18.r;

  ///set the left radius is 19
  T get roundedL19 => this..left = 19.r;

  ///set the left radius is 20
  T get roundedL20 => this..left = 20.r;

  ///set the left radius is 21
  T get roundedL21 => this..left = 21.r;

  ///set the left radius is 22
  T get roundedL22 => this..left = 22.r;

  ///set the left radius is 23
  T get roundedL23 => this..left = 23.r;

  ///set the left radius is 24
  T get roundedL24 => this..left = 24.r;

  ///set the left radius is 25
  T get roundedL25 => this..left = 25.r;

  ///set the left radius is 26
  T get roundedL26 => this..left = 26.r;

  ///set the left radius is 27
  T get roundedL27 => this..left = 27.r;

  ///set the left radius is 28
  T get roundedL28 => this..left = 28.r;

  ///set the left radius is 29
  T get roundedL29 => this..left = 29.r;

  ///set the left radius is 30
  T get roundedL30 => this..left = 30.r;

  ///set the left radius is 31
  T get roundedL31 => this..left = 31.r;

  ///set the left radius is 32
  T get roundedL32 => this..left = 32.r;

  ///set the left radius is 33
  T get roundedL33 => this..left = 33.r;

  ///set the left radius is 34
  T get roundedL34 => this..left = 34.r;

  ///set the left radius is 35
  T get roundedL35 => this..left = 35.r;

  ///set the left radius is 36
  T get roundedL36 => this..left = 36.r;

  ///set the left radius is 37
  T get roundedL37 => this..left = 37.r;

  ///set the left radius is 38
  T get roundedL38 => this..left = 38.r;

  ///set the left radius is 39
  T get roundedL39 => this..left = 39.r;

  ///set the left radius is 40
  T get roundedL40 => this..left = 40.r;

  ///set the left radius is 41
  T get roundedL41 => this..left = 41.r;

  ///set the left radius is 42
  T get roundedL42 => this..left = 42.r;

  ///set the left radius is 43
  T get roundedL43 => this..left = 43.r;

  ///set the left radius is 44
  T get roundedL44 => this..left = 44.r;

  ///set the left radius is 45
  T get roundedL45 => this..left = 45.r;

  ///set the left radius is 46
  T get roundedL46 => this..left = 46.r;

  ///set the left radius is 47
  T get roundedL47 => this..left = 47.r;

  ///set the left radius is 48
  T get roundedL48 => this..left = 48.r;

  ///set the left radius is 49
  T get roundedL49 => this..left = 49.r;

  ///set the left radius is 50
  T get roundedL50 => this..left = 50.r;

  ///set the right radius is 1
  T get roundedR1 => this..right = 1.r;

  ///set the right radius is 2
  T get roundedR2 => this..right = 2.r;

  ///set the right radius is 3
  T get roundedR3 => this..right = 3.r;

  ///set the right radius is 4
  T get roundedR4 => this..right = 4.r;

  ///set the right radius is 5
  T get roundedR5 => this..right = 5.r;

  ///set the right radius is 6
  T get roundedR6 => this..right = 6.r;

  ///set the right radius is 7
  T get roundedR7 => this..right = 7.r;

  ///set the right radius is 8
  T get roundedR8 => this..right = 8.r;

  ///set the right radius is 9
  T get roundedR9 => this..right = 9.r;

  ///set the right radius is 10
  T get roundedR10 => this..right = 10.r;

  ///set the right radius is 11
  T get roundedR11 => this..right = 11.r;

  ///set the right radius is 12
  T get roundedR12 => this..right = 12.r;

  ///set the right radius is 13
  T get roundedR13 => this..right = 13.r;

  ///set the right radius is 14
  T get roundedR14 => this..right = 14.r;

  ///set the right radius is 15
  T get roundedR15 => this..right = 15.r;

  ///set the right radius is 16
  T get roundedR16 => this..right = 16.r;

  ///set the right radius is 17
  T get roundedR17 => this..right = 17.r;

  ///set the right radius is 18
  T get roundedR18 => this..right = 18.r;

  ///set the right radius is 19
  T get roundedR19 => this..right = 19.r;

  ///set the right radius is 20
  T get roundedR20 => this..right = 20.r;

  ///set the right radius is 21
  T get roundedR21 => this..right = 21.r;

  ///set the right radius is 22
  T get roundedR22 => this..right = 22.r;

  ///set the right radius is 23
  T get roundedR23 => this..right = 23.r;

  ///set the right radius is 24
  T get roundedR24 => this..right = 24.r;

  ///set the right radius is 25
  T get roundedR25 => this..right = 25.r;

  ///set the right radius is 26
  T get roundedR26 => this..right = 26.r;

  ///set the right radius is 27
  T get roundedR27 => this..right = 27.r;

  ///set the right radius is 28
  T get roundedR28 => this..right = 28.r;

  ///set the right radius is 29
  T get roundedR29 => this..right = 29.r;

  ///set the right radius is 30
  T get roundedR30 => this..right = 30.r;

  ///set the right radius is 31
  T get roundedR31 => this..right = 31.r;

  ///set the right radius is 32
  T get roundedR32 => this..right = 32.r;

  ///set the right radius is 33
  T get roundedR33 => this..right = 33.r;

  ///set the right radius is 34
  T get roundedR34 => this..right = 34.r;

  ///set the right radius is 35
  T get roundedR35 => this..right = 35.r;

  ///set the right radius is 36
  T get roundedR36 => this..right = 36.r;

  ///set the right radius is 37
  T get roundedR37 => this..right = 37.r;

  ///set the right radius is 38
  T get roundedR38 => this..right = 38.r;

  ///set the right radius is 39
  T get roundedR39 => this..right = 39.r;

  ///set the right radius is 40
  T get roundedR40 => this..right = 40.r;

  ///set the right radius is 41
  T get roundedR41 => this..right = 41.r;

  ///set the right radius is 42
  T get roundedR42 => this..right = 42.r;

  ///set the right radius is 43
  T get roundedR43 => this..right = 43.r;

  ///set the right radius is 44
  T get roundedR44 => this..right = 44.r;

  ///set the right radius is 45
  T get roundedR45 => this..right = 45.r;

  ///set the right radius is 46
  T get roundedR46 => this..right = 46.r;

  ///set the right radius is 47
  T get roundedR47 => this..right = 47.r;

  ///set the right radius is 48
  T get roundedR48 => this..right = 48.r;

  ///set the right radius is 49
  T get roundedR49 => this..right = 49.r;

  ///set the right radius is 50
  T get roundedR50 => this..right = 50.r;
}
