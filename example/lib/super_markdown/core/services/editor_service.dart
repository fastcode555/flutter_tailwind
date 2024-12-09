import 'dart:async';

import 'package:example/super_markdown/core/services/file_service.dart';
import 'package:example/super_markdown/core/services/math_calculator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/quill_delta.dart';
import 'package:get/get.dart';
import 'package:markdown/markdown.dart' as md;

class EditorService extends GetxService {
  final FileService _fileService = Get.find();
  final MathCalculatorService _calculator = Get.find();
  Timer? _autoSaveTimer;

  // 编辑器内容
  final RxString _content = ''.obs;

  String get content => _content.value;

  // 光标位置
  TextSelection _selection = const TextSelection.collapsed(offset: 0);

  TextSelection get selection => _selection;

  // 撤销/重做栈
  final List<String> _undoStack = [];
  final List<String> _redoStack = [];

  // 是否可以撤销/重做
  bool get canUndo => _undoStack.isNotEmpty;

  bool get canRedo => _redoStack.isNotEmpty;

  // 将Markdown文本转换为Delta
  Delta parseMarkdown(String markdown) {
    final document = Document();
    final parser = md.Document(
      extensionSet: md.ExtensionSet.gitHubWeb,
      encodeHtml: false,
    );
    final nodes = parser.parse(markdown);

    // 遍历Markdown节点，转换为Delta操作
    for (final node in nodes) {
      _parseNode(node, document);
    }

    return document.toDelta();
  }

  // 将Delta转换为Markdown文本
  String toMarkdown(Delta delta) {
    final buffer = StringBuffer();
    var currentStyle = const Style();

    for (final op in delta.operations) {
      final data = op.data;
      final attributes = op.attributes ?? {};

      if (data is String) {
        // 处理文本
        if (attributes['bold'] == true) {
          buffer.write('**${_escapeMarkdown(data)}**');
        } else if (attributes['italic'] == true) {
          buffer.write('_${_escapeMarkdown(data)}_');
        } else if (attributes['code'] == true) {
          buffer.write('`${_escapeMarkdown(data)}`');
        } else if (attributes['link'] != null) {
          buffer.write('[${_escapeMarkdown(data)}](${attributes['link']})');
        } else {
          buffer.write(_escapeMarkdown(data));
        }
      } else if (data == '\n') {
        // 处理换行
        if (attributes['header'] != null) {
          final level = attributes['header'] as int;
          buffer.write('${'#' * level} ');
        } else if (attributes['list'] != null) {
          if (attributes['list'] == 'bullet') {
            buffer.write('- ');
          } else if (attributes['list'] == 'ordered') {
            buffer.write('1. ');
          }
        } else if (attributes['blockquote'] == true) {
          buffer.write('> ');
        }
        buffer.write('\n');
      }
    }

    return buffer.toString();
  }

  // 解析Markdown节点
  void _parseNode(md.Node node, Document document) {
    if (node is md.Element) {
      switch (node.tag) {
        case 'h1':
        case 'h2':
        case 'h3':
        case 'h4':
        case 'h5':
        case 'h6':
          final level = int.parse(node.tag.substring(1));
          document.format(document.length, 0, HeaderAttribute(level: level));
        case 'p':
          document.format(document.length, 0, Attribute.header);
        case 'strong':
          document.format(document.length, node.textContent.length, Attribute.bold);
        case 'em':
          document.format(document.length, node.textContent.length, Attribute.italic);
        case 'code':
          document.format(document.length, node.textContent.length, Attribute.codeBlock);
        case 'a':
          document.format(
            document.length,
            node.textContent.length,
            LinkAttribute(node.attributes['href'] ?? ''),
          );
        case 'blockquote':
          document.format(document.length, 0, Attribute.blockQuote);
        case 'ul':
          document.format(document.length, 0, Attribute.ul);
        case 'ol':
          document.format(document.length, 0, Attribute.ol);
      }

      for (final child in node.children!) {
        _parseNode(child, document);
      }
    } else if (node is md.Text) {
      document.insert(document.length, node.text);
    }
  }

  // 转义Markdown特殊字符
  String _escapeMarkdown(String text) {
    return text.replaceAllMapped(
      RegExp(r'[\\`*_{}[\]()#+\-.!]'),
      (match) => '\\${match.group(0)}',
    );
  }

  @override
  void onInit() {
    super.onInit();
    _loadAutoSavedContent();
    startAutoSave();
  }

  // 设置选择区域
  void setSelection(TextSelection selection) {
    _selection = selection;
  }

  // 设置内容
  void setContent(String text) {
    if (text != _content.value) {
      _undoStack.add(_content.value);
      _redoStack.clear();
      _content.value = text;
    }
  }

  // 撤销
  void undo() {
    if (canUndo) {
      _redoStack.add(_content.value);
      _content.value = _undoStack.removeLast();
    }
  }

  // 重做
  void redo() {
    if (canRedo) {
      _undoStack.add(_content.value);
      _content.value = _redoStack.removeLast();
    }
  }

  // 插入文本
  void insertText(String text) {
    final currentText = _content.value;
    final before = currentText.substring(0, _selection.baseOffset);
    final after = currentText.substring(_selection.extentOffset);

    _content.value = before + text + after;

    // 更新光标位置
    final newOffset = before.length + text.length;
    _selection = TextSelection.collapsed(offset: newOffset);
  }

  // 加载自动保存的内容
  void _loadAutoSavedContent() {
    final savedContent = _fileService.getAutoSavedContent();
    if (savedContent != null) {
      _content.value = savedContent;
    }
  }

  // 保存文件
  Future<void> saveFile() async {
    try {
      await _fileService.saveFile(_content.value);
      Get.snackbar(
        '成功',
        '文件已保存',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '保存失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // 自动保存
  void startAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _fileService.autoSave(_content.value);
    });
  }

  // 停止自动保存
  void stopAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = null;
  }

  // 处理数学表达式
  void handleMathExpression(String text) {
    // 获取当前行
    final lines = text.split('\n');
    var currentLine = '';
    var lineStart = 0;
    var lineEnd = 0;

    for (var i = 0; i < lines.length; i++) {
      lineStart = lineEnd;
      lineEnd += lines[i].length + 1;

      if (_selection.end <= lineEnd) {
        currentLine = lines[i];
        break;
      }
    }

    // 计算结果
    final result = _calculator.calculate(currentLine);
    if (result != null) {
      // 替换当前行
      final newText = text.replaceRange(lineStart, lineEnd - 1, result);
      setContent(newText);
    }
  }

  @override
  void onClose() {
    stopAutoSave();
    super.onClose();
  }
}

class LinkAttribute extends Attribute<String> {
  static const String _key = 'link';

  const LinkAttribute(String value) : super(_key, AttributeScope.inline, value);
}
