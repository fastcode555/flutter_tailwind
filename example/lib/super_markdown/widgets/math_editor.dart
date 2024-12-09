import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class MathEditor extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const MathEditor({
    required this.onChanged, super.key,
    this.initialValue = '',
  });

  @override
  State<MathEditor> createState() => _MathEditorState();
}

class _MathEditorState extends State<MathEditor> {
  late final TextEditingController _controller;
  String _previewText = '';
  String _error = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue)..addListener(_handleTextChange);
    _previewText = widget.initialValue;
  }

  void _handleTextChange() {
    setState(() {
      try {
        // 尝试解析LaTeX公式
        Math.tex(_controller.text);
        _previewText = _controller.text;
        _error = '';
        widget.onChanged(_controller.text);
      } catch (e) {
        _error = e.toString();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.p16.cardShadow.child(
      column.children([
        // 工具栏
        _buildToolbar(),
        h16,

        // 编辑区域
        container.grey100.rounded8.p12.child(
          TextField(
            controller: _controller,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: '输入LaTeX公式',
              border: InputBorder.none,
            ),
          ),
        ),
        h16,

        // 预览区域
        container.grey100.rounded8.p12.center.h100.child(
          _error.isEmpty
              ? Math.tex(
                  _previewText,
                  textStyle: const TextStyle(fontSize: 20),
                )
              : _error.text.red.f14.mk,
        ),
      ]),
    );
  }

  Widget _buildToolbar() {
    return wrap.spacing8.runSpacing8.children(
      [
        _buildToolButton('分数', r'\frac{a}{b}'),
        _buildToolButton('上标', 'x^{2}'),
        _buildToolButton('下标', 'x_{i}'),
        _buildToolButton('根号', r'\sqrt{x}'),
        _buildToolButton('求和', r'\sum_{i=1}^{n}'),
        _buildToolButton('积分', r'\int_{a}^{b}'),
        _buildToolButton('极限', r'\lim_{x \to \infty}'),
        _buildToolButton('矩阵', r'\begin{matrix} a & b \\ c & d \end{matrix}'),
      ],
    );
  }

  Widget _buildToolButton(String label, String formula) {
    return container.grey100.rounded4.p8
        .child(
      row.center.children([
        Math.tex(formula, textStyle: const TextStyle(fontSize: 14)),
        w8,
        label.text.f12.mk,
      ]),
    )
        .click(onTap: () {
      final text = _controller.text;
      final selection = _controller.selection;
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        formula,
      );
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start + formula.length,
        ),
      );
    });
  }
}
