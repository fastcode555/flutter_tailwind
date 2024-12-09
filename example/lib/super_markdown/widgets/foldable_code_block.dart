import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FoldableCodeBlock extends StatefulWidget {
  final String code;
  final String language;
  final bool showLineNumbers;
  final VoidCallback? onCopy;

  const FoldableCodeBlock({
    required this.code, required this.language, super.key,
    this.showLineNumbers = true,
    this.onCopy,
  });

  @override
  State<FoldableCodeBlock> createState() => _FoldableCodeBlockState();
}

class _FoldableCodeBlockState extends State<FoldableCodeBlock> {
  final Map<int, bool> _foldedRegions = {};
  late final List<CodeRegion> _regions;

  @override
  void initState() {
    super.initState();
    _regions = _parseCodeRegions(widget.code);
  }

  List<CodeRegion> _parseCodeRegions(String code) {
    final regions = <CodeRegion>[];
    final lines = code.split('\n');
    var currentRegion = CodeRegion(
      startLine: 0,
      endLine: 0,
      level: 0,
      content: [],
    );

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final indentLevel = _getIndentLevel(line);

      if (indentLevel > currentRegion.level) {
        // 开始新的区域
        regions.add(currentRegion);
        currentRegion = CodeRegion(
          startLine: i,
          endLine: i,
          level: indentLevel,
          content: [line],
        );
      } else if (indentLevel < currentRegion.level) {
        // 结束当前区域
        currentRegion.endLine = i - 1;
        regions.add(currentRegion);
        currentRegion = CodeRegion(
          startLine: i,
          endLine: i,
          level: indentLevel,
          content: [line],
        );
      } else {
        // 继续当前区域
        currentRegion.content.add(line);
        currentRegion.endLine = i;
      }
    }

    regions.add(currentRegion);
    return regions;
  }

  int _getIndentLevel(String line) {
    final match = RegExp(r'^\s*').firstMatch(line);
    return match?.group(0)?.length ?? 0;
  }

  void _toggleFold(int lineNumber) {
    setState(() {
      final region = _regions.firstWhere(
        (r) => r.startLine <= lineNumber && r.endLine >= lineNumber,
        orElse: () => _regions.first,
      );
      _foldedRegions[region.startLine] = !(_foldedRegions[region.startLine] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return container.grey900.rounded8.p16.cardShadow.child(
      column.children([
        // 头部工具栏
        row.spaceBetween.children([
          // 语言标签
          container.grey800.rounded4.ph8.pv4.child(
            widget.language.text.grey400.f12.mk,
          ),
          // 工具按钮
          row.children([
            // 全部展开/折叠按钮
            IconButton(
              icon: Icons.unfold_more.icon.grey400.s16.mk,
              tooltip: '全部展开',
              onPressed: () {
                setState(_foldedRegions.clear);
              },
            ),
            IconButton(
              icon: Icons.unfold_less.icon.grey400.s16.mk,
              tooltip: '全部折叠',
              onPressed: () {
                setState(() {
                  for (final region in _regions) {
                    if (region.content.length > 1) {
                      _foldedRegions[region.startLine] = true;
                    }
                  }
                });
              },
            ),
            // 复制按钮
            IconButton(
              icon: Icons.content_copy.icon.grey400.s16.mk,
              tooltip: '复制代码',
              onPressed: () {
                widget.onCopy?.call();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('代码已复制到剪贴板')),
                );
              },
            ),
          ]),
        ]),

        h16,

        // 代码区域
        Expanded(
          child: row.children([
            // 行号和折叠指示器
            if (widget.showLineNumbers)
              container.grey800.rounded4.p8.child(
                column.crossStart.children(
                  List.generate(
                    _getVisibleLines().length,
                    (index) {
                      final lineNumber = _getVisibleLines()[index].lineNumber;
                      final hasSubRegion = _hasSubRegion(lineNumber);
                      final isFolded = _foldedRegions[lineNumber] ?? false;

                      return container.h24.child(
                        row.children([
                          if (hasSubRegion)
                            IconButton(
                              icon: (isFolded
                                      ? Icons.chevron_right
                                      : Icons.expand_more)
                                  .icon.grey400.s12.mk,
                              onPressed: () => _toggleFold(lineNumber),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                            )
                          else
                            w16,
                          '$lineNumber'.text.grey400.f12.mk,
                        ]),
                      );
                    },
                  ),
                ),
              ),

            w8,

            // 代码内容
            Expanded(
              child: SingleChildScrollView(
                child: HighlightView(
                  _getVisibleCode(),
                  language: widget.language,
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

  List<VisibleLine> _getVisibleLines() {
    final visibleLines = <VisibleLine>[];
    var displayLineNumber = 0;

    for (final region in _regions) {
      if (_isRegionVisible(region)) {
        for (var i = 0; i < region.content.length; i++) {
          if (!_isLineFolded(region.startLine + i)) {
            visibleLines.add(VisibleLine(
              lineNumber: region.startLine + i + 1,
              content: region.content[i],
            ));
            displayLineNumber++;
          }
        }
      }
    }

    return visibleLines;
  }

  String _getVisibleCode() {
    return _getVisibleLines().map((l) => l.content).join('\n');
  }

  bool _isRegionVisible(CodeRegion region) {
    for (var i = region.startLine; i <= region.endLine; i++) {
      if (_isLineFolded(i)) return false;
    }
    return true;
  }

  bool _isLineFolded(int lineNumber) {
    for (final region in _regions) {
      if (region.startLine <= lineNumber &&
          region.endLine >= lineNumber &&
          _foldedRegions[region.startLine] == true) {
        return true;
      }
    }
    return false;
  }

  bool _hasSubRegion(int lineNumber) {
    return _regions.any((r) => r.startLine == lineNumber && r.content.length > 1);
  }
}

class CodeRegion {
  final int startLine;
  int endLine;
  final int level;
  final List<String> content;

  CodeRegion({
    required this.startLine,
    required this.endLine,
    required this.level,
    required this.content,
  });
}

class VisibleLine {
  final int lineNumber;
  final String content;

  VisibleLine({
    required this.lineNumber,
    required this.content,
  });
} 