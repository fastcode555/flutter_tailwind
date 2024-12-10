import 'dart:math' as math;

import 'package:example/super_markdown/core/services/expression_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FunctionPlotter extends StatefulWidget {
  final String function;
  final String? paramFunction;
  final bool isPolar;
  final double xMin;
  final double xMax;
  final double yMin;
  final double yMax;
  final int samples;
  final Color color;

  const FunctionPlotter({
    required this.function,
    super.key,
    this.paramFunction,
    this.isPolar = false,
    this.xMin = -10,
    this.xMax = 10,
    this.yMin = -10,
    this.yMax = 10,
    this.samples = 200,
    this.color = Colors.blue,
  });

  @override
  State<FunctionPlotter> createState() => _FunctionPlotterState();
}

class _FunctionPlotterState extends State<FunctionPlotter> {
  late List<Offset> _points;
  late double _scale;
  late Offset _offset;
  late double _gridSize;

  @override
  void initState() {
    super.initState();
    _scale = 1.0;
    _offset = Offset.zero;
    _gridSize = 1.0;
    _calculatePoints();
  }

  void _calculatePoints() {
    _points = [];
    if (widget.isPolar) {
      _calculatePolarPoints();
    } else if (widget.paramFunction != null) {
      _calculateParametricPoints();
    } else {
      _calculateCartesianPoints();
    }
  }

  void _calculateCartesianPoints() {
    final dx = (widget.xMax - widget.xMin) / widget.samples;
    for (var i = 0; i <= widget.samples; i++) {
      final x = widget.xMin + dx * i;
      final expr = widget.function.replaceAll('x', x.toString());
      final y = ExpressionParser.evaluate(expr);

      if (y != null && y.isFinite && y >= widget.yMin && y <= widget.yMax) {
        _points.add(Offset(x, y));
      }
    }
  }

  void _calculateParametricPoints() {
    if (widget.paramFunction == null) return;

    final dt = (widget.xMax - widget.xMin) / widget.samples;
    for (var i = 0; i <= widget.samples; i++) {
      final t = widget.xMin + dt * i;
      final xExpr = widget.function.replaceAll('t', t.toString());
      final yExpr = widget.paramFunction!.replaceAll('t', t.toString());

      final x = ExpressionParser.evaluate(xExpr);
      final y = ExpressionParser.evaluate(yExpr);

      if (x != null &&
          y != null &&
          x.isFinite &&
          y.isFinite &&
          x >= widget.xMin &&
          x <= widget.xMax &&
          y >= widget.yMin &&
          y <= widget.yMax) {
        _points.add(Offset(x, y));
      }
    }
  }

  void _calculatePolarPoints() {
    final dTheta = 2 * math.pi / widget.samples;
    for (var i = 0; i <= widget.samples; i++) {
      final theta = i * dTheta;
      final expr = widget.function.replaceAll('theta', theta.toString());
      final r = ExpressionParser.evaluate(expr);

      if (r != null && r.isFinite) {
        final x = r * math.cos(theta);
        final y = r * math.sin(theta);

        if (x >= widget.xMin && x <= widget.xMax && y >= widget.yMin && y <= widget.yMax) {
          _points.add(Offset(x, y));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.cardShadow.child(
      GestureDetector(
        onScaleStart: _handleScaleStart,
        onScaleUpdate: _handleScaleUpdate,
        child: CustomPaint(
          painter: _FunctionPainter(
            points: _points,
            xMin: widget.xMin,
            xMax: widget.xMax,
            yMin: widget.yMin,
            yMax: widget.yMax,
            scale: _scale,
            offset: _offset,
            gridSize: _gridSize,
          ),
          size: const Size(double.infinity, 300),
        ),
      ),
    );
  }

  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _gridSize = 1.0;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale *= details.scale;
      _offset += details.focalPointDelta;
      _gridSize = math.pow(2, -(_scale - 1).floor()).toDouble();
    });
  }
}

class _FunctionPainter extends CustomPainter {
  final List<Offset> points;
  final double xMin;
  final double xMax;
  final double yMin;
  final double yMax;
  final double scale;
  final Offset offset;
  final double gridSize;

  _FunctionPainter({
    required this.points,
    required this.xMin,
    required this.xMax,
    required this.yMin,
    required this.yMax,
    required this.scale,
    required this.offset,
    required this.gridSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2 + offset.dx, size.height / 2 + offset.dy);
    canvas.scale(scale);

    // 绘制网格
    _drawGrid(canvas, size);

    // 绘制坐标轴
    _drawAxes(canvas, size);

    // 绘制函数曲线
    _drawFunction(canvas, size);

    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 0.5;

    final xCount = ((xMax - xMin) / gridSize).ceil();
    final yCount = ((yMax - yMin) / gridSize).ceil();
    final xStep = size.width / xCount;
    final yStep = size.height / yCount;

    // 绘制垂直网格线
    for (var i = 0; i <= xCount; i++) {
      final x = -size.width / 2 + i * xStep;
      canvas.drawLine(
        Offset(x, -size.height / 2),
        Offset(x, size.height / 2),
        paint,
      );
    }

    // 绘制水平网格线
    for (var i = 0; i <= yCount; i++) {
      final y = -size.height / 2 + i * yStep;
      canvas.drawLine(
        Offset(-size.width / 2, y),
        Offset(size.width / 2, y),
        paint,
      );
    }
  }

  void _drawAxes(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // X轴
    canvas.drawLine(
      Offset(-size.width / 2, 0),
      Offset(size.width / 2, 0),
      paint,
    );

    // Y轴
    canvas.drawLine(
      Offset(0, -size.height / 2),
      Offset(0, size.height / 2),
      paint,
    );

    // 绘制刻度
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // X轴刻度
    for (var x = (xMin / gridSize).ceil() * gridSize; x <= xMax; x += gridSize) {
      if (x == 0) continue;
      final xPos = x * size.width / (xMax - xMin);
      canvas.drawLine(
        Offset(xPos, -5),
        Offset(xPos, 5),
        paint,
      );
      textPainter.text = TextSpan(
        text: x.toStringAsFixed(1),
        style: const TextStyle(fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(xPos - textPainter.width / 2, 10),
      );
    }

    // Y轴刻度
    for (var y = (yMin / gridSize).ceil() * gridSize; y <= yMax; y += gridSize) {
      if (y == 0) continue;
      final yPos = -y * size.height / (yMax - yMin);
      canvas.drawLine(
        Offset(-5, yPos),
        Offset(5, yPos),
        paint,
      );
      textPainter.text = TextSpan(
        text: y.toStringAsFixed(1),
        style: const TextStyle(fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(-textPainter.width - 10, yPos - textPainter.height / 2),
      );
    }
  }

  void _drawFunction(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    var isFirst = true;

    for (final point in points) {
      final x = point.dx * size.width / (xMax - xMin);
      final y = -point.dy * size.height / (yMax - yMin);

      if (isFirst) {
        path.moveTo(x, y);
        isFirst = false;
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
