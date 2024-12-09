import 'package:example/super_markdown/core/services/shortcut_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ShortcutSettingsController extends GetxController {
  final _shortcutService = Get.find<ShortcutService>();

  // 当前正在录制的快捷键
  final RxString recordingShortcut = ''.obs;

  // 已按下的按键
  final RxSet<LogicalKeyboardKey> recordingKeys = <LogicalKeyboardKey>{}.obs;

  // 是否正在录制
  final RxBool isRecording = false.obs;

  // 获取所有快捷键
  Map<String, ShortcutBinding> get shortcuts => _shortcutService.shortcuts;

  // 重置为默认设置
  Future<void> resetToDefault() async {
    try {
      await _shortcutService.resetShortcuts();
      Get.snackbar(
        '成功',
        '已重置为默认快捷键',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '重置失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // 获取快捷键显示文本
  String getShortcutText(Set<LogicalKeyboardKey> keySet) {
    final keys = keySet.map((key) {
      if (key == LogicalKeyboardKey.control) return 'Ctrl';
      if (key == LogicalKeyboardKey.shift) return 'Shift';
      if (key == LogicalKeyboardKey.alt) return 'Alt';
      if (key == LogicalKeyboardKey.meta) return 'Meta';
      return key.keyLabel.toUpperCase();
    }).toList();
    
    return keys.join(' + ');
  }

  // 获取录制状态显示文本
  String getRecordingText() {
    if (!isRecording.value) return '点击开始录制';
    if (recordingKeys.isEmpty) return '请按下快捷键...';
    return getShortcutText(recordingKeys);
  }

  // 开始录制
  void startRecording(String shortcutKey) {
    recordingShortcut.value = shortcutKey;
    recordingKeys.clear();
    isRecording.value = true;
  }

  // 停止录制
  void stopRecording() {
    recordingShortcut.value = '';
    recordingKeys.clear();
    isRecording.value = false;
  }

  // 处理按键事件
  void handleKeyEvent(KeyEvent event) {
    if (!isRecording.value) return;

    if (event is KeyDownEvent) {
      // 添加按键
      recordingKeys.add(event.logicalKey);
    } else if (event is KeyUpEvent) {
      // 移除按键
      recordingKeys.remove(event.logicalKey);
      
      // 检查是否所有修饰键都已释放
      final hasModifierKey = recordingKeys.any((key) => 
        key == LogicalKeyboardKey.control ||
        key == LogicalKeyboardKey.shift ||
        key == LogicalKeyboardKey.alt ||
        key == LogicalKeyboardKey.meta
      );
      
      // 如果没有修饰键且有其他按键，则保存快捷键
      if (!hasModifierKey && recordingKeys.isNotEmpty) {
        saveShortcut();
      }
    }
  }

  // 保存快捷键
  Future<void> saveShortcut() async {
    if (recordingKeys.isEmpty) return;

    try {
      // 检查冲突
      final conflicts = _shortcutService.checkConflicts(recordingKeys);
      if (conflicts.isNotEmpty) {
        Get.dialog(
          AlertDialog(
            title: const Text('快捷键冲突'),
            content: Text('该快捷键已被"${conflicts.first.label}"使用'),
            actions: [
              TextButton(
                onPressed: Get.back,
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () async {
                  Get.back();
                  await _updateShortcut();
                },
                child: const Text('覆盖'),
              ),
            ],
          ),
        );
        return;
      }

      await _updateShortcut();
    } catch (e) {
      Get.snackbar(
        '错误',
        '保存失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      stopRecording();
    }
  }

  // 更新快捷键
  Future<void> _updateShortcut() async {
    await _shortcutService.updateShortcut(
      recordingShortcut.value,
      recordingKeys.toSet(),
    );
    Get.snackbar(
      '成功',
      '快捷键已更新',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // 清除快捷键
  Future<void> clearShortcut(String key) async {
    try {
      await _shortcutService.removeShortcut(key);
      Get.snackbar(
        '成功',
        '快捷键已清除',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '清除失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    stopRecording();
    super.onClose();
  }
}
