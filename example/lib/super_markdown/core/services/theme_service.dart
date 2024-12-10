import 'dart:convert';

import 'package:example/super_markdown/core/theme/flow_chart_theme.dart';
import 'package:example/super_markdown/core/theme/theme_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  static const String kCustomThemes = 'flow_chart_custom_themes';
  static const String kThemeMode = 'theme_mode';
  static const String kCustomTheme = 'custom_theme';

  late final SharedPreferences _prefs;
  final _customThemes = <String, FlowChartTheme>{}.obs;
  final _themeMode = ThemeMode.system.obs;
  final _isDark = false.obs;

  // 主题配置
  final _editorTheme = <String, dynamic>{}.obs;
  final _syntaxTheme = <String, dynamic>{}.obs;
  final _uiTheme = <String, dynamic>{}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    // 初始化主题服务
    Get.put(EditorTheme({}));
    Get.put(SyntaxTheme({}));
    Get.put(UiTheme({}));

    _prefs = await SharedPreferences.getInstance();
    await _loadCustomThemes();
    await _loadThemeMode();
    await _loadCustomTheme();
    _updateTheme();
  }

  Future<void> _loadCustomThemes() async {
    final json = _prefs.getString(kCustomThemes);
    if (json != null) {
      final map = jsonDecode(json) as Map<String, dynamic>;
      _customThemes.value = map.map(
        (key, value) => MapEntry(key, _themeFromJson(value)),
      );
    }
  }

  Future<void> _saveCustomThemes() async {
    final map = _customThemes.map(
      (key, value) => MapEntry(key, _themeToJson(value)),
    );
    await _prefs.setString(kCustomThemes, jsonEncode(map));
  }

  // 加载主题模式
  Future<void> _loadThemeMode() async {
    final modeStr = _prefs.getString(kThemeMode);
    if (modeStr != null) {
      _themeMode.value = ThemeMode.values.firstWhere(
        (e) => e.toString() == modeStr,
        orElse: () => ThemeMode.system,
      );
    }
    _updateIsDark();
  }

  // 加载自定义主题
  Future<void> _loadCustomTheme() async {
    final themeStr = _prefs.getString(kCustomTheme);
    if (themeStr != null) {
      final themeMap = jsonDecode(themeStr);
      _editorTheme.value = themeMap['editor'] ?? {};
      _syntaxTheme.value = themeMap['syntax'] ?? {};
      _uiTheme.value = themeMap['ui'] ?? {};
    }
  }

  // 保存主题设置
  Future<void> _saveThemeSettings() async {
    await _prefs.setString(kThemeMode, _themeMode.value.toString());
    await _prefs.setString(
        kCustomTheme,
        jsonEncode({
          'editor': _editorTheme,
          'syntax': _syntaxTheme,
          'ui': _uiTheme,
        }));
  }

  // 切换主题模式
  Future<void> switchThemeMode(ThemeMode mode) async {
    _themeMode.value = mode;
    _updateIsDark();
    await _saveThemeSettings();
    _updateTheme();
  }

  // 更新暗色模式状态
  void _updateIsDark() {
    switch (_themeMode.value) {
      case ThemeMode.system:
        _isDark.value = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      case ThemeMode.dark:
        _isDark.value = true;
      case ThemeMode.light:
        _isDark.value = false;
    }
  }

  // 更新主题
  void _updateTheme() {
    Get.changeThemeMode(_themeMode.value);
    // 更新编辑器主题
    _updateEditorTheme();
    // 更新语法高亮主题
    _updateSyntaxTheme();
    // 更新UI主题
    _updateUiTheme();
  }

  // 更新编辑器主题
  void _updateEditorTheme() {
    final theme = _isDark.value ? _getDarkEditorTheme() : _getLightEditorTheme();
    // 应用自定义设置
    theme.addAll(_editorTheme);
    Get.find<EditorTheme>().updateTheme(theme);
  }

  // 更新语法高亮主题
  void _updateSyntaxTheme() {
    final theme = _isDark.value ? _getDarkSyntaxTheme() : _getLightSyntaxTheme();
    // 应用自定义设置
    theme.addAll(_syntaxTheme);
    Get.find<SyntaxTheme>().updateTheme(theme);
  }

  // 更新UI主题
  void _updateUiTheme() {
    final theme = _isDark.value ? _getDarkUiTheme() : _getLightUiTheme();
    // 应用自定义设置
    theme.addAll(_uiTheme);
    Get.find<UiTheme>().updateTheme(theme);
  }

  // 获取亮色编辑器主题
  Map<String, dynamic> _getLightEditorTheme() => {
        'backgroundColor': Colors.white,
        'textColor': Colors.black87,
        'cursorColor': Colors.blue,
        'selectionColor': Colors.lightBlueAccent.withOpacity(0.3),
        // ... 其他编辑器主题设置
      };

  // 获取暗色编辑器主题
  Map<String, dynamic> _getDarkEditorTheme() => {
        'backgroundColor': Colors.grey[900],
        'textColor': Colors.white70,
        'cursorColor': Colors.lightBlueAccent,
        'selectionColor': Colors.lightBlueAccent.withOpacity(0.3),
        // ... 其他编辑器主题设置
      };

  // 获取亮色语法高亮主题
  Map<String, dynamic> _getLightSyntaxTheme() => {
        'comment': Colors.grey[600],
        'keyword': Colors.blue[700],
        'string': Colors.green[700],
        'number': Colors.orange[700],
        'punctuation': Colors.grey[700],
        // ... 其他语法高亮设置
      };

  // 获取暗色语法高亮主题
  Map<String, dynamic> _getDarkSyntaxTheme() => {
        'comment': Colors.grey[400],
        'keyword': Colors.lightBlue[300],
        'string': Colors.lightGreen[300],
        'number': Colors.orange[300],
        'punctuation': Colors.grey[300],
        // ... 其他语法高亮设置
      };

  // 获取亮色UI主题
  Map<String, dynamic> _getLightUiTheme() => {
        'primaryColor': Colors.blue,
        'backgroundColor': Colors.white,
        'cardColor': Colors.white,
        'dividerColor': Colors.grey[200],
        // ... 其他UI主题设置
      };

  // 获取暗色UI主题
  Map<String, dynamic> _getDarkUiTheme() => {
        'primaryColor': Colors.lightBlue,
        'backgroundColor': Colors.grey[900],
        'cardColor': Colors.grey[850],
        'dividerColor': Colors.grey[800],
        // ... 其他UI主题设置
      };

  // 更新自定义主题设置
  Future<void> updateCustomTheme({
    Map<String, dynamic>? editor,
    Map<String, dynamic>? syntax,
    Map<String, dynamic>? ui,
  }) async {
    if (editor != null) _editorTheme.addAll(editor);
    if (syntax != null) _syntaxTheme.addAll(syntax);
    if (ui != null) _uiTheme.addAll(ui);
    await _saveThemeSettings();
    _updateTheme();
  }

  // 重置主题设置
  Future<void> resetTheme() async {
    _editorTheme.clear();
    _syntaxTheme.clear();
    _uiTheme.clear();
    await _saveThemeSettings();
    _updateTheme();
  }

  // Getters
  ThemeMode get themeMode => _themeMode.value;

  bool get isDark => _isDark.value;

  Map<String, dynamic> get editorTheme => Map.from(_editorTheme);

  Map<String, dynamic> get syntaxTheme => Map.from(_syntaxTheme);

  Map<String, dynamic> get uiTheme => Map.from(_uiTheme);

  // 添加自定义主题
  Future<void> addCustomTheme(String name, FlowChartTheme theme) async {
    _customThemes[name] = theme;
    await _saveCustomThemes();
  }

  // 删除自定义主题
  Future<void> removeCustomTheme(String name) async {
    _customThemes.remove(name);
    await _saveCustomThemes();
  }

  // 导出主题
  String exportTheme(FlowChartTheme theme) {
    return jsonEncode(_themeToJson(theme));
  }

  // 导入主题
  FlowChartTheme? importTheme(String json) {
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return _themeFromJson(map);
    } catch (e) {
      return null;
    }
  }

  // 序列化主题
  Map<String, dynamic> _themeToJson(FlowChartTheme theme) {
    return {
      'backgroundColor': theme.backgroundColor.value,
      'animated': theme.animated,
      'defaultNodeTheme': _nodeThemeToJson(theme.defaultNodeTheme),
      'defaultEdgeTheme': _edgeThemeToJson(theme.defaultEdgeTheme),
      'nodeThemes': theme.nodeThemes.map(
        (key, value) => MapEntry(key, _nodeThemeToJson(value)),
      ),
      'edgeThemes': theme.edgeThemes.map(
        (key, value) => MapEntry(key, _edgeThemeToJson(value)),
      ),
    };
  }

  // 反序列化主题
  FlowChartTheme _themeFromJson(Map<String, dynamic> json) {
    return FlowChartTheme(
      backgroundColor: Color(json['backgroundColor']),
      animated: json['animated'],
      defaultNodeTheme: _nodeThemeFromJson(json['defaultNodeTheme']),
      defaultEdgeTheme: _edgeThemeFromJson(json['defaultEdgeTheme']),
      nodeThemes: (json['nodeThemes'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, _nodeThemeFromJson(value)),
      ),
      edgeThemes: (json['edgeThemes'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, _edgeThemeFromJson(value)),
      ),
    );
  }

  // 节点主题序列化
  Map<String, dynamic> _nodeThemeToJson(NodeTheme theme) {
    return {
      'backgroundColor': theme.backgroundColor.value,
      'borderColor': theme.borderColor.value,
      'textColor': theme.textColor.value,
      'borderWidth': theme.borderWidth,
      'padding': theme.padding,
      'fontSize': theme.fontSize,
      'fontWeight': theme.fontWeight.index,
      'cornerRadius': theme.cornerRadius,
      'shadows': theme.shadows?.map(_shadowToJson).toList(),
      'gradient': theme.gradient != null
          ? {
              'colors': (theme.gradient! as LinearGradient).colors.map((c) => c.value).toList(),
              'begin': {
                'x': (theme.gradient! as LinearGradient).begin as Alignment,
                'y': (theme.gradient! as LinearGradient).begin as Alignment,
              },
              'end': {
                'x': (theme.gradient! as LinearGradient).end as Alignment,
                'y': (theme.gradient! as LinearGradient).end as Alignment,
              },
            }
          : null,
    };
  }

  // 边线主题序列化
  Map<String, dynamic> _edgeThemeToJson(EdgeTheme theme) {
    return {
      'color': theme.color.value,
      'strokeWidth': theme.strokeWidth,
      'style': theme.style.index,
      'animated': theme.animated,
      'arrowSize': theme.arrowSize,
      'dashLength': theme.dashLength,
      'dashGap': theme.dashGap,
      'strokeCap': theme.strokeCap.index,
      'gradient': theme.gradient != null
          ? {
              'colors': (theme.gradient! as LinearGradient).colors.map((c) => c.value).toList(),
              'begin': {
                'x': (theme.gradient! as LinearGradient).begin as Alignment,
                'y': (theme.gradient! as LinearGradient).begin as Alignment,
              },
              'end': {
                'x': (theme.gradient! as LinearGradient).end as Alignment,
                'y': (theme.gradient! as LinearGradient).end as Alignment,
              },
            }
          : null,
      'animationColors': theme.animationColors?.map((c) => c.value).toList(),
    };
  }

  // 阴影序列化
  Map<String, dynamic> _shadowToJson(BoxShadow shadow) {
    return {
      'color': shadow.color.value,
      'blurRadius': shadow.blurRadius,
      'spreadRadius': shadow.spreadRadius,
      'offset': {
        'dx': shadow.offset.dx,
        'dy': shadow.offset.dy,
      },
    };
  }

  // 节点主题反序列化
  NodeTheme _nodeThemeFromJson(Map<String, dynamic> json) {
    return NodeTheme(
      backgroundColor: Color(json['backgroundColor']),
      borderColor: Color(json['borderColor']),
      textColor: Color(json['textColor']),
      borderWidth: json['borderWidth'],
      padding: json['padding'],
      fontSize: json['fontSize'],
      fontWeight: FontWeight.values[json['fontWeight']],
      cornerRadius: json['cornerRadius'],
      shadows: (json['shadows'] as List?)?.map((s) => _shadowFromJson(s)).toList(),
      gradient: json['gradient'] != null
          ? LinearGradient(
              colors: (json['gradient']['colors'] as List).map((c) => Color(c)).toList(),
              begin: json['gradient']['begin'] as Alignment,
              end: json['gradient']['end'] as Alignment,
            )
          : null,
    );
  }

  // 边线主题反序列化
  EdgeTheme _edgeThemeFromJson(Map<String, dynamic> json) {
    return EdgeTheme(
      color: Color(json['color']),
      strokeWidth: json['strokeWidth'],
      style: PaintingStyle.values[json['style']],
      animated: json['animated'],
      arrowSize: json['arrowSize'],
      dashLength: json['dashLength'],
      dashGap: json['dashGap'],
      strokeCap: StrokeCap.values[json['strokeCap']],
      gradient: json['gradient'] != null
          ? LinearGradient(
              colors: (json['gradient']['colors'] as List).map((c) => Color(c)).toList(),
              begin: json['gradient']['begin'] as Alignment,
              end: json['gradient']['end'] as Alignment,
            )
          : null,
      animationColors: (json['animationColors'] as List?)?.map((c) => Color(c)).toList(),
    );
  }

  // 阴影反序列化
  BoxShadow _shadowFromJson(Map<String, dynamic> json) {
    return BoxShadow(
      color: Color(json['color']),
      blurRadius: json['blurRadius'],
      spreadRadius: json['spreadRadius'],
      offset: Offset(
        json['offset']['dx'],
        json['offset']['dy'],
      ),
    );
  }
}
