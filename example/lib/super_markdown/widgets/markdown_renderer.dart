import 'package:example/super_markdown/widgets/flow_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class MarkdownRenderer extends StatelessWidget {
  final String markdown;

  const MarkdownRenderer({
    required this.markdown, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: markdown,
      builders: {
        'code': CodeBlockBuilder(),
        'flowchart': FlowChartBuilder(),
      },
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        // 自定义样式
        h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        p: const TextStyle(fontSize: 16),
        code: TextStyle(
          backgroundColor: Colors.grey[200],
          fontFamily: 'monospace',
          fontSize: 14,
        ),
        codeblockDecoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    if (element.tag == 'code') {
      final language = element.attributes['class']?.split('-').last ?? '';
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: SelectableText(
          element.textContent,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      );
    }
    return null;
  }
}

class FlowChartBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    if (element.tag == 'flowchart') {
      return FlowChart(code: element.textContent);
    }
    return null;
  }
}
