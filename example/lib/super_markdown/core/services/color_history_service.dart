import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorHistoryService extends GetxService {
  static const String kColorHistory = 'color_history';
  static const String kColorSchemes = 'color_schemes';
  static const int maxHistoryCount = 30;

  late final SharedPreferences _prefs;
  final _colorHistory = <Color>[].obs;
  final _colorSchemes = <String, List<Color>>{}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    await _loadHistory();
    await _loadSchemes();
  }

  Future<void> _loadHistory() async {
    final json = _prefs.getString(kColorHistory);
    if (json != null) {
      final List<dynamic> list = jsonDecode(json);
      _colorHistory.value = list.map((e) => Color(e as int)).toList();
    }
  }

  Future<void> _saveHistory() async {
    final list = _colorHistory.map((c) => c.value).toList();
    await _prefs.setString(kColorHistory, jsonEncode(list));
  }

  Future<void> _loadSchemes() async {
    final json = _prefs.getString(kColorSchemes);
    if (json != null) {
      final Map<String, dynamic> map = jsonDecode(json);
      _colorSchemes.value = map.map(
        (key, value) => MapEntry(
          key,
          (value as List).map((e) => Color(e as int)).toList(),
        ),
      );
    }
  }

  Future<void> _saveSchemes() async {
    final map = _colorSchemes.map(
      (key, value) => MapEntry(key, value.map((c) => c.value).toList()),
    );
    await _prefs.setString(kColorSchemes, jsonEncode(map));
  }

  // 添加颜色到历史记录
  Future<void> addToHistory(Color color) async {
    if (!_colorHistory.contains(color)) {
      _colorHistory.insert(0, color);
      if (_colorHistory.length > maxHistoryCount) {
        _colorHistory.removeLast();
      }
      await _saveHistory();
    }
  }

  // 清除历史记录
  Future<void> clearHistory() async {
    _colorHistory.clear();
    await _saveHistory();
  }

  // 保存颜色方案
  Future<void> saveScheme(String name, List<Color> colors) async {
    _colorSchemes[name] = colors;
    await _saveSchemes();
  }

  // 删除颜色方案
  Future<void> deleteScheme(String name) async {
    _colorSchemes.remove(name);
    await _saveSchemes();
  }

  // 获取历史记录
  List<Color> get history => _colorHistory;

  // 获取颜色方案
  Map<String, List<Color>> get schemes => _colorSchemes;
}
