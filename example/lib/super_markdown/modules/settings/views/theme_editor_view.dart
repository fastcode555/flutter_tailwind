import 'package:example/super_markdown/modules/settings/controllers/theme_editor_controller.dart';
import 'package:example/super_markdown/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class ThemeEditorView extends GetView<ThemeEditorController> {
  const ThemeEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '主题编辑器'.text.f20.bold.mk,
        actions: [
          // 保存按钮
          container.blue.rounded8.p12.ph16.m8.center
              .child('保存'.text.white.f14.bold.mk)
              .click(onTap: controller.saveTheme),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 预览区域
          _buildPreviewArea(),
          h16,
          // 颜色设置
          _buildSection('颜色设置', [
            _buildColorSetting('背景色', controller.backgroundColor),
            _buildColorSetting('文本颜色', controller.textColor),
            _buildColorSetting('光标颜色', controller.cursorColor),
            _buildColorSetting('选择颜色', controller.selectionColor),
          ]),
          h16,
          // 语法高亮设置
          _buildSection('语法高亮', [
            _buildColorSetting('注释', controller.commentColor),
            _buildColorSetting('关键字', controller.keywordColor),
            _buildColorSetting('字符串', controller.stringColor),
            _buildColorSetting('数字', controller.numberColor),
            _buildColorSetting('标点符号', controller.punctuationColor),
          ]),
        ],
      ),
    );
  }

  Widget _buildPreviewArea() {
    return container.white.rounded8.p16.cardShadow.child(
      column.crossStart.children([
        '预览'.text.f16.bold.mk,
        h16,
        // 预览内容
        Obx(() => container.color(controller.backgroundColor.value).p16.child(
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: controller.textColor.value,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: '// 这是一段示例代码\n',
                      style: TextStyle(color: controller.commentColor.value),
                    ),
                    TextSpan(
                      text: 'function ',
                      style: TextStyle(color: controller.keywordColor.value),
                    ),
                    TextSpan(
                      text: 'hello',
                      style: TextStyle(color: controller.textColor.value),
                    ),
                    TextSpan(
                      text: '(',
                      style: TextStyle(color: controller.punctuationColor.value),
                    ),
                    TextSpan(
                      text: 'name',
                      style: TextStyle(color: controller.textColor.value),
                    ),
                    TextSpan(
                      text: ') {\n  ',
                      style: TextStyle(color: controller.punctuationColor.value),
                    ),
                    TextSpan(
                      text: 'return ',
                      style: TextStyle(color: controller.keywordColor.value),
                    ),
                    TextSpan(
                      text: '"Hello, "',
                      style: TextStyle(color: controller.stringColor.value),
                    ),
                    TextSpan(
                      text: ' + ',
                      style: TextStyle(color: controller.punctuationColor.value),
                    ),
                    const TextSpan(text: 'name'),
                    TextSpan(
                      text: ';\n}',
                      style: TextStyle(color: controller.punctuationColor.value),
                    ),
                  ],
                ),
              ),
            )),
      ]),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return container.white.rounded8.p16.cardShadow.child(
      column.crossStart.children([
        title.text.f16.bold.mk,
        h16,
        ...children,
      ]),
    );
  }

  Widget _buildColorSetting(String label, Rx<Color> color) {
    return container.mb8.child(
      row.spaceBetween.children([
        label.text.f14.mk,
        Obx(() => container.s32.rounded4.color(color.value).click(onTap: () => _showColorPicker(label, color))),
      ]),
    );
  }

  void _showColorPicker(String label, Rx<Color> color) {
    Get.dialog(
      AlertDialog(
        title: label.text.f16.bold.mk,
        content: container.h300.child(
          // TODO: 实现颜色选择器
          ColorPicker(
            onColorChanged: (value) => color.value = value,
            color: color.value,
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: '取消'.text.mk,
          ),
          TextButton(
            onPressed: Get.back,
            child: '确定'.text.mk,
          ),
        ],
      ),
    );
  }
}
