import 'package:example/super_markdown/core/theme/sequence_diagram_theme.dart';
import 'package:example/super_markdown/models/diagram_element.dart';
import 'package:flutter/material.dart';

// 图表编辑器画笔
class DiagramEditorPainter extends CustomPainter {
  final List<DiagramElement> elements;
  final DiagramElement? selectedElement;
  final SequenceDiagramTheme theme;

  DiagramEditorPainter({
    required this.elements,
    required this.selectedElement,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制网格背景
    _drawGrid(canvas, size);

    // 绘制所有元素
    for (final element in elements) {
      final isSelected = element == selectedElement;
      _drawElement(canvas, element, isSelected);
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;

    // 绘制垂直线
    for (var x = 0.0; x < size.width; x += 20) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // 绘制水平线
    for (var y = 0.0; y < size.height; y += 20) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  void _drawElement(Canvas canvas, DiagramElement element, bool isSelected) {
    switch (element.type) {
      case DiagramElement.typeParticipant:
        _drawParticipant(canvas, element, isSelected);
      case DiagramElement.typeMessage:
        _drawMessage(canvas, element, isSelected);
      case DiagramElement.typeNote:
        _drawNote(canvas, element, isSelected);
      case DiagramElement.typeFragment:
        _drawFragment(canvas, element, isSelected);
    }
  }

  void _drawParticipant(Canvas canvas, DiagramElement element, bool isSelected) {
    final rect = Rect.fromCenter(
      center: element.position,
      width: 100,
      height: 40,
    );

    // 绘制背景
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );

    // 绘制边框
    canvas.drawRect(
      rect,
      Paint()
        ..color = isSelected ? Colors.blue : Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 2 : 1,
    );

    // 绘制文本
    final textSpan = TextSpan(
      text: element.label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        element.position.dx - textPainter.width / 2,
        element.position.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawMessage(Canvas canvas, DiagramElement element, bool isSelected) {
    final paint = Paint()
      ..color = isSelected ? Colors.blue : Colors.black
      ..strokeWidth = isSelected ? 2 : 1;

    // 获取起点和终点
    final start = element.position;
    final end = Offset(
      element.position.dx + (element.properties['length'] ?? 100.0),
      element.position.dy,
    );

    // 绘制线条
    canvas.drawLine(start, end, paint);

    // 绘制箭头
    const arrowSize = 10.0;
    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - arrowSize, end.dy - arrowSize / 2)
      ..lineTo(end.dx - arrowSize, end.dy + arrowSize / 2)
      ..close();
    canvas.drawPath(path, paint);

    // 绘制文本
    final textSpan = TextSpan(
      text: element.label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        (start.dx + end.dx) / 2 - textPainter.width / 2,
        start.dy - textPainter.height - 5,
      ),
    );
  }

  void _drawNote(Canvas canvas, DiagramElement element, bool isSelected) {
    final rect = Rect.fromCenter(
      center: element.position,
      width: 120,
      height: 60,
    );

    // 绘制背景
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.yellow[100]!
        ..style = PaintingStyle.fill,
    );

    // 绘制边框
    canvas.drawRect(
      rect,
      Paint()
        ..color = isSelected ? Colors.blue : Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 2 : 1,
    );

    // 绘制文本
    final textSpan = TextSpan(
      text: element.label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 3,
    )..layout(maxWidth: rect.width - 10);

    textPainter.paint(
      canvas,
      Offset(
        element.position.dx - textPainter.width / 2,
        element.position.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawFragment(Canvas canvas, DiagramElement element, bool isSelected) {
    final rect = Rect.fromCenter(
      center: element.position,
      width: 200,
      height: 100,
    );

    // 绘制背景
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.grey[100]!
        ..style = PaintingStyle.fill,
    );

    // 绘制边框
    canvas.drawRect(
      rect,
      Paint()
        ..color = isSelected ? Colors.blue : Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 2 : 1,
    );

    // 绘制标签背景
    final labelRect = Rect.fromLTWH(
      rect.left,
      rect.top,
      80,
      25,
    );
    canvas.drawRect(
      labelRect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );

    // 绘制标签文本
    final textSpan = TextSpan(
      text: element.label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        labelRect.left + 5,
        labelRect.top + (labelRect.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 拖动预览画笔
class DragPreviewPainter extends CustomPainter {
  final Offset start;
  final Offset current;
  final String elementType;

  DragPreviewPainter({
    required this.start,
    required this.current,
    required this.elementType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    switch (elementType) {
      case DiagramElement.typeParticipant:
        canvas.drawRect(
          Rect.fromCenter(
            center: current,
            width: 100,
            height: 40,
          ),
          paint,
        );
      case DiagramElement.typeMessage:
        canvas.drawLine(start, current, paint);
      case DiagramElement.typeNote:
        canvas.drawRect(
          Rect.fromCenter(
            center: current,
            width: 120,
            height: 60,
          ),
          paint,
        );
      case DiagramElement.typeFragment:
        canvas.drawRect(
          Rect.fromCenter(
            center: current,
            width: 200,
            height: 100,
          ),
          paint,
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
