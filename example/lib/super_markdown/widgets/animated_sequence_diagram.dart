import 'package:example/super_markdown/core/theme/sequence_diagram_theme.dart';
import 'package:example/super_markdown/models/sequence_diagram_models.dart';
import 'package:flutter/material.dart';

class AnimatedSequenceDiagram extends StatefulWidget {
  final SequenceDiagram diagram;
  final SequenceDiagramTheme theme;
  final bool animated;
  final Duration animationDuration;
  final Curve animationCurve;

  const AnimatedSequenceDiagram({
    required this.diagram,
    required this.theme,
    super.key,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<AnimatedSequenceDiagram> createState() => _AnimatedSequenceDiagramState();
}

class _AnimatedSequenceDiagramState extends State<AnimatedSequenceDiagram> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  final List<Animation<double>> _messageAnimations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );

    // 创建消息动画
    _createMessageAnimations();

    if (widget.animated) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  void _createMessageAnimations() {
    final messageCount = widget.diagram.messages.length;
    if (messageCount == 0) return;

    final interval = 1.0 / messageCount;
    for (var i = 0; i < messageCount; i++) {
      _messageAnimations.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _animation,
            curve: Interval(
              i * interval,
              (i + 1) * interval,
              curve: widget.animationCurve,
            ),
          ),
        ),
      );
    }
  }

  @override
  void didUpdateWidget(AnimatedSequenceDiagram oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.diagram != oldWidget.diagram) {
      _messageAnimations.clear();
      _createMessageAnimations();
      if (widget.animated) {
        _controller.forward(from: 0);
      } else {
        _controller.value = 1.0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: SequenceDiagramPainter(
            diagram: widget.diagram,
            theme: widget.theme,
            progress: _animation.value,
            messageAnimations: _messageAnimations,
          ),
        );
      },
    );
  }
}

class SequenceDiagramPainter extends CustomPainter {
  final SequenceDiagram diagram;
  final SequenceDiagramTheme theme;
  final double progress;
  final List<Animation<double>> messageAnimations;

  SequenceDiagramPainter({
    required this.diagram,
    required this.theme,
    required this.progress,
    required this.messageAnimations,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final participantSpacing = size.width / (diagram.participants.length + 1);
    final participantY = theme.participantStyle.height / 2;

    // 绘制参与者
    for (var i = 0; i < diagram.participants.length; i++) {
      final participant = diagram.participants[i];
      final x = participantSpacing * (i + 1);
      _drawParticipant(canvas, participant, Offset(x, participantY));
    }

    // 绘制生命线
    for (var i = 0; i < diagram.participants.length; i++) {
      final x = participantSpacing * (i + 1);
      _drawLifeline(canvas, x, participantY, size.height);
    }

    // 绘制消息
    for (var i = 0; i < diagram.messages.length; i++) {
      final message = diagram.messages[i];
      final animation = messageAnimations[i];
      _drawMessage(canvas, message, participantSpacing, animation.value);
    }

    // 绘制注释
    for (final note in diagram.notes) {
      _drawNote(canvas, note, participantSpacing);
    }
  }

  void _drawParticipant(Canvas canvas, Participant participant, Offset position) {
    final style = theme.participantStyle;
    final rect = Rect.fromCenter(
      center: position,
      width: style.width,
      height: style.height,
    );

    // 绘制背景
    final paint = Paint()
      ..color = style.backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);

    // 绘制边框
    paint
      ..color = style.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = style.borderWidth;
    canvas.drawRect(rect, paint);

    // 绘制文本
    final textSpan = TextSpan(
      text: participant.name,
      style: style.textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: style.width,
      maxWidth: style.width,
    );
    textPainter.paint(
      canvas,
      Offset(
        position.dx - style.width / 2,
        position.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawLifeline(Canvas canvas, double x, double startY, double endY) {
    final paint = Paint()
      ..color = theme.lifelineStyle.color
      ..strokeWidth = theme.lifelineStyle.width
      ..style = PaintingStyle.stroke;

    if (theme.lifelineStyle.dashPattern != null) {
      paint.strokeWidth = theme.lifelineStyle.width;
      final path = Path()
        ..moveTo(x, startY + theme.participantStyle.height / 2)
        ..lineTo(x, endY);
      canvas.drawPath(
        dashPath(
          path,
          dashArray: CircularIntervalList<double>(theme.lifelineStyle.dashPattern!),
        ),
        paint,
      );
    } else {
      canvas.drawLine(
        Offset(x, startY + theme.participantStyle.height / 2),
        Offset(x, endY),
        paint,
      );
    }
  }

  void _drawMessage(Canvas canvas, Message message, double spacing, double animation) {
    final fromIndex = diagram.participants.indexWhere((p) => p.name == message.from);
    final toIndex = diagram.participants.indexWhere((p) => p.name == message.to);

    final startX = spacing * (fromIndex + 1);
    final endX = spacing * (toIndex + 1);
    final y = message.order * theme.messageStyle.spacing + theme.participantStyle.height * 2;

    final paint = Paint()
      ..color = theme.messageStyle.color
      ..strokeWidth = theme.messageStyle.width
      ..style = PaintingStyle.stroke;

    // 绘制箭头线
    final path = Path()
      ..moveTo(startX, y)
      ..lineTo(startX + (endX - startX) * animation, y);

    canvas.drawPath(path, paint);

    // 绘制箭头头部
    if (animation == 1.0) {
      final arrowSize = theme.messageStyle.arrowSize;
      final direction = (endX - startX).sign;
      final arrowPath = Path()
        ..moveTo(endX, y)
        ..lineTo(endX - direction * arrowSize, y - arrowSize / 2)
        ..lineTo(endX - direction * arrowSize, y + arrowSize / 2)
        ..close();
      canvas.drawPath(arrowPath, paint..style = PaintingStyle.fill);
    }

    // 绘制消息文本
    if (animation > 0.5) {
      final textSpan = TextSpan(
        text: message.text,
        style: theme.messageStyle.textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (startX + endX - textPainter.width) / 2,
          y - textPainter.height - theme.messageStyle.textSpacing,
        ),
      );
    }
  }

  void _drawNote(Canvas canvas, Note note, double spacing) {
    final style = theme.noteStyle;
    final startIndex = diagram.participants.indexWhere((p) => p.name == note.participant);
    final endIndex = note.endParticipant != null
        ? diagram.participants.indexWhere((p) => p.name == note.endParticipant)
        : startIndex;

    final x = spacing * (startIndex + 1);
    final width = note.endParticipant != null ? spacing * (endIndex - startIndex) : style.width;
    final y = note.order * theme.messageStyle.spacing + theme.participantStyle.height * 2;

    final rect = Rect.fromLTWH(
      x - width / 2,
      y,
      width,
      style.height,
    );

    // 绘制背景
    final paint = Paint()
      ..color = style.backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);

    // 绘制边框
    paint
      ..color = style.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = style.borderWidth;
    canvas.drawRect(rect, paint);

    // 绘制文本
    final textSpan = TextSpan(
      text: note.text,
      style: style.textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: width - style.padding * 2,
      maxWidth: width - style.padding * 2,
    );
    textPainter.paint(
      canvas,
      Offset(
        x - width / 2 + style.padding,
        y + (style.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(SequenceDiagramPainter oldDelegate) {
    return oldDelegate.diagram != diagram ||
        oldDelegate.theme != theme ||
        oldDelegate.progress != progress ||
        oldDelegate.messageAnimations != messageAnimations;
  }
}

// 虚线路径辅助类
class CircularIntervalList<T> {
  final List<T> _values;
  int _index = 0;

  CircularIntervalList(this._values);

  T get next {
    if (_index >= _values.length) {
      _index = 0;
    }
    return _values[_index++];
  }
}

Path dashPath(
  Path source, {
  required CircularIntervalList<double> dashArray,
  double? dashOffset,
}) {
  final dest = Path();
  for (final metric in source.computeMetrics()) {
    var distance = dashOffset ?? 0;
    var draw = true;
    while (distance < metric.length) {
      final len = dashArray.next;
      if (draw) {
        dest.addPath(
          metric.extractPath(distance, distance + len),
          Offset.zero,
        );
      }
      distance += len;
      draw = !draw;
    }
  }
  return dest;
}
