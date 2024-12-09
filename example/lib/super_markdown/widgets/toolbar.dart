import 'package:example/super_markdown/modules/editor/controllers/editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class MarkdownToolbar extends GetView<EditorController> {
  const MarkdownToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return container.white.borderB1.borderGrey200.h48.wFull.child(
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: row.p8.children([
          // 文件操作
          _buildButtonGroup([
            _buildToolButton(
              icon: Icons.save,
              tooltip: '保存 (Ctrl+S)',
              onPressed: controller.saveFile,
            ),
            _buildToolButton(
              icon: Icons.undo,
              tooltip: '撤销 (Ctrl+Z)',
              onPressed: controller.canUndo ? controller.undo : null,
            ),
            _buildToolButton(
              icon: Icons.redo,
              tooltip: '重做 (Ctrl+Y)',
              onPressed: controller.canRedo ? controller.redo : null,
            ),
          ]),

          _buildDivider(),

          // 标题
          _buildDropdownButton(
            '标题',
            ['H1', 'H2', 'H3', 'H4', 'H5', 'H6'],
            (value) => controller.insertHeader(int.parse(value.substring(1))),
          ),

          _buildDivider(),

          // 文本格式化
          _buildButtonGroup([
            _buildToolButton(
              icon: Icons.format_bold,
              tooltip: '粗体 (Ctrl+B)',
              onPressed: () => controller.insertFormat('**', '**'),
            ),
            _buildToolButton(
              icon: Icons.format_italic,
              tooltip: '斜体 (Ctrl+I)',
              onPressed: () => controller.insertFormat('*', '*'),
            ),
            _buildToolButton(
              icon: Icons.format_strikethrough,
              tooltip: '删除线',
              onPressed: () => controller.insertFormat('~~', '~~'),
            ),
          ]),

          _buildDivider(),

          // 列表
          _buildButtonGroup([
            _buildToolButton(
              icon: Icons.format_list_bulleted,
              tooltip: '无序列表',
              onPressed: () => controller.insertList('- '),
            ),
            _buildToolButton(
              icon: Icons.format_list_numbered,
              tooltip: '有序列表',
              onPressed: () => controller.insertList('1. '),
            ),
          ]),

          _buildDivider(),

          // 插入元素
          _buildButtonGroup([
            _buildToolButton(
              icon: Icons.link,
              tooltip: '链接 (Ctrl+K)',
              onPressed: controller.insertLink,
            ),
            _buildToolButton(
              icon: Icons.image,
              tooltip: '图片',
              onPressed: controller.insertImage,
            ),
            _buildToolButton(
              icon: Icons.table_chart,
              tooltip: '创建表格',
              onPressed: controller.insertTable,
            ),
            _buildToolButton(
              icon: Icons.code,
              tooltip: '代码块',
              onPressed: controller.insertCodeBlock,
            ),
          ]),

          _buildDivider(),

          // 视图切换
          _buildButtonGroup([
            Obx(() => _buildToolButton(
                  icon: controller.isPreview ? Icons.edit : Icons.preview,
                  tooltip: controller.isPreview ? '编辑' : '预览',
                  onPressed: controller.togglePreview,
                )),
            Obx(() => _buildToolButton(
                  icon: controller.isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  tooltip: controller.isFullscreen ? '退出全屏' : '全屏',
                  onPressed: controller.toggleFullscreen,
                )),
          ]),
        ]),
      ),
    );
  }

  Widget _buildButtonGroup(List<Widget> children) {
    return row.children(children);
  }

  Widget _buildToolButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback? onPressed,
  }) {
    return IconButton(
      icon: Icon(icon, size: 20),
      tooltip: tooltip,
      onPressed: onPressed,
      color: Colors.grey[700],
      hoverColor: Colors.grey[100],
    );
  }

  Widget _buildDropdownButton(
    String label,
    List<String> items,
    void Function(String) onSelected,
  ) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => items
          .map((item) => PopupMenuItem(
                value: item,
                child: item.text.f14.mk,
              ))
          .toList(),
      onSelected: onSelected,
      child: container.grey100.rounded4.p8.child(
        row.center.children([
          label.text.f14.mk,
          w4,
          Icons.arrow_drop_down.icon.grey600.s20.mk,
        ]),
      ),
    );
  }

  Widget _buildDivider() {
    return container.w1.h24.grey200.mk;
  }
}
