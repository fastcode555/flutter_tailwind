import 'package:example/super_markdown/core/services/color_analyzer_service.dart';
import 'package:example/super_markdown/core/services/color_history_service.dart';
import 'package:example/super_markdown/widgets/color_dropper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class ColorPicker extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;
  final bool enableAlpha;
  final bool enableCustomColors;

  const ColorPicker({
    required this.color, required this.onColorChanged, super.key,
    this.enableAlpha = true,
    this.enableCustomColors = true,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _currentColor;
  bool _showPicker = false;
  bool _isPickingColor = false;

  final _colorHistory = Get.find<ColorHistoryService>();
  final _schemeNameController = TextEditingController();

  late ColorAnalysis _analysis;
  late ColorHarmony _harmony;

  // 预定义颜色
  static const List<List<Color>> presetColors = [
    // 基础颜色
    [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
    ],
    // 扩展颜色
    [
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
    ],
    // 中性色
    [
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
      Colors.transparent,
    ],
  ];

  @override
  void initState() {
    super.initState();
    _currentColor = widget.color;
    _updateColorAnalysis();
  }

  void _updateColorAnalysis() {
    _analysis = ColorAnalyzerService.analyzeColor(_currentColor);
    _harmony = ColorAnalyzerService.generateHarmony(_currentColor);
  }

  @override
  void dispose() {
    _schemeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isPickingColor) {
      return ColorDropper(
        onColorPicked: _handleColorPicked,
        onCancel: () => setState(() => _isPickingColor = false),
      );
    }

    return PopupMenuButton<void>(
      child: _buildColorButton(),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: _buildColorPicker(),
        ),
      ],
      onOpened: () => setState(() => _showPicker = true),
      onCanceled: () => setState(() => _showPicker = false),
    );
  }

  Widget _buildColorButton() {
    return container.rounded4.p8.child(
      row.center.children([
        // 颜色预览
        container.w24.h24.rounded4.border1.borderGrey200.child(
          container.color(_currentColor).rounded4.mk,
        ),
        w8,
        // 颜色值
        _currentColor.value.toRadixString(16).toUpperCase().padLeft(8, '0').text.f12.mk,
        w4,
        Icons.arrow_drop_down.icon.grey600.s20.mk,
      ]),
    );
  }

  Widget _buildColorPicker() {
    return container.w300.child(
      column.children([
        // 工具栏
        row.spaceBetween.children([
          '选择颜色'.text.f16.bold.mk,
          IconButton(
            icon: Icons.colorize.icon.grey600.s20.mk,
            tooltip: '吸取颜色',
            onPressed: _startColorPicking,
          ),
        ]),

        h16,

        // 预设颜色
        column.children(
          presetColors.map(_buildColorRow).toList(),
        ),

        if (widget.enableCustomColors) ...[
          h16,
          // HSV 选择器
          _buildHsvPicker(),
          h16,
          // RGB 滑块
          _buildRgbSliders(),
        ],

        if (widget.enableAlpha) ...[
          h16,
          // 透明度滑块
          _buildAlphaSlider(),
        ],

        h16,

        // 历史记录
        _buildHistorySection(),

        // 颜色方案
        h16,
        _buildSchemesSection(),

        // 颜色分析
        h16,
        _buildColorAnalysis(),

        // 颜色调和
        h16,
        _buildColorHarmony(),

        // 操作按钮
        row.spaceEvenly.children([
          OutlinedButton(
            child: '重置'.text.mk,
            onPressed: () {
              setState(() => _currentColor = widget.color);
              widget.onColorChanged(_currentColor);
            },
          ),
          ElevatedButton(
            child: '确定'.text.mk,
            onPressed: () {
              widget.onColorChanged(_currentColor);
              Navigator.pop(context);
            },
          ),
        ]),
      ]),
    );
  }

  Widget _buildColorRow(List<Color> colors) {
    return row.children(
      colors.map(_buildColorCell).toList(),
    );
  }

  Widget _buildColorCell(Color color) {
    final isSelected = _currentColor.value == color.value;
    return InkWell(
      onTap: () {
        setState(() => _currentColor = color);
        widget.onColorChanged(color);
      },
      child: container.w24.h24.rounded4.border2.border(isSelected ? Colors.blue : Colors.transparent).child(
            container.color(color).rounded4.mk,
          ),
    );
  }

  Widget _buildHsvPicker() {
    final hsv = HSVColor.fromColor(_currentColor);
    return container.h150.rounded4.child(
      GestureDetector(
        onPanUpdate: (details) {
          final box = context.findRenderObject()! as RenderBox;
          final localPosition = box.globalToLocal(details.globalPosition);
          final width = box.size.width;
          final height = box.size.height;

          setState(() {
            _currentColor = HSVColor.fromAHSV(
              _currentColor.opacity,
              (localPosition.dx / width * 360).clamp(0, 360),
              (localPosition.dy / height).clamp(0, 1),
              hsv.value,
            ).toColor();
          });
        },
        child: CustomPaint(
          painter: _HSVColorPainter(hsv),
          size: const Size(double.infinity, double.infinity),
        ),
      ),
    );
  }

  Widget _buildRgbSliders() {
    return column.children([
      _buildColorSlider(
        label: 'R',
        value: _currentColor.red.toDouble(),
        color: Colors.red,
        onChanged: (value) {
          setState(() {
            _currentColor = _currentColor.withRed((value * 255).round());
          });
        },
      ),
      _buildColorSlider(
        label: 'G',
        value: _currentColor.green.toDouble(),
        color: Colors.green,
        onChanged: (value) {
          setState(() {
            _currentColor = _currentColor.withGreen((value * 255).round());
          });
        },
      ),
      _buildColorSlider(
        label: 'B',
        value: _currentColor.blue.toDouble(),
        color: Colors.blue,
        onChanged: (value) {
          setState(() {
            _currentColor = _currentColor.withBlue((value * 255).round());
          });
        },
      ),
    ]);
  }

  Widget _buildAlphaSlider() {
    return _buildColorSlider(
      label: 'A',
      value: _currentColor.opacity,
      color: Colors.grey,
      onChanged: (value) {
        setState(() {
          _currentColor = _currentColor.withOpacity(value);
        });
      },
    );
  }

  Widget _buildColorSlider({
    required String label,
    required double value,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return row.children([
      label.text.f12.mk,
      Expanded(
        child: SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.3),
            thumbColor: color,
          ),
          child: Slider(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
      (value * 255).round().toString().text.f12.mk,
    ]);
  }

  void _startColorPicking() {
    setState(() => _isPickingColor = true);
  }

  void _handleColorPicked(Color color) {
    setState(() {
      _isPickingColor = false;
      _currentColor = color;
    });
    _colorHistory.addToHistory(color);
    widget.onColorChanged(color);
  }

  Widget _buildHistorySection() {
    return column.crossStart.children([
      row.spaceBetween.children([
        '最近使用'.text.f14.bold.mk,
        IconButton(
          icon: Icons.delete_outline.icon.grey600.s20.mk,
          tooltip: '清除历史',
          onPressed: _colorHistory.clearHistory,
        ),
      ]),
      h8,
      Obx(() => _buildColorRow(_colorHistory.history)),
    ]);
  }

  Widget _buildSchemesSection() {
    return column.crossStart.children([
      row.spaceBetween.children([
        '颜色方案'.text.f14.bold.mk,
        IconButton(
          icon: Icons.add.icon.grey600.s20.mk,
          tooltip: '保存当前方案',
          onPressed: _showSaveSchemeDialog,
        ),
      ]),
      h8,
      Obx(() => column.children(
            _colorHistory.schemes.entries
                .map((entry) => _buildSchemeItem(
                      entry.key,
                      entry.value,
                    ))
                .toList(),
          )),
    ]);
  }

  Widget _buildSchemeItem(String name, List<Color> colors) {
    return container.grey100.rounded4.p8.child(
      column.crossStart.children([
        row.spaceBetween.children([
          name.text.f12.bold.mk,
          IconButton(
            icon: Icons.delete_outline.icon.grey600.s16.mk,
            onPressed: () => _colorHistory.deleteScheme(name),
          ),
        ]),
        _buildColorRow(colors),
      ]),
    );
  }

  void _showSaveSchemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: '保存颜色方案'.text.f16.bold.mk,
        content: TextField(
          controller: _schemeNameController,
          decoration: const InputDecoration(
            labelText: '方案名称',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: '取消'.text.mk,
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: '保存'.text.mk,
            onPressed: () {
              final name = _schemeNameController.text.trim();
              if (name.isNotEmpty) {
                _colorHistory.saveScheme(name, [_currentColor]);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorAnalysis() {
    return ExpansionTile(
      title: '颜色分析'.text.f14.bold.mk,
      children: [
        container.grey100.rounded4.p8.child(
          column.crossStart.children([
            // HSL值
            'HSL: ${_analysis.hsl.hue.round()}°, ${(_analysis.hsl.saturation * 100).round()}%, ${(_analysis.hsl.lightness * 100).round()}%'
                .text
                .f12
                .mk,
            // HSV值
            'HSV: ${_analysis.hsv.hue.round()}°, ${(_analysis.hsv.saturation * 100).round()}%, ${(_analysis.hsv.value * 100).round()}%'
                .text
                .f12
                .mk,
            // 亮度
            '亮度: ${(_analysis.brightness * 100).round()}%'.text.f12.mk,
            // 色温
            '色温: ${_analysis.temperature.round()}'.text.f12.mk,
            // 对比度
            '对比度: ${_analysis.contrastRatio.toStringAsFixed(2)}'.text.f12.mk,
            // 特性标签
            wrap.spacing4.runSpacing4.children(
              [
                if (_analysis.isLight) _buildTag('明亮'),
                if (_analysis.isDark) _buildTag('暗色'),
                if (_analysis.isVivid) _buildTag('鲜艳'),
                if (_analysis.isPastel) _buildTag('柔和'),
                if (_analysis.isNeutral) _buildTag('中性'),
              ],
            ),
            // 无障碍信息
            '无障碍等级:'.text.f12.mk,
            wrap.spacing4.runSpacing4.children([
              if (_analysis.accessibility.wcagAANormal) _buildTag('WCAG AA'),
              if (_analysis.accessibility.wcagAAA) _buildTag('WCAG AAA'),
            ]),
          ]),
        ),
      ],
    );
  }

  Widget _buildColorHarmony() {
    return ExpansionTile(
      title: '颜色调和'.text.f14.bold.mk,
      children: [
        container.grey100.rounded4.p8.child(
          column.crossStart.children([
            // 互补色
            _buildHarmonyRow('互补色', [_harmony.complementary]),
            // 类比色
            _buildHarmonyRow('类比色', _harmony.analogous),
            // 三角色
            _buildHarmonyRow('三角色', _harmony.triadic),
            // 四角色
            _buildHarmonyRow('四角色', _harmony.tetradic),
            // 分裂互补色
            _buildHarmonyRow('分裂互补色', _harmony.split),
            // 单色
            _buildHarmonyRow('单色', _harmony.monochromatic),
          ]),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return container.grey300.rounded4.ph8.pv4.child(
      text.text.f12.mk,
    );
  }

  Widget _buildHarmonyRow(String label, List<Color> colors) {
    return row.children([
      label.text.f12.mk,
      wrap.spacing4.expanded.runSpacing4.children(
        colors.map(_buildColorCell).toList(),
      ),
    ]);
  }
}

class _HSVColorPainter extends CustomPainter {
  final HSVColor color;

  _HSVColorPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 绘制色相-饱和度渐变
    final colors = List<Color>.generate(
      360,
      (h) => HSVColor.fromAHSV(1, h.toDouble(), 1, color.value).toColor(),
    );

    final Gradient gradient = LinearGradient(colors: colors);
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));

    // 绘制明度渐变
    final valuePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.transparent,
          Colors.black,
        ],
      ).createShader(rect);

    canvas.drawRect(rect, valuePaint);

    // 绘制当前选中点
    final x = color.hue / 360 * size.width;
    final y = color.saturation * size.height;
    canvas.drawCircle(
      Offset(x, y),
      8,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
