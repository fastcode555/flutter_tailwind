import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class CodeBlockEditor extends StatelessWidget {
  final String code;
  final String? language;
  final bool readOnly;
  final Function(String)? onChanged;
  final bool showLineNumbers;
  final bool showCopyButton;
  final Map<String, TextStyle>? theme;

  const CodeBlockEditor({
    required this.code,
    super.key,
    this.language,
    this.readOnly = false,
    this.onChanged,
    this.showLineNumbers = true,
    this.showCopyButton = true,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return container.grey100.rounded8.border1.borderGrey200.child(
      column.crossStart.children([
        // 工具栏
        if (language != null || showCopyButton)
          container.grey50.roundedT8.p8.borderB1.borderGrey200.child(
            row.spaceBetween.children([
              // 语言标签
              if (language != null)
                container.grey200.rounded4.p4.ph8.child(
                  language!.text.grey600.f12.mk,
                ),

              // 复制按钮
              if (showCopyButton)
                IconButton(
                  icon: Icons.copy.icon.grey600.s20.mk,
                  onPressed: () => _copyCode(context),
                  tooltip: '复制代码',
                ),
            ]),
          ),

        // 代码区域
        _buildHighlightedCode(),
      ]),
    );
  }

  Widget _buildHighlightedCode() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: HighlightView(
        code,
        language: language ?? 'plaintext',
        theme: theme ?? githubTheme,
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
        ),
        padding: const EdgeInsets.all(12),
        tabSize: 4,
        // lineNumbers: showLineNumbers,
      ),
    );
  }

  void _copyCode(BuildContext context) {
    // 复制代码到剪贴板
    Get.snackbar(
      '成功',
      '代码已复制到剪贴板',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
