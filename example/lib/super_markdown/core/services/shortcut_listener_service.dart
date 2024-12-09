import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ShortcutListenerService extends GetxService {
  // 快捷键映射
  final Map<String, ShortcutAction> _shortcuts = {};

  // 当前按下的键
  final Set<LogicalKeyboardKey> _pressedKeys = {};

  // 添加快捷键
  void addShortcut(String id, ShortcutAction action) {
    _shortcuts[id] = action;
  }

  // 移除快捷键
  void removeShortcut(String id) {
    _shortcuts.remove(id);
  }

  // 处理按键事件
  void handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
      _checkShortcuts();
    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    }
  }

  // 检查快捷键
  void _checkShortcuts() {
    final action = _findMatchingAction();
    if (action != null) {
      action.execute();
      _pressedKeys.clear();
    }
  }

  // 查找匹配的动作
  ShortcutAction? _findMatchingAction() {
    for (final action in _shortcuts.values) {
      if (_isKeySetMatch(action.keySet)) {
        return action;
      }
    }
    return null;
  }

  // 检查按键组合是否匹配
  bool _isKeySetMatch(Set<LogicalKeyboardKey> keySet) {
    if (keySet.length != _pressedKeys.length) return false;
    return keySet.every(_pressedKeys.contains);
  }

  // 获取所有快捷键
  Map<String, ShortcutAction> get shortcuts => Map.unmodifiable(_shortcuts);

  // 清除所有快捷键
  void clearShortcuts() {
    _shortcuts.clear();
  }

  // 重置按键状态
  void resetKeyState() {
    _pressedKeys.clear();
  }

  // 检查快捷键冲突
  List<ShortcutConflict> checkConflicts() {
    final conflicts = <ShortcutConflict>[];
    final entries = _shortcuts.entries.toList();

    for (var i = 0; i < entries.length; i++) {
      for (var j = i + 1; j < entries.length; j++) {
        final action1 = entries[i];
        final action2 = entries[j];

        if (_isKeySetMatch(action1.value.keySet)) {
          conflicts.add(ShortcutConflict(
            action1: action1.value,
            action2: action2.value,
            id1: action1.key,
            id2: action2.key,
          ));
        }
      }
    }

    return conflicts;
  }

  // 导出快捷键配置
  Map<String, dynamic> exportConfig() {
    return {
      'shortcuts': _shortcuts.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }

  // 导入快捷键配置
  void importConfig(Map<String, dynamic> config) {
    _shortcuts.clear();
    final shortcuts = config['shortcuts'] as Map<String, dynamic>;
    shortcuts.forEach((key, value) {
      _shortcuts[key] = ShortcutAction.fromJson(value);
    });
  }
}

// 快捷键动作
class ShortcutAction {
  final String label;
  final Set<LogicalKeyboardKey> keySet;
  final Function() execute;
  final String category;

  ShortcutAction({
    required this.label,
    required this.keySet,
    required this.execute,
    required this.category,
  });

  // 从 JSON 创建
  factory ShortcutAction.fromJson(Map<String, dynamic> json) {
    return ShortcutAction(
      label: json['label'],
      keySet: (json['keySet'] as List).map((e) => LogicalKeyboardKey(e)).toSet(),
      execute: () {}, // 需要在运行时重新设置
      category: json['category'],
    );
  }

  // 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'keySet': keySet.map((e) => e.keyId).toList(),
      'category': category,
    };
  }
}

// 快捷键冲突
class ShortcutConflict {
  final ShortcutAction action1;
  final ShortcutAction action2;
  final String id1;
  final String id2;

  ShortcutConflict({
    required this.action1,
    required this.action2,
    required this.id1,
    required this.id2,
  });

  @override
  String toString() {
    return 'Conflict between "$id1" and "$id2": both use ${_formatKeySet(action1.keySet)}';
  }

  String _formatKeySet(Set<LogicalKeyboardKey> keySet) {
    return keySet.map((key) => key.debugName).join(' + ');
  }
}
