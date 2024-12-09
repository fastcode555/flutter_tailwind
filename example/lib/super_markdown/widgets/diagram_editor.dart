import 'package:example/super_markdown/core/theme/sequence_diagram_theme.dart';
import 'package:example/super_markdown/models/diagram_element.dart';
import 'package:example/super_markdown/widgets/diagram_editor_painter.dart';
import 'package:flutter/material.dart';

class DiagramEditor extends StatefulWidget {
  final String initialCode;
  final ValueChanged<String>? onChanged;
  final SequenceDiagramTheme theme;

  const DiagramEditor({
    required this.initialCode, super.key,
    this.onChanged,
    this.theme = const SequenceDiagramTheme(),
  });

  @override
  State<DiagramEditor> createState() => _DiagramEditorState();
}

class _DiagramEditorState extends State<DiagramEditor> {
  late TextEditingController _controller;
  late List<DiagramElement> _elements;
  DiagramElement? _selectedElement;
  bool _isDragging = false;
  final Offset _dragStart = Offset.zero;
  String _dragElementType = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCode);
    _elements = _parseElements(widget.initialCode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 左侧工具栏
        SizedBox(
          width: 200,
          child: Column(
            children: [
              _buildElementPalette(),
              _buildPropertyEditor(),
            ],
          ),
        ),

        // 中间编辑区域
        Expanded(
          child: Stack(
            children: [
              InteractiveViewer(
                child: CustomPaint(
                  painter: DiagramEditorPainter(
                    elements: _elements,
                    selectedElement: _selectedElement,
                    theme: widget.theme,
                  ),
                ),
              ),
              if (_isDragging)
                CustomPaint(
                  painter: DragPreviewPainter(
                    start: _dragStart,
                    current: _dragStart,
                    elementType: _dragElementType,
                  ),
                ),
            ],
          ),
        ),

        // 右侧代码编辑器
        SizedBox(
          width: 300,
          child: TextField(
            controller: _controller,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _elements = _parseElements(value);
              });
              widget.onChanged?.call(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildElementPalette() {
    return Column(
      children: [
        _buildDraggableElement('Participant', Icons.person),
        _buildDraggableElement('Message', Icons.arrow_forward),
        _buildDraggableElement('Note', Icons.note),
        _buildDraggableElement('Fragment', Icons.crop_square),
      ],
    );
  }

  Widget _buildDraggableElement(String type, IconData icon) {
    return Draggable<String>(
      data: type,
      onDragStarted: () {
        setState(() {
          _isDragging = true;
          _dragElementType = type;
        });
      },
      onDragEnd: (details) {
        setState(() {
          _isDragging = false;
        });
      },
      feedback: Material(
        child: ListTile(
          leading: Icon(icon),
          title: Text(type),
        ),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(type),
      ),
    );
  }

  Widget _buildPropertyEditor() {
    if (_selectedElement == null) return Container();

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Label'),
          onChanged: (value) {
            setState(() {
              _selectedElement = _selectedElement!.copyWith(label: value);
              _updateCode();
            });
          },
        ),
        // 添加更多属性编辑器
      ],
    );
  }

  void _updateCode() {
    final code = _generateCode(_elements);
    _controller.text = code;
    widget.onChanged?.call(code);
  }

  List<DiagramElement> _parseElements(String code) {
    // 实现解析逻辑
    return [];
  }

  String _generateCode(List<DiagramElement> elements) {
    // 实现代码生成逻辑
    return '';
  }
}
