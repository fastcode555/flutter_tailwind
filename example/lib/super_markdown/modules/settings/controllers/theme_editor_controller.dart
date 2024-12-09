import 'package:example/super_markdown/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeEditorController extends GetxController {
  final _themeService = Get.find<ThemeService>();

  // 编辑器主题
  final Rx<Color> backgroundColor = Colors.white.obs;
  final Rx<Color> textColor = Colors.black87.obs;
  final Rx<Color> cursorColor = Colors.blue.obs;
  final Rx<Color> selectionColor = Colors.lightBlueAccent.withOpacity(0.3).obs;

  // 语法高亮主题
  final Rx<Color> commentColor = Colors.grey[600]!.obs;
  final Rx<Color> keywordColor = Colors.blue[700]!.obs;
  final Rx<Color> stringColor = Colors.green[700]!.obs;
  final Rx<Color> numberColor = Colors.orange[700]!.obs;
  final Rx<Color> punctuationColor = Colors.grey[700]!.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  // 加载当前主题
  void _loadTheme() {
    final editorTheme = _themeService.editorTheme;
    final syntaxTheme = _themeService.syntaxTheme;

    backgroundColor.value = Color(editorTheme['backgroundColor'] ?? Colors.white.value);
    textColor.value = Color(editorTheme['textColor'] ?? Colors.black87.value);
    cursorColor.value = Color(editorTheme['cursorColor'] ?? Colors.blue.value);
    selectionColor.value = Color(editorTheme['selectionColor'] ?? Colors.lightBlueAccent.withOpacity(0.3).value);

    commentColor.value = Color(syntaxTheme['comment'] ?? Colors.grey[600]!.value);
    keywordColor.value = Color(syntaxTheme['keyword'] ?? Colors.blue[700]!.value);
    stringColor.value = Color(syntaxTheme['string'] ?? Colors.green[700]!.value);
    numberColor.value = Color(syntaxTheme['number'] ?? Colors.orange[700]!.value);
    punctuationColor.value = Color(syntaxTheme['punctuation'] ?? Colors.grey[700]!.value);
  }

  // 保存主题
  Future<void> saveTheme() async {
    await _themeService.updateCustomTheme(
      editor: {
        'backgroundColor': backgroundColor.value.value,
        'textColor': textColor.value.value,
        'cursorColor': cursorColor.value.value,
        'selectionColor': selectionColor.value.value,
      },
      syntax: {
        'comment': commentColor.value.value,
        'keyword': keywordColor.value.value,
        'string': stringColor.value.value,
        'number': numberColor.value.value,
        'punctuation': punctuationColor.value.value,
      },
    );

    Get.snackbar(
      '成功',
      '主题已保存',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // 重置主题
  Future<void> resetTheme() async {
    await _themeService.resetTheme();
    _loadTheme();
    Get.snackbar(
      '成功',
      '主题已重置',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
} 