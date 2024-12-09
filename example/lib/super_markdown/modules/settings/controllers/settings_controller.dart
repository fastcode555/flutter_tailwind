import 'package:example/super_markdown/core/services/settings_service.dart';
import 'package:example/super_markdown/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final _themeService = Get.find<ThemeService>();
  final _settingsService = Get.find<SettingsService>();

  // 主题模式
  ThemeMode get themeMode => _themeService.themeMode;

  bool get isDark => _themeService.isDark;

  // 设置选项
  final RxBool autoSave = true.obs;
  final RxBool syncEnabled = false.obs;
  final RxString defaultFormat = 'markdown'.obs;
  final RxString language = 'zh_CN'.obs;

  // 编辑器设置
  final RxBool livePreview = true.obs;
  final RxBool showLineNumbers = true.obs;
  final RxBool codeFolding = true.obs;
  final RxString autoSaveInterval = '5'.obs;

  // 可选的自动保存间隔
  final List<String> autoSaveIntervals = ['1', '5', '10', '15', '30'];

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  // 加载设置
  Future<void> _loadSettings() async {
    // 加载主题设置
    // themeMode.value = _themeService.themeMode;

    // 加载编辑器设置
    final editorSettings = _settingsService.getEditorSettings();
    livePreview.value = editorSettings[SettingsService.kLivePreview]!;
    showLineNumbers.value = editorSettings[SettingsService.kShowLineNumbers]!;
    codeFolding.value = editorSettings[SettingsService.kCodeFolding]!;

    // 加载自动保存设置
    final autoSaveSettings = _settingsService.getAutoSaveSettings();
    autoSave.value = autoSaveSettings[SettingsService.kAutoSave]!;
    autoSaveInterval.value = autoSaveSettings[SettingsService.kAutoSaveInterval]!;
  }

  // 设置主题模式
  Future<void> switchThemeMode(ThemeMode mode) async {
    await _themeService.switchThemeMode(mode);
    update();
  }

  // 打开主题编辑器
  void openThemeEditor() {
    // TODO: 实现主题编辑器页面
  }

  // 切换实时预览
  void toggleLivePreview(bool value) {
    livePreview.value = value;
    // TODO: 保存设置
  }

  // 切换行号显示
  void toggleLineNumbers(bool value) {
    showLineNumbers.value = value;
    // TODO: 保存设置
  }

  // 切换代码折叠
  void toggleCodeFolding(bool value) {
    codeFolding.value = value;
    // TODO: 保存设置
  }

  // 切换自动保存
  void toggleAutoSave(bool value) {
    autoSave.value = value;
    // TODO: 保存设置
  }

  // 设置自动保存间隔
  void setAutoSaveInterval(String interval) {
    autoSaveInterval.value = interval;
    // TODO: 保存设置
  }

  // 打开快捷键设置
  void openShortcutSettings() {
    // TODO: 实现快捷键设置页面
  }

  // 检查更新
  Future<void> checkUpdate() async {
    // TODO: 实现检查更新功能
  }

  // 反馈问题
  void reportIssue() {
    // TODO: 实现问题反馈功能
  }

  @override
  void onClose() {
    // 保存设置
    _saveSettings();
    super.onClose();
  }

  // 保存设置
  Future<void> _saveSettings() async {
    // 保存编辑器设置
    await _settingsService.saveEditorSettings(
      livePreview: livePreview.value,
      showLineNumbers: showLineNumbers.value,
      codeFolding: codeFolding.value,
    );

    // 保存自动保存设置
    await _settingsService.saveAutoSaveSettings(
      autoSave: autoSave.value,
      interval: autoSaveInterval.value,
    );
  }

  // 更新编辑器主题
  Future<void> updateEditorTheme(Map<String, dynamic> theme) async {
    await _themeService.updateCustomTheme(editor: theme);
    update();
  }

  // 更新语法高亮主题
  Future<void> updateSyntaxTheme(Map<String, dynamic> theme) async {
    await _themeService.updateCustomTheme(syntax: theme);
    update();
  }

  // 更新UI主题
  Future<void> updateUiTheme(Map<String, dynamic> theme) async {
    await _themeService.updateCustomTheme(ui: theme);
    update();
  }

  // 重置主题
  Future<void> resetTheme() async {
    await _themeService.resetTheme();
    update();
  }

  // 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    await _themeService.switchThemeMode(mode);
    update();
  }

  // 更新编辑器设置
  Future<void> updateEditorSettings({
    bool? livePreview,
    bool? showLineNumbers,
    bool? codeFolding,
  }) async {
    if (livePreview != null) this.livePreview.value = livePreview;
    if (showLineNumbers != null) this.showLineNumbers.value = showLineNumbers;
    if (codeFolding != null) this.codeFolding.value = codeFolding;

    await _settingsService.saveEditorSettings(
      livePreview: this.livePreview.value,
      showLineNumbers: this.showLineNumbers.value,
      codeFolding: this.codeFolding.value,
    );
  }

  // 更新自动保存设置
  Future<void> updateAutoSaveSettings({
    bool? autoSave,
    String? interval,
  }) async {
    if (autoSave != null) this.autoSave.value = autoSave;
    if (interval != null) autoSaveInterval.value = interval;

    await _settingsService.saveAutoSaveSettings(
      autoSave: this.autoSave.value,
      interval: autoSaveInterval.value,
    );
  }

  // 获取自动保存间隔（分钟）
  int get autoSaveIntervalMinutes => int.parse(autoSaveInterval.value);

  // 重置编辑器设置
  Future<void> resetEditorSettings() async {
    livePreview.value = true;
    showLineNumbers.value = true;
    codeFolding.value = true;
    autoSave.value = true;
    autoSaveInterval.value = '5';

    await _settingsService.saveEditorSettings(
      livePreview: true,
      showLineNumbers: true,
      codeFolding: true,
    );

    await _settingsService.saveAutoSaveSettings(
      autoSave: true,
      interval: '5',
    );
  }

  // 导出编辑器设置
  Map<String, dynamic> exportEditorSettings() {
    return {
      'livePreview': livePreview.value,
      'showLineNumbers': showLineNumbers.value,
      'codeFolding': codeFolding.value,
      'autoSave': autoSave.value,
      'autoSaveInterval': autoSaveInterval.value,
    };
  }

  // 导入编辑器设置
  Future<void> importEditorSettings(Map<String, dynamic> settings) async {
    livePreview.value = settings['livePreview'] ?? true;
    showLineNumbers.value = settings['showLineNumbers'] ?? true;
    codeFolding.value = settings['codeFolding'] ?? true;
    autoSave.value = settings['autoSave'] ?? true;
    autoSaveInterval.value = settings['autoSaveInterval'] ?? '5';

    await _settingsService.saveEditorSettings(
      livePreview: livePreview.value,
      showLineNumbers: showLineNumbers.value,
      codeFolding: codeFolding.value,
    );

    await _settingsService.saveAutoSaveSettings(
      autoSave: autoSave.value,
      interval: autoSaveInterval.value,
    );
  }
}
