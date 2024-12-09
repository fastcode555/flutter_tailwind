import 'package:example/super_markdown/widgets/flow_chart.dart';
import 'package:flutter/material.dart';

class FlowChartShapePainter extends CustomPainter {
  final NodeShape shape;
  final NodeStyle style;

  FlowChartShapePainter({
    required this.shape,
    required this.style,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = style.backgroundColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = style.borderColor
      ..strokeWidth = style.borderWidth
      ..style = PaintingStyle.stroke;

    switch (shape) {
      case NodeShape.hexagon:
        _drawHexagon(canvas, size, paint, borderPaint);
      case NodeShape.cloud:
        _drawCloud(canvas, size, paint, borderPaint);
      case NodeShape.database:
        _drawDatabase(canvas, size, paint, borderPaint);
      case NodeShape.document:
        _drawDocument(canvas, size, paint, borderPaint);
      case NodeShape.parallelogram:
        _drawParallelogram(canvas, size, paint, borderPaint);
      case NodeShape.cylinder:
        _drawCylinder(canvas, size, paint, borderPaint);
      case NodeShape.note:
        _drawNote(canvas, size, paint, borderPaint);
      default:
        // 基本形状由 BoxDecoration 处理
        break;
    }
  }

  void _drawHexagon(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final dx = w * 0.2;

    path.moveTo(dx, 0);
    path.lineTo(w - dx, 0);
    path.lineTo(w, h / 2);
    path.lineTo(w - dx, h);
    path.lineTo(dx, h);
    path.lineTo(0, h / 2);
    path.close();

    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  void _drawCloud(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final r = h * 0.3;

    // 绘制多个圆形组成云形
    path.addOval(Rect.fromCircle(center: Offset(w * 0.3, h * 0.4), radius: r));
    path.addOval(Rect.fromCircle(center: Offset(w * 0.5, h * 0.3), radius: r));
    path.addOval(Rect.fromCircle(center: Offset(w * 0.7, h * 0.4), radius: r));
    path.addOval(Rect.fromCircle(center: Offset(w * 0.4, h * 0.6), radius: r));
    path.addOval(Rect.fromCircle(center: Offset(w * 0.6, h * 0.6), radius: r));

    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  void _drawDatabase(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final topRect = Rect.fromLTWH(0, 0, size.width, size.height * 0.2);
    
    // 绘制主体圆柱
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(size.width * 0.2)),
      fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(size.width * 0.2)),
      stroke,
    );

    // 绘制顶部椭圆
    canvas.drawOval(topRect, fill);
    canvas.drawOval(topRect, stroke);
  }

  void _drawDocument(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h * 0.8);
    path.quadraticBezierTo(w * 0.8, h * 0.8, w * 0.7, h);
    path.quadraticBezierTo(w * 0.5, h * 0.9, w * 0.3, h);
    path.quadraticBezierTo(w * 0.2, h * 0.8, 0, h * 0.8);
    path.close();

    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  void _drawParallelogram(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final dx = w * 0.2;

    path.moveTo(dx, 0);
    path.lineTo(w, 0);
    path.lineTo(w - dx, h);
    path.lineTo(0, h);
    path.close();

    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  void _drawCylinder(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final w = size.width;
    final h = size.height;
    final rect = Rect.fromLTWH(0, h * 0.1, w, h * 0.8);
    final topOval = Rect.fromLTWH(0, 0, w, h * 0.2);
    final bottomOval = Rect.fromLTWH(0, h * 0.8, w, h * 0.2);

    // 绘制主体
    canvas.drawRect(rect, fill);
    canvas.drawRect(rect, stroke);

    // 绘制顶部和底部椭圆
    canvas.drawOval(topOval, fill);
    canvas.drawOval(topOval, stroke);
    canvas.drawOval(bottomOval, fill);
    canvas.drawOval(bottomOval, stroke);
  }

  void _drawNote(Canvas canvas, Size size, Paint fill, Paint stroke) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final corner = w * 0.2;

    path.moveTo(0, 0);
    path.lineTo(w - corner, 0);
    path.lineTo(w, corner);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    // 绘制折角
    final cornerPath = Path();
    cornerPath.moveTo(w - corner, 0);
    cornerPath.lineTo(w - corner, corner);
    cornerPath.lineTo(w, corner);
    cornerPath.close();

    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
    canvas.drawPath(cornerPath, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 