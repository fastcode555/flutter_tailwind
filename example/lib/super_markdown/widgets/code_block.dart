import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class CodeBlock extends StatelessWidget {
  final String code;
  final String language;
  final bool showLineNumbers;
  final VoidCallback? onCopy;

  const CodeBlock({
    required this.code, required this.language, super.key,
    this.showLineNumbers = true,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return container.grey900.rounded8.p16.cardShadow.child(
      column.children([
        // 头部工具栏
        row.spaceBetween.children([
          // 语言标签
          container.grey800.rounded4.ph8.pv4.child(
            language.text.grey400.f12.mk,
          ),
          // 复制按钮
          IconButton(
            icon: Icons.content_copy.icon.grey400.s16.mk,
            tooltip: '复制代码',
            onPressed: () {
              onCopy?.call();
              // 显示复制成功提示
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('代码已复制到剪贴板')),
              );
            },
          ),
        ]),

        h16,

        // 代码区域
        Expanded(
          child: row.children([
            // 行号
            if (showLineNumbers)
              container.grey800.rounded4.p8.child(
                column.crossStart.children(
                  List.generate(
                    code.split('\n').length,
                    (index) => container.h24.child(
                      '${index + 1}'.text.grey400.f12.mk,
                    ),
                  ),
                ),
              ),

            w8,

            // 代码内容
            Expanded(
              child: SingleChildScrollView(
                child: HighlightView(
                  code,
                  language: language,
                  theme: monokaiSublimeTheme,
                  textStyle: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    height: 1.5,
                  ),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
} 