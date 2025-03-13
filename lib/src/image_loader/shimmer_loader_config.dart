import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:shimmer/shimmer.dart';

/// Barry
/// @date 2024/9/6
/// describe:
class ShimmerLoaderConfig extends ImageLoaderConfigInterface {
  @override
  LoadingErrorWidgetBuilder getCircleErrorBuilder(double? radius, double? border, Color? borderColor) {
    return (BuildContext context, String url, _) {
      return _Shimmer.error(Container(
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        width: radius! * 2,
        height: radius * 2,
      ));
    };
  }

  @override
  PlaceholderWidgetBuilder getCirclePlaceBuilder(double? radius, double? border, Color? borderColor) {
    return (BuildContext context, String url) {
      return _Shimmer(Container(
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        width: radius! * 2,
        height: radius * 2,
      ));
    };
  }

  @override
  LoadingErrorWidgetBuilder getErrorBuilder(
    double? width,
    double? height,
    double? border,
    Color? borderColor,
    double? radius,
  ) {
    var finalW = (width ?? 0) > (height ?? 0) ? height : width;
    finalW = ((finalW ?? 0) / 3.0);
    finalW = finalW == 0 ? null : finalW;
    return (BuildContext context, String url, _) {
      return _Shimmer.error(
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: radius != null ? BorderRadius.circular(radius) : null,
            color: Colors.white,
          ),
        ),
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
    var finalW = (width ?? 0) > (height ?? 0) ? height : width;
    finalW = ((finalW ?? 0) / 3.0);
    finalW = finalW == 0 ? null : finalW;
    return (BuildContext context, String url) {
      return _Shimmer(
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: radius != null ? BorderRadius.circular(radius) : null,
            color: Colors.white,
          ),
        ),
      );
    };
  }
}

class _Shimmer extends StatelessWidget {
  final Widget child;

  final bool error;

  const _Shimmer(this.child) : this.error = false;

  const _Shimmer.error(this.child) : this.error = true;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Shimmer.fromColors(
      baseColor: error ? color.opacity20 : Colors.grey.shade200,
      highlightColor: error ? color.opacity70 : Colors.grey.shade400,
      child: child,
    );
  }
}
