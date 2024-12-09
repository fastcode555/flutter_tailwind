import 'package:example/super_markdown/core/services/editor_service.dart';
import 'package:example/super_markdown/core/services/markdown_service.dart';
import 'package:example/super_markdown/widgets/table_creator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditorController extends GetxController {
  final controller = TextEditingController();
  final EditorService _editorService = Get.find();
  final MarkdownService _markdownService = Get.find();

  // 编辑器内容
  final RxString _content = ''.obs;

  String get content => _content.value;

  String get previewText => _markdownService.parseMarkdown(_content.value);

  // 预览区域滚动控制器
  final ScrollController previewScrollController = ScrollController();

  // 处理文本变化
  void onTextChanged(String text) {
    _content.value = text;
    _editorService.setContent(text);
    if (controller.text != text) {
      controller.text = text;
    }
  }

  // 保存文件
  void saveFile() {
    _editorService.saveFile();
  }

  // 插入文本
  void insertText(String text) {
    _editorService.insertText(text);
    onTextChanged(_editorService.content);
  }

  // 插入格式化文本
  void insertFormat(String prefix, String suffix) {
    final selection = _editorService.selection;
    final text = _content.value;
    final newText = text.replaceRange(
      selection.start,
      selection.end,
      '$prefix${text.substring(selection.start, selection.end)}$suffix',
    );
    onTextChanged(newText);
  }

  // 插入标题
  void insertHeader(int level) {
    final prefix = '${'#' * level} ';
    insertAtCurrentLine(prefix);
  }

  // 插入列表
  void insertList(String marker) {
    insertAtCurrentLine(marker);
  }

  // 在当前行插入文本
  void insertAtCurrentLine(String text) {
    final selection = _editorService.selection;
    final currentText = _content.value;

    // 找到当前行的开始位置
    var lineStart = selection.start;
    while (lineStart > 0 && currentText[lineStart - 1] != '\n') {
      lineStart--;
    }

    // 插入文本
    final newText = currentText.replaceRange(lineStart, lineStart, text);
    onTextChanged(newText);
  }

  // 插入链接
  void insertLink() {
    insertFormat('[链接文字](', ')');
  }

  // 插入图片
  void insertImage() {
    insertFormat('![图片描述](', ')');
  }

  // 插入表格
  void insertTable() {
    Get.dialog(
      TableCreatorDialog(
        onCreated: insertText,
      ),
    );
  }

  // 插入代码块
  void insertCodeBlock({String? language}) {
    final text = _editorService.content;
    final selection = _editorService.selection;
    final before = text.substring(0, selection.baseOffset);
    final after = text.substring(selection.extentOffset);

    // 构建代码块
    final codeBlock = '''
```${language ?? ''}
${selection.textInside(text)}
```
''';

    // 插入代码块
    _editorService.setContent(before + codeBlock + after);

    // 更新光标位置到代码块内部
    final newOffset = before.length + codeBlock.indexOf('\n') + 1;
    _editorService.setSelection(TextSelection.collapsed(offset: newOffset));

    // 通知更新
    update();
  }

  // 添加一个辅助方法来显示语言选择对话框
  Future<void> showLanguageDialog(BuildContext context) async {
    final languages = [
      'dart',
      'javascript',
      'python',
      'java',
      'cpp',
      'csharp',
      'html',
      'css',
      'json',
      'yaml',
      'markdown',
      'bash',
      'sql',
    ];

    final language = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择编程语言'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: languages.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(languages[index]),
              onTap: () => Navigator.pop(context, languages[index]),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );

    if (language != null) {
      insertCodeBlock(language: language);
    }
  }

  // 添加一个方法来处理工具栏的代码块按钮点击
  void onCodeBlockButtonPressed(BuildContext context) {
    showLanguageDialog(context);
  }

  // 切换预览模式
  final RxBool _isPreview = false.obs;

  bool get isPreview => _isPreview.value;

  void togglePreview() {
    _isPreview.value = !_isPreview.value;
  }

  // 切换全屏模式
  final RxBool _isFullscreen = false.obs;

  bool get isFullscreen => _isFullscreen.value;

  void toggleFullscreen() {
    _isFullscreen.value = !_isFullscreen.value;
  }

  // 撤销
  void undo() {
    _editorService.undo();
  }

  // 重做
  void redo() {
    _editorService.redo();
  }

  // 撤销/重做状态
  bool get canUndo => _editorService.canUndo;

  bool get canRedo => _editorService.canRedo;

  // 切换粗体
  void toggleBold() {
    final selection = _editorService.selection;
    if (!selection.isValid) return;

    final text = _editorService.content;
    final selectedText = text.substring(selection.start, selection.end);

    // 检查是否已经是粗体
    final isBold = selectedText.startsWith('**') && selectedText.endsWith('**');

    if (isBold) {
      // 移除粗体标记
      final newText = selectedText.substring(2, selectedText.length - 2);
      _editorService.insertText(newText);
    } else {
      // 添加粗体标记
      _editorService.insertText('**$selectedText**');
    }
  }

  // 切换斜体
  void toggleItalic() {
    final selection = _editorService.selection;
    if (!selection.isValid) return;

    final text = _editorService.content;
    final selectedText = text.substring(selection.start, selection.end);

    // 检查是否已经是斜体
    final isItalic = selectedText.startsWith('*') && selectedText.endsWith('*') && !selectedText.startsWith('**');

    if (isItalic) {
      // 移除斜体标记
      final newText = selectedText.substring(1, selectedText.length - 1);
      _editorService.insertText(newText);
    } else {
      // 添加斜体标记
      _editorService.insertText('*$selectedText*');
    }
  }

  // 显示查找对话框
  void showFindDialog() {
    final controller = TextEditingController();
    final foundPositions = <int>[].obs;
    final currentIndex = 0.obs;

    Get.dialog(
      AlertDialog(
        title: const Text('查找'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 搜索输入框
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: '查找内容',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  foundPositions.clear();
                  return;
                }

                // 查找所有匹配位置
                final text = _editorService.content;
                final matches = value.allMatches(text);
                foundPositions.value = matches.map((m) => m.start).toList();
              },
            ),

            const SizedBox(height: 16),

            // 匹配信息
            Obx(() => Text(
                  foundPositions.isEmpty
                      ? '未找到匹配'
                      : '找到 ${foundPositions.length} 处匹配 (${currentIndex.value + 1}/${foundPositions.length})',
                )),
          ],
        ),
        actions: [
          // 上一个
          TextButton(
            onPressed: () {
              if (foundPositions.isNotEmpty) {
                currentIndex.value = (currentIndex.value - 1) % foundPositions.length;
                _selectMatch(foundPositions[currentIndex.value], controller.text.length);
              }
            },
            child: const Text('上一个'),
          ),

          // 下一个
          TextButton(
            onPressed: () {
              if (foundPositions.isNotEmpty) {
                currentIndex.value = (currentIndex.value + 1) % foundPositions.length;
                _selectMatch(foundPositions[currentIndex.value], controller.text.length);
              }
            },
            child: const Text('下一个'),
          ),

          // 关闭
          TextButton(
            onPressed: Get.back,
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  // 显示替换对话框
  void showReplaceDialog() {
    final findController = TextEditingController();
    final replaceController = TextEditingController();
    final foundPositions = <int>[].obs;
    final currentIndex = 0.obs;

    Get.dialog(
      AlertDialog(
        title: const Text('替换'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 查找输入框
            TextField(
              controller: findController,
              decoration: const InputDecoration(
                labelText: '查找内容',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  foundPositions.clear();
                  return;
                }

                // 查找所有匹配位置
                final text = _editorService.content;
                final matches = value.allMatches(text);
                foundPositions.value = matches.map((m) => m.start).toList();
              },
            ),

            const SizedBox(height: 16),

            // 替换输入框
            TextField(
              controller: replaceController,
              decoration: const InputDecoration(
                labelText: '替换为',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // 匹配信息
            Obx(() => Text(
                  foundPositions.isEmpty
                      ? '未找到匹配'
                      : '找到 ${foundPositions.length} 处匹配 (${currentIndex.value + 1}/${foundPositions.length})',
                )),
          ],
        ),
        actions: [
          // 替换当前
          TextButton(
            onPressed: () {
              if (foundPositions.isNotEmpty) {
                final start = foundPositions[currentIndex.value];
                final end = start + findController.text.length;
                _editorService.setSelection(TextSelection(
                  baseOffset: start,
                  extentOffset: end,
                ));
                _editorService.insertText(replaceController.text);

                // 更新匹配位置
                final text = _editorService.content;
                final matches = findController.text.allMatches(text);
                foundPositions.value = matches.map((m) => m.start).toList();
              }
            },
            child: const Text('替换'),
          ),

          // 替换全部
          TextButton(
            onPressed: () {
              if (foundPositions.isNotEmpty) {
                final text = _editorService.content;
                final newText = text.replaceAll(
                  findController.text,
                  replaceController.text,
                );
                _editorService.setContent(newText);
                Get.back();
              }
            },
            child: const Text('全部替换'),
          ),

          // 关闭
          TextButton(
            onPressed: Get.back,
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  // 选中匹配文本
  void _selectMatch(int start, int length) {
    _editorService.setSelection(TextSelection(
      baseOffset: start,
      extentOffset: start + length,
    ));
  }

  @override
  void onClose() {
    previewScrollController.dispose();
    super.onClose();
  }
}
