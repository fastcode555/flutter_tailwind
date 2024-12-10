import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class WordCountBar extends StatelessWidget {
  final String text;

  const WordCountBar({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats(text);

    return container.grey100.p8.child(
      row.center.children([
        _buildStat('字数', stats.characters),
        _buildStat('单词', stats.words),
        _buildStat('行数', stats.lines),
        _buildStat('段落', stats.paragraphs),
        _buildStat('标题', stats.headings),
        _buildStat('代码块', stats.codeBlocks),
        _buildStat('公式', stats.mathBlocks),
        _buildStat('图片', stats.images),
        _buildStat('链接', stats.links),
        _buildStat('表格', stats.tables),
        _buildReadingTime(stats.characters),
      ]),
    );
  }

  Widget _buildStat(String label, int value) {
    return row.children([
      label.text.grey600.f12.mk,
      value.toString().text.grey600.f12.bold.mk,
    ]);
  }

  Widget _buildReadingTime(int characters) {
    // 假设阅读速度为每分钟500字
    final minutes = (characters / 500).ceil();
    return row.children([
      '预计阅读'.text.grey600.f12.mk,
      '$minutes分钟'.text.grey600.f12.bold.mk,
    ]);
  }

  TextStats _calculateStats(String text) {
    final lines = text.split('\n');
    final paragraphs = text.split(RegExp(r'\n\s*\n'));
    final words = text.split(RegExp(r'\s+'));
    final headings = RegExp(r'^#{1,6}\s+.+$', multiLine: true).allMatches(text).length;
    final codeBlocks = RegExp(r'```[\s\S]*?```').allMatches(text).length;
    final mathBlocks =
        RegExp(r'\$\$[\s\S]*?\$\$').allMatches(text).length + RegExp(r'\$[^\$\n]+\$').allMatches(text).length;
    final images = RegExp(r'!\[.*?\]\(.*?\)').allMatches(text).length;
    final links = RegExp(r'\[.*?\]\(.*?\)').allMatches(text).length - images;
    final tables = RegExp(r'\|.*?\|.*?\n\|[-\s|]*\|').allMatches(text).length;

    return TextStats(
      characters: text.characters.length,
      words: words.length,
      lines: lines.length,
      paragraphs: paragraphs.length,
      headings: headings,
      codeBlocks: codeBlocks,
      mathBlocks: mathBlocks,
      images: images,
      links: links,
      tables: tables,
    );
  }
}

class TextStats {
  final int characters;
  final int words;
  final int lines;
  final int paragraphs;
  final int headings;
  final int codeBlocks;
  final int mathBlocks;
  final int images;
  final int links;
  final int tables;

  TextStats({
    required this.characters,
    required this.words,
    required this.lines,
    required this.paragraphs,
    required this.headings,
    required this.codeBlocks,
    required this.mathBlocks,
    required this.images,
    required this.links,
    required this.tables,
  });
}
