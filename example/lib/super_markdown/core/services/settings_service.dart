import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends GetxService {
  late final SharedPreferences _prefs;

  // 键名常量
  static const String kThemeMode = 'theme_mode';
  static const String kLivePreview = 'live_preview';
  static const String kShowLineNumbers = 'show_line_numbers';
  static const String kCodeFolding = 'code_folding';
  static const String kAutoSave = 'auto_save';
  static const String kAutoSaveInterval = 'auto_save_interval';

  @override
  Future<void> onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
  }

  // 保存主题模式
  Future<void> saveThemeMode(ThemeMode mode) async {
    await _prefs.setString(kThemeMode, mode.toString());
  }

  // 获取主题模式
  ThemeMode getThemeMode() {
    final value = _prefs.getString(kThemeMode);
    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == value,
      orElse: () => ThemeMode.system,
    );
  }

  // 保存编辑器设置
  Future<void> saveEditorSettings({
    required bool livePreview,
    required bool showLineNumbers,
    required bool codeFolding,
  }) async {
    await _prefs.setBool(kLivePreview, livePreview);
    await _prefs.setBool(kShowLineNumbers, showLineNumbers);
    await _prefs.setBool(kCodeFolding, codeFolding);
  }

  // 获取编辑器设置
  Map<String, bool> getEditorSettings() {
    return {
      kLivePreview: _prefs.getBool(kLivePreview) ?? true,
      kShowLineNumbers: _prefs.getBool(kShowLineNumbers) ?? true,
      kCodeFolding: _prefs.getBool(kCodeFolding) ?? true,
    };
  }

  // 保存自动保存设置
  Future<void> saveAutoSaveSettings({
    required bool autoSave,
    required String interval,
  }) async {
    await _prefs.setBool(kAutoSave, autoSave);
    await _prefs.setString(kAutoSaveInterval, interval);
  }

  // 获取自动保存设置
  Map<String, dynamic> getAutoSaveSettings() {
    return {
      kAutoSave: _prefs.getBool(kAutoSave) ?? true,
      kAutoSaveInterval: _prefs.getString(kAutoSaveInterval) ?? '1分钟',
    };
  }
}
