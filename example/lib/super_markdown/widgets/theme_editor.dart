import 'package:example/super_markdown/core/theme/flow_chart_theme.dart';
import 'package:example/super_markdown/widgets/color_picker.dart';
import 'package:example/super_markdown/widgets/flow_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ThemeEditor extends StatefulWidget {
  final FlowChartTheme initialTheme;
  final ValueChanged<FlowChartTheme> onThemeChanged;

  const ThemeEditor({
    required this.initialTheme,
    required this.onThemeChanged,
    super.key,
  });

  @override
  State<ThemeEditor> createState() => _ThemeEditorState();
}

class _ThemeEditorState extends State<ThemeEditor> {
  late FlowChartTheme _theme;
  final _previewCode = '''
[start: 开始 (circle)]
[process: 处理数据 (diamond)]
[end: 结束 (circle)]

start -> process: normal
process -> end: success
process -> start: error
''';

  @override
  void initState() {
    super.initState();
    _theme = widget.initialTheme;
  }

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.p16.cardShadow.child(
      row.children([
        // 编辑区域
        Expanded(
          child: SingleChildScrollView(
            child: column.crossStart.children([
              // 基本设置
              '基本设置'.text.f16.bold.mk,
              _buildColorPicker('背景色', _theme.backgroundColor, (color) {
                setState(() {
                  _theme = _theme.copyWith(backgroundColor: color);
                });
                widget.onThemeChanged(_theme);
              }),
              _buildSwitch('启用动画', _theme.animated, (value) {
                setState(() {
                  _theme = _theme.copyWith(animated: value);
                });
                widget.onThemeChanged(_theme);
              }),

              // 节点样式
              '默认节点样式'.text.f16.bold.mk,
              _buildNodeThemeEditor(_theme.defaultNodeTheme, (theme) {
                setState(() {
                  _theme = _theme.copyWith(defaultNodeTheme: theme);
                });
                widget.onThemeChanged(_theme);
              }),

              // 连接线样式
              '默认连接线样式'.text.f16.bold.mk,
              _buildEdgeThemeEditor(_theme.defaultEdgeTheme, (theme) {
                setState(() {
                  _theme = _theme.copyWith(defaultEdgeTheme: theme);
                });
                widget.onThemeChanged(_theme);
              }),

              // 特定类型���式
              '特定类型样式'.text.f16.bold.mk,
              _buildNodeTypeThemes(),
              _buildEdgeTypeThemes(),
            ]),
          ),
        ),

        w16,

        // 预览区域
        Expanded(
          child: column.children([
            '预览'.text.f16.bold.mk,
            h16,
            Expanded(
              child: FlowChart(
                code: _previewCode,
                theme: _theme,
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _buildColorPicker(
    String label,
    Color value,
    ValueChanged<Color> onChanged,
  ) {
    return row.children([
      label.text.f14.mk,
      ColorPicker(
        color: value,
        onColorChanged: onChanged,
      ),
    ]);
  }

  Widget _buildSwitch(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return row.children([
      label.text.f14.mk,
      Switch(
        value: value,
        onChanged: onChanged,
      ),
    ]);
  }

  Widget _buildNodeThemeEditor(
    NodeTheme theme,
    ValueChanged<NodeTheme> onChanged,
  ) {
    return column.crossStart.children([
      _buildColorPicker('背景色', theme.backgroundColor, (color) {
        onChanged(NodeTheme(
          backgroundColor: color,
          borderColor: theme.borderColor,
          textColor: theme.textColor,
          borderWidth: theme.borderWidth,
          padding: theme.padding,
          fontSize: theme.fontSize,
          fontWeight: theme.fontWeight,
          cornerRadius: theme.cornerRadius,
          shadows: theme.shadows,
          gradient: theme.gradient,
        ));
      }),
      _buildColorPicker('边框色', theme.borderColor, (color) {
        onChanged(NodeTheme(
          backgroundColor: theme.backgroundColor,
          borderColor: color,
          textColor: theme.textColor,
          borderWidth: theme.borderWidth,
          padding: theme.padding,
          fontSize: theme.fontSize,
          fontWeight: theme.fontWeight,
          cornerRadius: theme.cornerRadius,
          shadows: theme.shadows,
          gradient: theme.gradient,
        ));
      }),
      // ... 添加更多属性编辑器
    ]);
  }

  Widget _buildEdgeThemeEditor(
    EdgeTheme theme,
    ValueChanged<EdgeTheme> onChanged,
  ) {
    return column.crossStart.children([
      _buildColorPicker('线条颜色', theme.color, (color) {
        onChanged(EdgeTheme(
          color: color,
          strokeWidth: theme.strokeWidth,
          style: theme.style,
          animated: theme.animated,
          arrowSize: theme.arrowSize,
          dashLength: theme.dashLength,
          dashGap: theme.dashGap,
          gradient: theme.gradient,
          strokeCap: theme.strokeCap,
          animationColors: theme.animationColors,
        ));
      }),
      // ... 添加更多属性编辑器
    ]);
  }

  Widget _buildNodeTypeThemes() {
    return column.crossStart.children([
      for (final entry in _theme.nodeThemes.entries)
        ExpansionTile(
          title: entry.key.text.f14.mk,
          children: [
            _buildNodeThemeEditor(entry.value, (theme) {
              setState(() {
                final themes = Map<String, NodeTheme>.from(_theme.nodeThemes);
                themes[entry.key] = theme;
                _theme = _theme.copyWith(nodeThemes: themes);
              });
              widget.onThemeChanged(_theme);
            }),
          ],
        ),
    ]);
  }

  Widget _buildEdgeTypeThemes() {
    return column.crossStart.children([
      for (final entry in _theme.edgeThemes.entries)
        ExpansionTile(
          title: entry.key.text.f14.mk,
          children: [
            _buildEdgeThemeEditor(entry.value, (theme) {
              setState(() {
                final themes = Map<String, EdgeTheme>.from(_theme.edgeThemes);
                themes[entry.key] = theme;
                _theme = _theme.copyWith(edgeThemes: themes);
              });
              widget.onThemeChanged(_theme);
            }),
          ],
        ),
    ]);
  }
}
