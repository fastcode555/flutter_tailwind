import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class MarkdownService extends GetxService {
  // Markdown解析器配置
  final _markdownConfig = MarkdownStyleSheet(
    h1: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    h2: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    h3: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    h4: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    h5: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    h6: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    p: const TextStyle(fontSize: 16),
    code: TextStyle(
      backgroundColor: Colors.grey[200],
      fontFamily: 'monospace',
    ),
    codeblockDecoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    ),
    blockquote: TextStyle(
      color: Colors.grey[700],
      fontStyle: FontStyle.italic,
    ),
    tableHead: const TextStyle(fontWeight: FontWeight.bold),
    tableBorder: TableBorder.all(
      color: Colors.grey[300]!,
    ),
  );

  // 解析Markdown文本
  String parseMarkdown(String text) {
    return text;
  }

  // 获取样式表
  MarkdownStyleSheet get styleSheet => _markdownConfig;
}
