import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/res/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

class AppImageConfig extends ImageLoaderConfigInterface {
  @override
  LoadingErrorWidgetBuilder getErrorBuilder(
    double? width,
    double? height,
    double? border,
    Color? borderColor,
    double? radius,
  ) {
    double? finalW = (width ?? 0) > (height ?? 0) ? height : width;
    finalW = ((finalW ?? 0) / 3.0);
    finalW = finalW == 0 ? null : finalW;
    return (BuildContext context, String url, _) {
      return Container(
        width: width,
        height: height,
        decoration: _decoration(border, borderColor, BoxShape.rectangle, radius),
        alignment: Alignment.center,
        child: Image.asset(R.icDefPlaylist),
      );
    };
  }

  @override
  PlaceholderWidgetBuilder getPlaceBuilder(
    double? width,
    double? height,
    double? border,
    Color? borderColor,
    double? radius,
  ) {
    double? finalW = (width ?? 0) > (height ?? 0) ? height : width;
    finalW = ((finalW ?? 0) / 3.0);
    finalW = finalW == 0 ? null : finalW;
    return (BuildContext context, String url) {
      return Container(
        width: width,
        height: height,
        decoration: _decoration(border, borderColor, BoxShape.rectangle, radius),
        alignment: Alignment.center,
        child: SizedBox(
          width: finalW ?? 60.h,
          height: finalW ?? 60.h,
          child: Image.asset(R.icDefPlaylist),
        ),
      );
    };
  }

  @override
  getCircleErrorBuilder(double? radius, double? border, Color? borderColor) {
    double? width = radius == null ? null : radius * 2 / 2.0;
    return (BuildContext context, String url, _) {
      return ClipOval(
        child: Container(
          decoration: _decoration(border, borderColor),
          width: radius! * 2,
          height: radius * 2,
          alignment: Alignment.center,
          child: Image.asset(R.icDefAvatar, width: (width ?? 60.r) * 2, height: (width ?? 60.r) * 2),
        ),
      );
    };
  }

  @override
  PlaceholderWidgetBuilder getCirclePlaceBuilder(double? radius, double? border, Color? borderColor) {
    double? width = radius == null ? null : radius * 2 / 2.0;
    return (BuildContext context, String url) {
      return ClipOval(
        child: Container(
          decoration: _decoration(border, borderColor),
          width: radius! * 2,
          height: radius * 2,
          alignment: Alignment.center,
          child: Image.asset(R.icDefAvatar, width: (width ?? 60.r) * 2, height: (width ?? 60.r) * 2),
        ),
      );
    };
  }

  BoxDecoration _decoration(double? border, Color? borderColor, [BoxShape shape = BoxShape.circle, double? radius]) {
    return BoxDecoration(
      shape: shape,
      border:
          border == null || border == 0.0 ? null : Border.all(color: borderColor ?? Colors.transparent, width: border),
      color: Colors.transparent,
      borderRadius: radius != null ? BorderRadius.circular(radius) : null,
    );
  }
}
