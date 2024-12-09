import 'package:example/super_markdown/core/services/editor_service.dart';
import 'package:example/super_markdown/core/services/math_calculator_service.dart';
import 'package:example/super_markdown/widgets/auto_complete_overlay.dart';
import 'package:example/super_markdown/widgets/calculator_history_viewer.dart';
import 'package:example/super_markdown/widgets/unit_conversion_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class EditorArea extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback onSave;
  final TextEditingController controller;

  const EditorArea({
    required this.onChanged,
    required this.onSave,
    required this.controller,
    super.key,
  });

  @override
  State<EditorArea> createState() => _EditorAreaState();
}

class _EditorAreaState extends State<EditorArea> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final EditorService _editorService = Get.find();

  // 自动补全状态
  final RxBool _showSuggestions = false.obs;
  final RxList<String> _suggestions = <String>[].obs;
  final Rx<Offset> _suggestionPosition = Offset.zero.obs;

  // 表达式历史记录
  final RxList<String> _history = <String>[].obs;
  int _historyIndex = -1;

  // 显示历史记录
  final RxBool _showHistory = false.obs;

  // 显示单位转换提示
  final RxBool _showUnitHelper = false.obs;
  final RxString _fromUnit = ''.obs;
  final RxString _toUnit = ''.obs;

  // 添加当前选中的建议索引
  final RxInt _selectedSuggestionIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller..addListener(_handleTextChange);
    _focusNode = FocusNode();
  }

  void _handleTextChange() {
    widget.onChanged(_controller.text);
    _editorService.setSelection(_controller.selection);
    _updateSuggestions();
    _handleUnitConversion(_controller.text);
  }

  void _updateSuggestions() {
    final text = _controller.text;
    final selection = _controller.selection;

    if (selection.isValid && selection.isCollapsed) {
      final beforeCursor = text.substring(0, selection.start);
      final match = RegExp(r'[a-zA-Z0-9_]*$').firstMatch(beforeCursor);

      if (match != null && match.group(0)!.isNotEmpty) {
        final prefix = match.group(0)!.toLowerCase();
        _suggestions.value = _getAllSuggestions().where((s) => s.toLowerCase().startsWith(prefix)).toList();

        if (_suggestions.isNotEmpty) {
          _showSuggestions.value = true;
          _selectedSuggestionIndex.value = 0; // 重置选中索引
          _updateSuggestionPosition(selection.baseOffset - prefix.length);
          return;
        }
      }
    }

    _showSuggestions.value = false;
  }

  void _updateSuggestionPosition(int offset) {
    // 获取文本位置
    final renderObject = context.findRenderObject()! as RenderBox;
    final textPainter = TextPainter(
      text: TextSpan(
        text: _controller.text.substring(0, offset),
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    // 计算光标位置
    final cursorOffset = textPainter.getOffsetForCaret(
      TextPosition(offset: offset),
      Rect.zero,
    );

    // 转换为全局位置
    final globalPosition = renderObject.localToGlobal(cursorOffset);

    // 设置建议框位置（在光标下方）
    _suggestionPosition.value = Offset(
      globalPosition.dx,
      globalPosition.dy - 30, // 光标高度
    );
  }

  void _insertSuggestion(String suggestion) {
    final text = _controller.text;
    final selection = _controller.selection;

    // 找到当前单词的开始位置
    var start = selection.baseOffset;
    while (start > 0 && RegExp('[a-zA-Z0-9_]').hasMatch(text[start - 1])) {
      start--;
    }

    // 插入建议文本
    final newText = text.replaceRange(start, selection.baseOffset, suggestion);

    // 更新文本和光标位置
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: start + suggestion.length,
      ),
    );
    // 如果是函数，添加括号
    if (_isFunction(suggestion)) {
      _insertText('()');
      // 将光标移动到括号中间
      _controller.selection = TextSelection.collapsed(
        offset: _controller.selection.baseOffset - 1,
      );
    }
  }

  bool _isFunction(String suggestion) {
    return AutoCompleteOverlay.functions.contains(suggestion);
  }

  void _insertText(String text) {
    final currentText = _controller.text;
    final selection = _controller.selection;
    final newText = currentText.replaceRange(
      selection.baseOffset,
      selection.extentOffset,
      text,
    );

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + text.length,
      ),
    );
  }

  List<String> _getAllSuggestions() {
    final calculator = Get.find<MathCalculatorService>();
    return [
      ...calculator.supportedFunctions,
      ...calculator.variables.keys,
      ...calculator.supportedUnits.values.expand((units) => units),
    ];
  }

  void _navigateHistory(bool up) {
    if (_history.isEmpty) return;

    if (up && _historyIndex < _history.length - 1) {
      _historyIndex++;
    } else if (!up && _historyIndex > 0) {
      _historyIndex--;
    } else if (!up && _historyIndex == 0) {
      _historyIndex = -1;
      _controller.text = '';
      return;
    }

    if (_historyIndex >= 0 && _historyIndex < _history.length) {
      _controller.text = _history[_historyIndex];
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }
  }

  void _addToHistory(String expression) {
    if (expression.isNotEmpty) {
      _history.insert(0, expression);
      if (_history.length > 100) {
        _history.removeLast();
      }
      _historyIndex = -1;
    }
  }

  // 处理键盘事件
  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (_showSuggestions.value) {
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowUp:
            // 向上选择，到顶部时循环到底部
            _selectedSuggestionIndex.value = (_selectedSuggestionIndex.value - 1) % _suggestions.length;
            if (_selectedSuggestionIndex.value < 0) {
              _selectedSuggestionIndex.value = _suggestions.length - 1;
            }
            return;
          case LogicalKeyboardKey.arrowDown:
            // 向下选择，到底部时循环到顶部
            _selectedSuggestionIndex.value = (_selectedSuggestionIndex.value + 1) % _suggestions.length;
            return;
          case LogicalKeyboardKey.enter:
            // 插入选中的建议
            if (_suggestions.isNotEmpty) {
              _insertSuggestion(_suggestions[_selectedSuggestionIndex.value]);
            }
            return;
          default:
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return container.white.p16.wFull.hFull.child(
      Stack(
        children: [
          // 编辑器
          row.children([
            // 主编辑区域
            Expanded(
              child: KeyboardListener(
                focusNode: _focusNode,
                onKeyEvent: _handleKeyEvent,
                child: TextField(
                  controller: _controller,
                  // focusNode: _focusNode,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '开始编写...',
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontFamily: 'monospace',
                  ),
                  onChanged: widget.onChanged,
                  onEditingComplete: () {
                    _editorService.setSelection(_controller.selection);
                  },
                ),
              ),
            ),

            // 历史记录面板
            Obx(() => _showHistory.value
                ? sizedBox.h300.child(
                    CalculatorHistoryViewer(
                      history: _history,
                      onSelect: (expr) {
                        _controller.text = expr;
                        _controller.selection = TextSelection.collapsed(
                          offset: expr.length,
                        );
                      },
                      onClear: () {
                        _history.clear();
                        _historyIndex = -1;
                      },
                    ),
                  )
                : const SizedBox()),
          ]),

          // 自动补全提示
          Obx(() => _showSuggestions.value
              ? AutoCompleteOverlay(
                  suggestions: _suggestions,
                  position: _suggestionPosition.value,
                  onSelected: _insertSuggestion,
                  onDismiss: () => _showSuggestions.value = false,
                  selectedIndex: _selectedSuggestionIndex.value,
                )
              : const SizedBox()),

          // 单位转换提示
          Obx(() => _showUnitHelper.value
              ? Positioned(
                  right: 16,
                  bottom: 16,
                  child: UnitConversionHelper(
                    fromUnit: _fromUnit.value,
                    toUnit: _toUnit.value,
                    onClose: () => _showUnitHelper.value = false,
                  ),
                )
              : const SizedBox()),
        ],
      ),
    );
  }

  // 处理单位转换
  void _handleUnitConversion(String text) {
    final match = RegExp(r'(\d+(?:\.\d+)?)\s*([a-zA-Z]+)\s*->\s*([a-zA-Z]+)').firstMatch(text);

    if (match != null) {
      _fromUnit.value = match.group(2)!;
      _toUnit.value = match.group(3)!;
      _showUnitHelper.value = true;
    } else {
      _showUnitHelper.value = false;
    }
  }

  // 插入格式化文本
  void _insertFormat(String prefix, String suffix) {
    final text = _controller.text;
    final selection = _controller.selection;

    if (selection.isValid) {
      final selectedText = text.substring(selection.start, selection.end);
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        '$prefix$selectedText$suffix',
      );

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start + prefix.length + selectedText.length + suffix.length,
        ),
      );
    } else {
      final cursorPosition = selection.baseOffset;
      final newText = text.replaceRange(
        cursorPosition,
        cursorPosition,
        '$prefix$suffix',
      );

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: cursorPosition + prefix.length,
        ),
      );
    }
  }

  // 插入链接
  void _insertLink() {
    final text = _controller.text;
    final selection = _controller.selection;
    var selectedText = '';

    if (selection.isValid) {
      selectedText = text.substring(selection.start, selection.end);
    }

    Get.dialog(
      AlertDialog(
        title: '插入链接'.text.f16.bold.mk,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: '链接文本',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: selectedText),
              onChanged: (value) => selectedText = value,
            ),
            h16,
            TextField(
              decoration: const InputDecoration(
                labelText: 'URL',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (url) {
                _insertText('[$selectedText]($url)');
                Get.back();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: '取消'.text.mk,
          ),
          TextButton(
            onPressed: () {
              _insertText('[$selectedText]()');
              Get.back();
            },
            child: '确定'.text.mk,
          ),
        ],
      ),
    );
  }

  // 插入数学公式
  void _insertMath() {
    final text = _controller.text;
    final selection = _controller.selection;
    var selectedText = '';

    if (selection.isValid) {
      selectedText = text.substring(selection.start, selection.end);
    }

    Get.dialog(
      AlertDialog(
        title: '插入数学公式'.text.f16.bold.mk,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 公式类型选择
            row.spaceBetween.children([
              '公式类型:'.text.f14.mk,
              DropdownButton<bool>(
                value: false,
                items: const [
                  DropdownMenuItem(
                    value: false,
                    child: Text('行内公式'),
                  ),
                  DropdownMenuItem(
                    value: true,
                    child: Text('独立公式'),
                  ),
                ],
                onChanged: (value) {
                  if (value == true) {
                    _insertText('\n\$\$\n$selectedText\n\$\$\n');
                  } else {
                    _insertText('\$$selectedText\$');
                  }
                  Get.back();
                },
              ),
            ]),
            h16,
            // 公式输入框
            TextField(
              decoration: const InputDecoration(
                labelText: '输入公式',
                border: OutlineInputBorder(),
                hintText: 'LaTeX格式',
              ),
              controller: TextEditingController(text: selectedText),
              maxLines: 3,
              onSubmitted: (formula) {
                _insertText('\$$formula\$');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  // 插入标题
  void _insertHeader(int level) {
    final text = _controller.text;
    final selection = _controller.selection;
    final prefix = '${'#' * level} ';

    if (selection.isValid) {
      final selectedText = text.substring(selection.start, selection.end);
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        '$prefix$selectedText',
      );

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start + prefix.length + selectedText.length,
        ),
      );
    } else {
      final cursorPosition = selection.baseOffset;
      final newText = text.replaceRange(
        cursorPosition,
        cursorPosition,
        prefix,
      );

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: cursorPosition + prefix.length,
        ),
      );
    }
  }

  // 插入列表
  void _insertList(String prefix) {
    final text = _controller.text;
    final selection = _controller.selection;

    if (selection.isValid) {
      final selectedText = text.substring(selection.start, selection.end);
      final lines = selectedText.split('\n');
      final newText = lines.map((line) => '$prefix$line').join('\n');

      _controller.value = TextEditingValue(
        text: text.replaceRange(selection.start, selection.end, newText),
        selection: TextSelection.collapsed(
          offset: selection.start + newText.length,
        ),
      );
    } else {
      final cursorPosition = selection.baseOffset;
      _controller.value = TextEditingValue(
        text: text.replaceRange(cursorPosition, cursorPosition, prefix),
        selection: TextSelection.collapsed(
          offset: cursorPosition + prefix.length,
        ),
      );
    }
  }

  // 插入表格
  void _insertTable() {
    Get.dialog(
      AlertDialog(
        title: '插入表格'.text.f16.bold.mk,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 行列输入
            row.children([
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: '行数',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // 保存行数
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: '列数',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // 保存列数
                  },
                ),
              ),
            ]),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: '取消'.text.mk,
          ),
          TextButton(
            onPressed: () {
              // 生成表格
              const rows = 3;
              const cols = 3;
              final header = '|${' Header '.padRight(10) * cols}|\n';
              final separator = '|${' --- '.padRight(10) * cols}|\n';
              final body = List.generate(
                rows - 1,
                (i) => '|${' Cell '.padRight(10) * cols}|\n',
              ).join();
              _insertText('\n$header$separator$body');
              Get.back();
            },
            child: '确定'.text.mk,
          ),
        ],
      ),
    );
  }

  // 插入代码块
  void _insertCodeBlock() {
    Get.dialog(
      AlertDialog(
        title: '插入代码块'.text.f16.bold.mk,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 语言选择
            DropdownButton<String>(
              value: 'dart',
              items: const [
                DropdownMenuItem(value: 'dart', child: Text('Dart')),
                DropdownMenuItem(value: 'javascript', child: Text('JavaScript')),
                DropdownMenuItem(value: 'python', child: Text('Python')),
                DropdownMenuItem(value: 'java', child: Text('Java')),
                DropdownMenuItem(value: 'cpp', child: Text('C++')),
              ],
              onChanged: (language) {
                if (language != null) {
                  _insertText('\n```$language\n\n```\n');
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
