import 'dart:math' as math;

import 'package:example/super_markdown/widgets/flow_chart.dart';
import 'package:flutter/material.dart';

class AnimatedEdge extends StatefulWidget {
  final Offset start;
  final Offset end;
  final EdgeStyle style;

  const AnimatedEdge({
    required this.start,
    required this.end,
    required this.style,
    super.key,
  });

  @override
  State<AnimatedEdge> createState() => _AnimatedEdgeState();
}

class _AnimatedEdgeState extends State<AnimatedEdge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    if (widget.style.animated) {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _EdgePainter(
        start: widget.start,
        end: widget.end,
        style: widget.style,
        progress: _animation,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _EdgePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final EdgeStyle style;
  final Animation<double> progress;

  _EdgePainter({
    required this.start,
    required this.end,
    required this.style,
    required this.progress,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = style.color
      ..strokeWidth = style.strokeWidth
      ..style = style.style;

    if (style.animated) {
      // 绘制动画箭头
      final path = Path();
      final length = (end - start).distance;
      final direction = (end - start) / length;
      final animatedEnd = start + direction * length * progress.value;

      path.moveTo(start.dx, start.dy);
      path.lineTo(animatedEnd.dx, animatedEnd.dy);

      // 绘制箭头
      final angle = math.atan2(direction.dy, direction.dx);
      final arrowSize = style.strokeWidth * 3;
      const arrowAngle = math.pi / 6;

      path.moveTo(
        animatedEnd.dx - arrowSize * math.cos(angle - arrowAngle),
        animatedEnd.dy - arrowSize * math.sin(angle - arrowAngle),
      );
      path.lineTo(animatedEnd.dx, animatedEnd.dy);
      path.lineTo(
        animatedEnd.dx - arrowSize * math.cos(angle + arrowAngle),
        animatedEnd.dy - arrowSize * math.sin(angle + arrowAngle),
      );

      canvas.drawPath(path, paint);
    } else {
      // 绘制静态连接线
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
