import 'package:example/super_markdown/core/services/shortcut_service.dart';
import 'package:example/super_markdown/modules/settings/controllers/shortcut_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class ShortcutSettingsView extends GetView<ShortcutSettingsController> {
  const ShortcutSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '快捷键设置'.text.f20.bold.mk,
        actions: [
          // 重置按钮
          TextButton.icon(
            onPressed: controller.resetToDefault,
            icon: Icons.restore.icon.grey600.s20.mk,
            label: '重置'.text.grey600.f14.mk,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 快捷键列表
          Obx(() => Column(
                children: controller.shortcuts.entries.map((entry) {
                  return _buildShortcutItem(
                    entry.key,
                    entry.value,
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildShortcutItem(String key, ShortcutBinding binding) {
    return container.white.p16.borderB1.borderGrey200.child(
      row.spaceBetween.children([
        // 快捷键信息
        column.crossStart.expanded.children([
          binding.label.text.f16.mk,
          binding.category.text.grey600.f14.mk,
        ]),

        // 快捷键显示和编辑按钮
        row.children([
          // 快捷键显示
          container.grey100.rounded8.p8.ph12.child(
            controller.getShortcutText(binding.keySet).text.f14.mk,
          ),

          w8,

          // 编辑按钮
          IconButton(
            icon: Icons.edit.icon.grey600.s20.mk,
            onPressed: () => _showShortcutEditor(key),
          ),

          // 清除按钮
          IconButton(
            icon: Icons.close.icon.grey600.s20.mk,
            onPressed: () => controller.clearShortcut(key),
          ),
        ]),
      ]),
    );
  }

  void _showShortcutEditor(String shortcutKey) {
    Get.dialog(
      AlertDialog(
        title: '编辑快捷键'.text.f16.bold.mk,
        content: column.crossStart.children([
          // 录制提示
          Obx(() => controller.getRecordingText().text.f14.mk),

          h16,

          // 当前快捷键
          container.grey100.rounded8.p16.w300.center.child(
            Obx(() => controller.getShortcutText(controller.recordingKeys).text.f16.bold.mk),
          ),
        ]),
        actions: [
          // 取消按钮
          TextButton(
            onPressed: () {
              controller.stopRecording();
              Get.back();
            },
            child: '取消'.text.mk,
          ),

          // 确定按钮
          TextButton(
            onPressed: () {
              controller.saveShortcut();
              Get.back();
            },
            child: '确定'.text.mk,
          ),
        ],
      ),
    );

    // 开始录制
    controller.startRecording(shortcutKey);
  }
}
