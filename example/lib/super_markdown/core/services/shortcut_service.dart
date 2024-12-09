import 'dart:convert';

import 'package:example/super_markdown/core/controllers/shortcut_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShortcutService extends GetxService {
  static const String kShortcuts = 'shortcuts';
  late final SharedPreferences _prefs;
  final _shortcuts = <String, ShortcutBinding>{}.obs;

  // 默认快捷键
  static final Map<String, ShortcutBinding> defaultShortcuts = {
    'save': ShortcutBinding(
      key: 'save',
      label: '保存',
      keySet: {LogicalKeyboardKey.control, LogicalKeyboardKey.keyS},
      category: '文件',
    ),
    'undo': ShortcutBinding(
      key: 'undo',
      label: '撤销',
      keySet: {LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ},
      category: '编辑',
    ),
    'redo': ShortcutBinding(
      key: 'redo',
      label: '重做',
      keySet: {LogicalKeyboardKey.control, LogicalKeyboardKey.keyY},
      category: '编辑',
    ),
    'bold': ShortcutBinding(
      key: 'bold',
      label: '粗体',
      keySet: {LogicalKeyboardKey.control, LogicalKeyboardKey.keyB},
      category: '格式',
    ),
    'italic': ShortcutBinding(
      key: 'italic',
      label: '斜体',
      keySet: {LogicalKeyboardKey.control, LogicalKeyboardKey.keyI},
      category: '格式',
    ),
    'find': ShortcutBinding(
      key: 'find',
      label: '查找',
      keySet: {LogicalKeyboardKey.control, LogicalKeyboardKey.keyF},
      category: '编辑',
    ),
    'replace': ShortcutBinding(
      key: 'replace',
      label: '替换',
      keySet: {LogicalKeyboardKey.control, LogicalKeyboardKey.keyH},
      category: '编辑',
    ),
    'preview': ShortcutBinding(
      key: 'preview',
      label: '预览',
      keySet: {LogicalKeyboardKey.control, LogicalKeyboardKey.keyP},
      category: '视图',
    ),
    'fullscreen': ShortcutBinding(
      key: 'fullscreen',
      label: '全屏',
      keySet: {LogicalKeyboardKey.f11},
      category: '视图',
    ),
  };

  @override
  Future<void> onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    await _loadShortcuts();
  }

  // 加载快捷键
  Future<void> _loadShortcuts() async {
    final json = _prefs.getString(kShortcuts);
    if (json != null) {
      final map = jsonDecode(json) as Map<String, dynamic>;
      _shortcuts.value = map.map(
        (key, value) => MapEntry(key, ShortcutBinding.fromJson(value)),
      );
    } else {
      _shortcuts.value = Map.from(defaultShortcuts);
    }
  }

  // 保存快捷键
  Future<void> _saveShortcuts() async {
    final map = _shortcuts.map(
      (key, value) => MapEntry(key, value.toJson()),
    );
    await _prefs.setString(kShortcuts, jsonEncode(map));
  }

  // 更新快捷键
  Future<void> updateShortcut(String key, Set<LogicalKeyboardKey> keySet) async {
    if (!_shortcuts.containsKey(key)) return;
    
    // 保存原始快捷键，以便恢复
    final originalBinding = _shortcuts[key];
    
    try {
      _shortcuts[key] = _shortcuts[key]!.copyWith(keySet: keySet);
      await _saveShortcuts();
    } catch (e) {
      // 恢复原始快捷键
      _shortcuts[key] = originalBinding!;
      rethrow;
    }
  }

  // 重置快捷键
  Future<void> resetShortcuts() async {
    try {
      _shortcuts.clear();
      _shortcuts.addAll(defaultShortcuts);
      await _saveShortcuts();
    } catch (e) {
      // 如果重置失败，尝试重新加载快捷键
      await _loadShortcuts();
      rethrow;
    }
  }

  // 检查快捷键冲突
  List<ShortcutBinding> checkConflicts(Set<LogicalKeyboardKey> keySet) {
    final conflicts = <ShortcutBinding>[];
    
    for (final binding in _shortcuts.values) {
      if (_isKeySetsEqual(binding.keySet, keySet)) {
        conflicts.add(binding);
      }
    }
    
    return conflicts;
  }

  // 移除快捷键
  Future<void> removeShortcut(String key) async {
    if (!_shortcuts.containsKey(key)) return;
    
    // 保存原始快捷键，以便恢复
    final originalBinding = _shortcuts[key];
    
    try {
      _shortcuts.remove(key);
      await _saveShortcuts();
    } catch (e) {
      // 恢复原始快捷键
      if (originalBinding != null) {
        _shortcuts[key] = originalBinding;
      }
      rethrow;
    }
  }

  // 比较两个快捷键集合是否相等
  bool _isKeySetsEqual(Set<LogicalKeyboardKey> a, Set<LogicalKeyboardKey> b) {
    if (a.length != b.length) return false;
    return a.every(b.contains);
  }

  // 获取快捷键绑定
  ShortcutBinding? getBinding(String key) => _shortcuts[key];

  // 获取所有快捷键
  Map<String, ShortcutBinding> get shortcuts => Map.unmodifiable(_shortcuts);

  // 获取按类别分组的快捷键
  Map<String, List<ShortcutBinding>> get shortcutsByCategory {
    final map = <String, List<ShortcutBinding>>{};
    for (final binding in _shortcuts.values) {
      map.putIfAbsent(binding.category, () => []).add(binding);
    }
    return map;
  }

  // 处理快捷键事件
  bool handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return false;

    // 收集当前按下的键
    final pressedKeys = <LogicalKeyboardKey>{};
    
    // 检查修饰键
    if (HardwareKeyboard.instance.isControlPressed) {
      pressedKeys.add(LogicalKeyboardKey.control);
    }
    if (HardwareKeyboard.instance.isShiftPressed) {
      pressedKeys.add(LogicalKeyboardKey.shift);
    }
    if (HardwareKeyboard.instance.isAltPressed) {
      pressedKeys.add(LogicalKeyboardKey.alt);
    }
    
    // 添加当前按下的键
    pressedKeys.add(event.logicalKey);

    // 查找匹配的快捷键
    for (final binding in _shortcuts.values) {
      if (_isKeySetsEqual(binding.keySet, pressedKeys)) {
        // 触发快捷键动作
        Get.find<ShortcutController>().handleShortcut(binding.key);
        return true;
      }
    }

    return false;
  }
}

// 快捷键绑定
class ShortcutBinding {
  final String key;
  final String label;
  final Set<LogicalKeyboardKey> keySet;
  final String category;

  const ShortcutBinding({
    required this.key,
    required this.label,
    required this.keySet,
    required this.category,
  });

  ShortcutBinding copyWith({
    String? key,
    String? label,
    Set<LogicalKeyboardKey>? keySet,
    String? category,
  }) {
    return ShortcutBinding(
      key: key ?? this.key,
      label: label ?? this.label,
      keySet: keySet ?? this.keySet,
      category: category ?? this.category,
    );
  }

  // 格式化快捷键显示
  String get keyDisplay {
    final keys = keySet.map((key) {
      if (key == LogicalKeyboardKey.control) return 'Ctrl';
      if (key == LogicalKeyboardKey.shift) return 'Shift';
      if (key == LogicalKeyboardKey.alt) return 'Alt';
      return key.keyLabel.toUpperCase();
    }).toList();
    return keys.join(' + ');
  }

  factory ShortcutBinding.fromJson(Map<String, dynamic> json) {
    return ShortcutBinding(
      key: json['key'],
      label: json['label'],
      keySet: (json['keySet'] as List)
          .map((e) => LogicalKeyboardKey.findKeyByKeyId(e))
          .whereType<LogicalKeyboardKey>()
          .toSet(),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
      'keySet': keySet.map((e) => e.keyId).toList(),
      'category': category,
    };
  }
}

// 快捷键冲突异常
class ShortcutConflictException implements Exception {
  final String message;

  ShortcutConflictException(this.message);

  @override
  String toString() => message;
}
