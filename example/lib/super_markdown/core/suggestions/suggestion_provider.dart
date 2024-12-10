import 'package:flutter/material.dart';

// 提示类型
enum SuggestionType {
  heading, // 标题
  format, // 格式化
  list, // 列表
  link, // 链接
  table, // 表格
  codeBlock, // 代码块
  math, // 数学公式
  custom // 自定义
}

// 提示项
class Suggestion {
  final String label; // 显示文本
  final String insertText; // 插入文本
  final String description; // 描述
  final SuggestionType type; // 类型
  final String? example; // 示例
  final String? shortcut; // 快捷键
  final IconData? icon; // 图标

  const Suggestion({
    required this.label,
    required this.insertText,
    required this.description,
    required this.type,
    this.example,
    this.shortcut,
    this.icon,
  });
}

// 提示数据提供者
class SuggestionProvider {
  // 标题提示
  static final headings = [
    const Suggestion(
      label: '一级标题',
      insertText: '# ',
      description: '最大标题',
      type: SuggestionType.heading,
      example: '# 标题',
      icon: Icons.title,
    ),
    const Suggestion(
      label: '二级标题',
      insertText: '## ',
      description: '次级标题',
      type: SuggestionType.heading,
      example: '## 标题',
      icon: Icons.title,
    ),
  ];

  // 格式化提示
  static final formats = [
    const Suggestion(
      label: '粗体',
      insertText: '**粗体文本**',
      description: '加粗文本',
      type: SuggestionType.format,
      example: '**粗体文本**',
      shortcut: 'Ctrl+B',
      icon: Icons.format_bold,
    ),
    // ... 其他格式化选项
  ];

  // 获取所有提示项
  static List<Suggestion> getAllSuggestions() {
    return [
      ...headings,
      ...formats,
      // ... 其他类型的提示
    ];
  }

  // 根据输入文本获取相关提示
  static List<Suggestion> getSuggestions(String text) {
    final suggestions = getAllSuggestions();
    if (text.isEmpty) return suggestions;

    return suggestions
        .where((s) =>
            s.label.toLowerCase().contains(text.toLowerCase()) ||
            s.description.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }
}
