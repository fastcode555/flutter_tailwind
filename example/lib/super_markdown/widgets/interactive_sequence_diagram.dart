import 'package:example/super_markdown/core/theme/sequence_diagram_theme.dart';
import 'package:example/super_markdown/models/sequence_diagram_models.dart';
import 'package:example/super_markdown/widgets/animated_sequence_diagram.dart';
import 'package:flutter/material.dart';

class InteractiveSequenceDiagram extends StatefulWidget {
  final String code;
  final SequenceDiagramTheme theme;
  final bool enableZoom;
  final bool enablePan;
  final bool enableSelection;
  final ValueChanged<String>? onElementSelected;

  const InteractiveSequenceDiagram({
    required this.code, super.key,
    this.theme = const SequenceDiagramTheme(),
    this.enableZoom = true,
    this.enablePan = true,
    this.enableSelection = true,
    this.onElementSelected,
  });

  @override
  State<InteractiveSequenceDiagram> createState() => _InteractiveSequenceDiagramState();
}

class _InteractiveSequenceDiagramState extends State<InteractiveSequenceDiagram> {
  double _scale = 1;
  Offset _position = Offset.zero;
  String? _selectedElement;
  late SequenceDiagram _diagram;

  @override
  void initState() {
    super.initState();
    _diagram = SequenceDiagram.fromMarkdown(widget.code);
  }

  @override
  void didUpdateWidget(InteractiveSequenceDiagram oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code) {
      _diagram = SequenceDiagram.fromMarkdown(widget.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: widget.enableZoom || widget.enablePan
          ? (details) {
              _position = details.focalPoint;
            }
          : null,
      onScaleUpdate: widget.enableZoom || widget.enablePan
          ? (details) {
              setState(() {
                if (widget.enableZoom) {
                  _scale *= details.scale;
                }
                if (widget.enablePan) {
                  _position = details.focalPoint;
                }
              });
            }
          : null,
      child: InteractiveViewer(
        transformationController: TransformationController(),
        minScale: 0.5,
        maxScale: 2,
        child: Stack(
          children: [
            AnimatedSequenceDiagram(
              diagram: _diagram,
              theme: widget.theme,
            ),
            if (widget.enableSelection)
              GestureDetector(
                onTapDown: (details) {
                  final element = _hitTest(details.localPosition);
                  setState(() => _selectedElement = element);
                  if (element != null) {
                    widget.onElementSelected?.call(element);
                  }
                },
                child: Container(color: Colors.transparent),
              ),
          ],
        ),
      ),
    );
  }

  String? _hitTest(Offset position) {
    // 实现点击测试逻辑
    // 遍历图表元素，检查点击位置是否在元素范围内
    for (final participant in _diagram.participants) {
      final rect = _getParticipantRect(participant);
      if (rect.contains(position)) {
        return participant.name;
      }
    }

    for (final message in _diagram.messages) {
      if (_isPointNearLine(position, message)) {
        return message.text;
      }
    }

    for (final note in _diagram.notes) {
      final rect = _getNoteRect(note);
      if (rect.contains(position)) {
        return note.text;
      }
    }

    return null;
  }

  Rect _getParticipantRect(Participant participant) {
    // 计算参与者的矩形区域
    // 这里需要根据实际布局计算
    return Rect.zero; // 临时返回
  }

  bool _isPointNearLine(Offset point, Message message) {
    // 检查点是否在消息线附近
    // 这里需要根据实际布局计算
    return false; // 临时返回
  }

  Rect _getNoteRect(Note note) {
    // 计算注释的矩形区域
    // 这里需要根据实际布局计算
    return Rect.zero; // 临时返回
  }
}
