import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class LatexEditor extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const LatexEditor({
    required this.onChanged, super.key,
    this.initialValue = '',
  });

  @override
  State<LatexEditor> createState() => _LatexEditorState();
}

class _LatexEditorState extends State<LatexEditor> {
  late final TextEditingController _controller;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue)
      ..addListener(_onLatexChanged);
  }

  void _onLatexChanged() {
    final latex = _controller.text;
    try {
      // 验证 LaTeX 语法
      Math.tex(latex);
      setState(() => _error = '');
      widget.onChanged(latex);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.p16.cardShadow.child(
      column.children([
        // 工具栏
        row.children([
          _buildToolButton('分数', r'\frac{a}{b}'),
          _buildToolButton('上标', 'x^{2}'),
          _buildToolButton('下标', 'x_{i}'),
          _buildToolButton('根号', r'\sqrt{x}'),
          _buildToolButton('求和', r'\sum_{i=1}^{n}'),
          _buildToolButton('积分', r'\int_{a}^{b}'),
          _buildToolButton('极限', r'\lim_{x \to \infty}'),
          _buildToolButton('矩阵', r'\begin{matrix} a & b \\ c & d \end{matrix}'),
        ]),

        h16,

        // 编辑区域
        TextField(
          controller: _controller,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: '输入 LaTeX 公式...',
            border: const OutlineInputBorder(),
            errorText: _error.isNotEmpty ? _error : null,
          ),
        ),

        h16,

        // 预览区域
        if (_error.isEmpty)
          container.grey100.rounded8.p16.center.child(
            Math.tex(
              _controller.text,
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
      ]),
    );
  }

  Widget _buildToolButton(String label, String latex) {
    return TextButton(
      onPressed: () {
        final text = _controller.text;
        final selection = _controller.selection;
        final newText = text.replaceRange(
          selection.start,
          selection.end,
          latex,
        );
        _controller.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
            offset: selection.start + latex.length,
          ),
        );
      },
      child: label.text.mk,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 