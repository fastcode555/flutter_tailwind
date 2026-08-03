import 'package:flutter/material.dart';

mixin BorderStyleBuilder {
  bool innerBorderDashed = false;
  double innerDashWidth = 5;
  double innerDashGap = 4;
}

extension BorderStyleBuilderExt<T extends BorderStyleBuilder> on T {
  T get borderDashed => this..innerBorderDashed = true;

  T dashWidth(double width) => this..innerDashWidth = width;

  T dashGap(double gap) => this..innerDashGap = gap;
}

class DashedBorderPainter extends CustomPainter {
  const DashedBorderPainter({
    required this.color,
    required this.width,
    required this.radius,
    required this.dashWidth,
    required this.dashGap,
  });

  final Color color;
  final double width;
  final double radius;
  final double dashWidth;
  final double dashGap;

  @override
  void paint(Canvas canvas, Size size) {
    if (width <= 0) return;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final rect = Rect.fromLTWH(width / 2, width / 2, size.width - width, size.height - width);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final dashedPath = Path();
    for (final metric in (Path()..addRRect(rrect)).computeMetrics()) {
      var distance = 0.0;
      var draw = true;
      while (distance < metric.length) {
        final length = draw ? dashWidth : dashGap;
        if (draw) dashedPath.addPath(metric.extractPath(distance, distance + length), Offset.zero);
        distance += length;
        draw = !draw;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      width != oldDelegate.width ||
      radius != oldDelegate.radius ||
      dashWidth != oldDelegate.dashWidth ||
      dashGap != oldDelegate.dashGap;
}
