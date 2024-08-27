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

  bool get hasRadius =>
      radius != null || topLeft != null || topRight != null || bottomLeft != null || bottomRight != null;

  BorderRadiusGeometry get borderRadius => BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? radius ?? 0.0),
        topRight: Radius.circular(topRight ?? radius ?? 0.0),
        bottomLeft: Radius.circular(bottomLeft ?? radius ?? 0.0),
        bottomRight: Radius.circular(bottomRight ?? radius ?? 0.0),
      );

  WidgetStateProperty<OutlinedBorder?>? get buttonShape {
    return WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)));
  }
}

extension BorderRadiusBuilderExt<T extends BorderRadiusBuilder> on T {
  T r(double radius) => this..radius = radius;

  T get rounded1 => this..radius = 1.r;

  T get rounded2 => this..radius = 2.r;

  T get rounded3 => this..radius = 3.r;

  T get rounded4 => this..radius = 4.r;

  T get rounded5 => this..radius = 5.r;

  T get rounded6 => this..radius = 6.r;

  T get rounded7 => this..radius = 7.r;

  T get rounded8 => this..radius = 8.r;

  T get rounded9 => this..radius = 9.r;

  T get rounded10 => this..radius = 10.r;

  T get rounded12 => this..radius = 12.r;

  T get rounded14 => this..radius = 14.r;

  T get rounded16 => this..radius = 16.r;

  T get rounded18 => this..radius = 18.r;

  T get rounded20 => this..radius = 20.r;

  T get rounded22 => this..radius = 22.r;

  T get rounded24 => this..radius = 24.r;

  T get rounded26 => this..radius = 26.r;

  T get rounded25 => this..radius = 25.r;

  T get rounded28 => this..radius = 28.r;

  T get rounded30 => this..radius = 30.r;

  T get rounded32 => this..radius = 32.r;

  T get rounded34 => this..radius = 34.r;

  T get rounded36 => this..radius = 36.r;

  T get rounded38 => this..radius = 38.r;

  T get rounded40 => this..radius = 40.r;

  T get rounded42 => this..radius = 42.r;

  T get rounded44 => this..radius = 44.r;

  T get rounded46 => this..radius = 46.r;

  T get rounded48 => this..radius = 48.r;

  T get rounded50 => this..radius = 50.r;

  T get roundedTl1 => this..topLeft = 1.r;

  T get roundedTl2 => this..topLeft = 2.r;

  T get roundedTl3 => this..topLeft = 3.r;

  T get roundedTl4 => this..topLeft = 4.r;

  T get roundedTl5 => this..topLeft = 5.r;

  T get roundedTl6 => this..topLeft = 6.r;

  T get roundedTl7 => this..topLeft = 7.r;

  T get roundedTl8 => this..topLeft = 8.r;

  T get roundedTl9 => this..topLeft = 9.r;

  T get roundedTl10 => this..topLeft = 10.r;

  T get roundedTl11 => this..topLeft = 11.r;

  T get roundedTl12 => this..topLeft = 12.r;

  T get roundedTl13 => this..topLeft = 13.r;

  T get roundedTl14 => this..topLeft = 14.r;

  T get roundedTl15 => this..topLeft = 15.r;

  T get roundedTl16 => this..topLeft = 16.r;

  T get roundedTl17 => this..topLeft = 17.r;

  T get roundedTl18 => this..topLeft = 18.r;

  T get roundedTl19 => this..topLeft = 19.r;

  T get roundedTl20 => this..topLeft = 20.r;

  T get roundedTl21 => this..topLeft = 21.r;

  T get roundedTl22 => this..topLeft = 22.r;

  T get roundedTl23 => this..topLeft = 23.r;

  T get roundedTl24 => this..topLeft = 24.r;

  T get roundedTl25 => this..topLeft = 25.r;

  T get roundedTl26 => this..topLeft = 26.r;

  T get roundedTl27 => this..topLeft = 27.r;

  T get roundedTl28 => this..topLeft = 28.r;

  T get roundedTl29 => this..topLeft = 29.r;

  T get roundedTl30 => this..topLeft = 30.r;

  T get roundedTl31 => this..topLeft = 31.r;

  T get roundedTl32 => this..topLeft = 32.r;

  T get roundedTl33 => this..topLeft = 33.r;

  T get roundedTl34 => this..topLeft = 34.r;

  T get roundedTl35 => this..topLeft = 35.r;

  T get roundedTl36 => this..topLeft = 36.r;

  T get roundedTl37 => this..topLeft = 37.r;

  T get roundedTl38 => this..topLeft = 38.r;

  T get roundedTl39 => this..topLeft = 39.r;

  T get roundedTl40 => this..topLeft = 40.r;

  T get roundedTl41 => this..topLeft = 41.r;

  T get roundedTl42 => this..topLeft = 42.r;

  T get roundedTl43 => this..topLeft = 43.r;

  T get roundedTl44 => this..topLeft = 44.r;

  T get roundedTl45 => this..topLeft = 45.r;

  T get roundedTl46 => this..topLeft = 46.r;

  T get roundedTl47 => this..topLeft = 47.r;

  T get roundedTl48 => this..topLeft = 48.r;

  T get roundedTl49 => this..topLeft = 49.r;

  T get roundedTl50 => this..topLeft = 50.r;

  T get roundedTr1 => this..topRight = 1.r;

  T get roundedTr2 => this..topRight = 2.r;

  T get roundedTr3 => this..topRight = 3.r;

  T get roundedTr4 => this..topRight = 4.r;

  T get roundedTr5 => this..topRight = 5.r;

  T get roundedTr6 => this..topRight = 6.r;

  T get roundedTr7 => this..topRight = 7.r;

  T get roundedTr8 => this..topRight = 8.r;

  T get roundedTr9 => this..topRight = 9.r;

  T get roundedTr10 => this..topRight = 10.r;

  T get roundedTr11 => this..topRight = 11.r;

  T get roundedTr12 => this..topRight = 12.r;

  T get roundedTr13 => this..topRight = 13.r;

  T get roundedTr14 => this..topRight = 14.r;

  T get roundedTr15 => this..topRight = 15.r;

  T get roundedTr16 => this..topRight = 16.r;

  T get roundedTr17 => this..topRight = 17.r;

  T get roundedTr18 => this..topRight = 18.r;

  T get roundedTr19 => this..topRight = 19.r;

  T get roundedTr20 => this..topRight = 20.r;

  T get roundedTr21 => this..topRight = 21.r;

  T get roundedTr22 => this..topRight = 22.r;

  T get roundedTr23 => this..topRight = 23.r;

  T get roundedTr24 => this..topRight = 24.r;

  T get roundedTr25 => this..topRight = 25.r;

  T get roundedTr26 => this..topRight = 26.r;

  T get roundedTr27 => this..topRight = 27.r;

  T get roundedTr28 => this..topRight = 28.r;

  T get roundedTr29 => this..topRight = 29.r;

  T get roundedTr30 => this..topRight = 30.r;

  T get roundedTr31 => this..topRight = 31.r;

  T get roundedTr32 => this..topRight = 32.r;

  T get roundedTr33 => this..topRight = 33.r;

  T get roundedTr34 => this..topRight = 34.r;

  T get roundedTr35 => this..topRight = 35.r;

  T get roundedTr36 => this..topRight = 36.r;

  T get roundedTr37 => this..topRight = 37.r;

  T get roundedTr38 => this..topRight = 38.r;

  T get roundedTr39 => this..topRight = 39.r;

  T get roundedTr40 => this..topRight = 40.r;

  T get roundedTr41 => this..topRight = 41.r;

  T get roundedTr42 => this..topRight = 42.r;

  T get roundedTr43 => this..topRight = 43.r;

  T get roundedTr44 => this..topRight = 44.r;

  T get roundedTr45 => this..topRight = 45.r;

  T get roundedTr46 => this..topRight = 46.r;

  T get roundedTr47 => this..topRight = 47.r;

  T get roundedTr48 => this..topRight = 48.r;

  T get roundedTr49 => this..topRight = 49.r;

  T get roundedTr50 => this..topRight = 50.r;

  T get roundedBr1 => this..bottomRight = 1.r;

  T get roundedBr2 => this..bottomRight = 2.r;

  T get roundedBr3 => this..bottomRight = 3.r;

  T get roundedBr4 => this..bottomRight = 4.r;

  T get roundedBr5 => this..bottomRight = 5.r;

  T get roundedBr6 => this..bottomRight = 6.r;

  T get roundedBr7 => this..bottomRight = 7.r;

  T get roundedBr8 => this..bottomRight = 8.r;

  T get roundedBr9 => this..bottomRight = 9.r;

  T get roundedBr10 => this..bottomRight = 10.r;

  T get roundedBr11 => this..bottomRight = 11.r;

  T get roundedBr12 => this..bottomRight = 12.r;

  T get roundedBr13 => this..bottomRight = 13.r;

  T get roundedBr14 => this..bottomRight = 14.r;

  T get roundedBr15 => this..bottomRight = 15.r;

  T get roundedBr16 => this..bottomRight = 16.r;

  T get roundedBr17 => this..bottomRight = 17.r;

  T get roundedBr18 => this..bottomRight = 18.r;

  T get roundedBr19 => this..bottomRight = 19.r;

  T get roundedBr20 => this..bottomRight = 20.r;

  T get roundedBr21 => this..bottomRight = 21.r;

  T get roundedBr22 => this..bottomRight = 22.r;

  T get roundedBr23 => this..bottomRight = 23.r;

  T get roundedBr24 => this..bottomRight = 24.r;

  T get roundedBr25 => this..bottomRight = 25.r;

  T get roundedBr26 => this..bottomRight = 26.r;

  T get roundedBr27 => this..bottomRight = 27.r;

  T get roundedBr28 => this..bottomRight = 28.r;

  T get roundedBr29 => this..bottomRight = 29.r;

  T get roundedBr30 => this..bottomRight = 30.r;

  T get roundedBr31 => this..bottomRight = 31.r;

  T get roundedBr32 => this..bottomRight = 32.r;

  T get roundedBr33 => this..bottomRight = 33.r;

  T get roundedBr34 => this..bottomRight = 34.r;

  T get roundedBr35 => this..bottomRight = 35.r;

  T get roundedBr36 => this..bottomRight = 36.r;

  T get roundedBr37 => this..bottomRight = 37.r;

  T get roundedBr38 => this..bottomRight = 38.r;

  T get roundedBr39 => this..bottomRight = 39.r;

  T get roundedBr40 => this..bottomRight = 40.r;

  T get roundedBr41 => this..bottomRight = 41.r;

  T get roundedBr42 => this..bottomRight = 42.r;

  T get roundedBr43 => this..bottomRight = 43.r;

  T get roundedBr44 => this..bottomRight = 44.r;

  T get roundedBr45 => this..bottomRight = 45.r;

  T get roundedBr46 => this..bottomRight = 46.r;

  T get roundedBr47 => this..bottomRight = 47.r;

  T get roundedBr48 => this..bottomRight = 48.r;

  T get roundedBr49 => this..bottomRight = 49.r;

  T get roundedBr50 => this..bottomRight = 50.r;

  T get roundedBl1 => this..bottomLeft = 1.r;

  T get roundedBl2 => this..bottomLeft = 2.r;

  T get roundedBl3 => this..bottomLeft = 3.r;

  T get roundedBl4 => this..bottomLeft = 4.r;

  T get roundedBl5 => this..bottomLeft = 5.r;

  T get roundedBl6 => this..bottomLeft = 6.r;

  T get roundedBl7 => this..bottomLeft = 7.r;

  T get roundedBl8 => this..bottomLeft = 8.r;

  T get roundedBl9 => this..bottomLeft = 9.r;

  T get roundedBl10 => this..bottomLeft = 10.r;

  T get roundedBl11 => this..bottomLeft = 11.r;

  T get roundedBl12 => this..bottomLeft = 12.r;

  T get roundedBl13 => this..bottomLeft = 13.r;

  T get roundedBl14 => this..bottomLeft = 14.r;

  T get roundedBl15 => this..bottomLeft = 15.r;

  T get roundedBl16 => this..bottomLeft = 16.r;

  T get roundedBl17 => this..bottomLeft = 17.r;

  T get roundedBl18 => this..bottomLeft = 18.r;

  T get roundedBl19 => this..bottomLeft = 19.r;

  T get roundedBl20 => this..bottomLeft = 20.r;

  T get roundedBl21 => this..bottomLeft = 21.r;

  T get roundedBl22 => this..bottomLeft = 22.r;

  T get roundedBl23 => this..bottomLeft = 23.r;

  T get roundedBl24 => this..bottomLeft = 24.r;

  T get roundedBl25 => this..bottomLeft = 25.r;

  T get roundedBl26 => this..bottomLeft = 26.r;

  T get roundedBl27 => this..bottomLeft = 27.r;

  T get roundedBl28 => this..bottomLeft = 28.r;

  T get roundedBl29 => this..bottomLeft = 29.r;

  T get roundedBl30 => this..bottomLeft = 30.r;

  T get roundedBl31 => this..bottomLeft = 31.r;

  T get roundedBl32 => this..bottomLeft = 32.r;

  T get roundedBl33 => this..bottomLeft = 33.r;

  T get roundedBl34 => this..bottomLeft = 34.r;

  T get roundedBl35 => this..bottomLeft = 35.r;

  T get roundedBl36 => this..bottomLeft = 36.r;

  T get roundedBl37 => this..bottomLeft = 37.r;

  T get roundedBl38 => this..bottomLeft = 38.r;

  T get roundedBl39 => this..bottomLeft = 39.r;

  T get roundedBl40 => this..bottomLeft = 40.r;

  T get roundedBl41 => this..bottomLeft = 41.r;

  T get roundedBl42 => this..bottomLeft = 42.r;

  T get roundedBl43 => this..bottomLeft = 43.r;

  T get roundedBl44 => this..bottomLeft = 44.r;

  T get roundedBl45 => this..bottomLeft = 45.r;

  T get roundedBl46 => this..bottomLeft = 46.r;

  T get roundedBl47 => this..bottomLeft = 47.r;

  T get roundedBl48 => this..bottomLeft = 48.r;

  T get roundedBl49 => this..bottomLeft = 49.r;

  T get roundedBl50 => this..bottomLeft = 50.r;
}
