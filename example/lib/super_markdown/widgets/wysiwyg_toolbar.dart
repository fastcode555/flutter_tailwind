import 'package:example/super_markdown/core/theme/editor_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_tailwind/flutter_tailwind.dart';

class WysiwygToolbar extends StatelessWidget {
  final QuillController controller;
  final ToolbarTheme? theme;

  const WysiwygToolbar({
    required this.controller,
    super.key,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return container.borderB1.borderGrey200.child(
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: row.p8.children([
          // 样式工具
          _buildStyleTools(),
          _buildDivider(),

          // 段落工具
          _buildParagraphTools(),
          _buildDivider(),

          // 插入工具
          _buildInsertTools(),
          _buildDivider(),

          // 表格工具
          _buildTableTools(),
          _buildDivider(),

          // 其他工具
          _buildOtherTools(),
        ]),
      ),
    );
  }

  Widget _buildStyleTools() {
    return row.children([
      // 字���样式
      QuillToolbarToggleStyleButton(
        attribute: Attribute.bold,
        controller: controller,
      ),
      QuillToolbarToggleStyleButton(
        attribute: Attribute.italic,
        controller: controller,
      ),
      // ... 其他样式按钮
    ]);
  }

  Widget _buildParagraphTools() {
    return row.children([
      // 对齐方式
      QuillToolbarToggleStyleButton(
        attribute: Attribute.leftAlignment,
        controller: controller,
      ),
      // ... 其他对齐按钮

      // 列表
      QuillToolbarToggleStyleButton(
        attribute: Attribute.ul,
        controller: controller,
      ),
      // ... 其他列表按钮
    ]);
  }

  Widget _buildInsertTools() {
    return row.children([
      // 插入链接
      QuillToolbarLinkStyleButton(
        controller: controller,
        options: const QuillToolbarLinkStyleButtonOptions(
          tooltip: '插入链接',
          iconData: Icons.insert_link,
        ),
      ),
      // 插入图片
      QuillToolbarLinkStyleButton(
        controller: controller,
        options: const QuillToolbarLinkStyleButtonOptions(
          tooltip: '插入图片',
          iconData: Icons.image,
        ),
      ),
      // 插入表格
      IconButton(
        icon: Icons.table_chart.icon.grey600.s20.mk,
        tooltip: '插入表格',
        onPressed: _insertTable,
      ),

      // 插入代码块
      IconButton(
        icon: Icons.code.icon.grey600.s20.mk,
        tooltip: '插入代码块',
        onPressed: _insertCodeBlock,
      ),
    ]);
  }

  Widget _buildTableTools() {
    return row.children([
      // 表格操作按钮
      IconButton(
        icon: Icons.add_box.icon.grey600.s20.mk,
        tooltip: '插入行',
        onPressed: _insertTableRow,
      ),
      IconButton(
        icon: Icons.add_box_outlined.icon.grey600.s20.mk,
        tooltip: '插入列',
        onPressed: _insertTableColumn,
      ),
      // ... 其他表格操作按钮
    ]);
  }

  Widget _buildOtherTools() {
    return row.children([
      // 撤销/重做
      IconButton(
        icon: Icons.undo.icon.grey600.s20.mk,
        tooltip: '撤销',
        onPressed: controller.undo,
      ),
      IconButton(
        icon: Icons.redo.icon.grey600.s20.mk,
        tooltip: '重做',
        onPressed: controller.redo,
      ),

      // 清除格式
      IconButton(
        icon: Icons.format_clear.icon.grey600.s20.mk,
        tooltip: '清除格式',
        onPressed: _clearFormat,
      ),
    ]);
  }

  Widget _buildDivider() {
    return container.w1.h24.grey200.mk;
  }

  // 工具方法
  void _insertTable() {
    // 实现插入表格逻辑
  }

  void _insertCodeBlock() {
    // 实现插入代码块逻辑
  }

  void _insertTableRow() {
    // 实现插入表格行逻辑
  }

  void _insertTableColumn() {
    // 实现插入表格列逻辑
  }

  void _clearFormat() {
    // 实现清除格式逻辑
  }
}
