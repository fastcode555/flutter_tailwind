import 'package:example/super_markdown/core/services/dialog_service.dart';
import 'package:example/super_markdown/core/services/editor_service.dart';
import 'package:example/super_markdown/core/services/file_service.dart';
import 'package:example/super_markdown/core/services/markdown_service.dart';
import 'package:example/super_markdown/core/services/math_calculator_service.dart';
import 'package:example/super_markdown/core/services/settings_service.dart';
import 'package:example/super_markdown/core/services/shortcut_service.dart';
import 'package:example/super_markdown/core/services/theme_service.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    // 注册核心服务
    Get.lazyPut<EditorService>(EditorService.new, fenix: true);
    Get.lazyPut<MarkdownService>(MarkdownService.new, fenix: true);
    Get.lazyPut<FileService>(FileService.new, fenix: true);
    Get.lazyPut<ThemeService>(ThemeService.new, fenix: true);
    Get.lazyPut<SettingsService>(SettingsService.new, fenix: true);
    Get.lazyPut<ShortcutService>(ShortcutService.new, fenix: true);
    Get.lazyPut<DialogService>(DialogService.new, fenix: true);
    Get.lazyPut<MathCalculatorService>(MathCalculatorService.new, fenix: true);
  }
} 