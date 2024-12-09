import 'package:flutter/material.dart';

class ShortcutWrapper extends StatelessWidget {
  final Widget child;
  final Map<ShortcutActivator, VoidCallback> shortcuts;

  const ShortcutWrapper({
    required this.child, required this.shortcuts, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        // 文件操作
        // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
        //     const SingleActivator(LogicalKeyboardKey.keyS, control: true),
        // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ):
        //     const SingleActivator(LogicalKeyboardKey.keyZ, control: true),
        // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyY):
        //     const SingleActivator(LogicalKeyboardKey.keyY, control: true),
            
        // 格式化
        // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyB):
        //     const SingleActivator(LogicalKeyboardKey.keyB, control: true),
        // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyI):
        //     const SingleActivator(LogicalKeyboardKey.keyI, control: true),
        // LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK):
        //     const SingleActivator(LogicalKeyboardKey.keyK, control: true),
      },
      child: Actions(
        actions: {
          for (final entry in shortcuts.entries)
            SingleActivator: CallbackAction(onInvoke: (_) => entry.value),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
} 