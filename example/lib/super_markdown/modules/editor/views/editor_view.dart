import 'package:example/super_markdown/modules/editor/controllers/editor_controller.dart';
import 'package:example/super_markdown/widgets/editor_area.dart';
import 'package:example/super_markdown/widgets/preview_area.dart';
import 'package:example/super_markdown/widgets/shortcut_wrapper.dart';
import 'package:example/super_markdown/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class EditorView extends GetView<EditorController> {
  const EditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ShortcutWrapper(
      shortcuts: {
        // 文件操作
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): controller.saveFile,
        const SingleActivator(LogicalKeyboardKey.keyZ, control: true): controller.undo,
        const SingleActivator(LogicalKeyboardKey.keyY, control: true): controller.redo,

        // 格式化
        const SingleActivator(LogicalKeyboardKey.keyB, control: true): () => controller.insertFormat('**', '**'),
        const SingleActivator(LogicalKeyboardKey.keyI, control: true): () => controller.insertFormat('*', '*'),
        const SingleActivator(LogicalKeyboardKey.keyK, control: true): controller.insertLink,
      },
      child: Scaffold(
        body: column.children([
          // 工具栏
          const MarkdownToolbar(),

          // 编辑区域和预览区域
          Expanded(
            child: Obx(() {
              if (controller.isFullscreen) {
                // 全屏模式
                return controller.isPreview ? _buildPreviewArea() : _buildEditorArea();
              } else {
                // 分屏模式
                return row.children([
                  // 编辑区域
                  Expanded(child: _buildEditorArea()),

                  // 分隔线
                  container.w1.grey200.mk,

                  // 预览区域
                  Expanded(child: _buildPreviewArea()),
                ]);
              }
            }),
          ),
        ]),
      ),
    );
  }

  Widget _buildEditorArea() {
    return EditorArea(
      controller: controller.controller,
      onChanged: controller.onTextChanged,
      onSave: controller.saveFile,
    );
  }

  Widget _buildPreviewArea() {
    return PreviewArea(
      markdown: controller.previewText,
      scrollController: controller.previewScrollController,
    );
  }
}
