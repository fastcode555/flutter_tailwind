import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

// 编辑模式枚举
enum EditMode {
  filter,
  adjust,
  crop,
  rotate,
  draw,
  text,
  sticker,
}

// 导出类型枚举
enum ExportType {
  original, // 原始尺寸
  compressed, // 压缩尺寸
  share, // 分享
  wallpaper, // 设为壁纸
}

// 导出质量选项
enum ExportQuality {
  high, // 高质量
  medium, // 中等质量
  low, // 低质量
}

// 导出格式选项
enum ExportFormat {
  jpg,
  png,
  webp,
}

// 导出配置类
class ExportConfig {
  final ExportType type;
  final ExportQuality quality;
  final ExportFormat format;
  final Size? size;
  final bool addWatermark;
  final String? watermarkText;

  const ExportConfig({
    required this.type,
    this.quality = ExportQuality.high,
    this.format = ExportFormat.jpg,
    this.size,
    this.addWatermark = false,
    this.watermarkText,
  });

  ExportConfig copyWith({
    ExportType? type,
    ExportQuality? quality,
    ExportFormat? format,
    Size? size,
    bool? addWatermark,
    String? watermarkText,
  }) {
    return ExportConfig(
      type: type ?? this.type,
      quality: quality ?? this.quality,
      format: format ?? this.format,
      size: size ?? this.size,
      addWatermark: addWatermark ?? this.addWatermark,
      watermarkText: watermarkText ?? this.watermarkText,
    );
  }
}

class FacebookImageEditPage extends StatefulWidget {
  final String imageUrl;

  const FacebookImageEditPage({
    required this.imageUrl,
    super.key,
  });

  @override
  State<FacebookImageEditPage> createState() => _FacebookImageEditPageState();
}

class _FacebookImageEditPageState extends State<FacebookImageEditPage> {
  // 基本调整参数
  double _brightness = 0;
  double _contrast = 1;
  double _saturation = 1;
  final double _warmth = 0;
  bool _isBlackAndWhite = false;

  // 变换参数
  double _rotation = 0;
  final double _scale = 1;
  Rect? _cropRect;

  // 绘画参数
  List<DrawingPoint> _drawingPoints = [];
  Color _drawingColor = Colors.red;
  double _drawingWidth = 5;

  // 文字和贴纸
  final List<EditableItem> _items = [];
  EditableItem? _selectedItem;

  // 编辑模式
  EditMode _editMode = EditMode.filter;

  // 滤镜选项
  Widget _buildFilterOption(String label, {bool isSelected = false}) {
    return container.mr16.child(
      column.center.children([
        container.s60.circle
            .color(isSelected ? Colors.blue : Colors.grey[800])
            .center
            .child(label.text.white.f12.mk)
            .click(onTap: () => setState(() => _isBlackAndWhite = label == '黑白')),
        h8,
        label.text.white.f12.mk,
      ]),
    );
  }

  // 调整选项的滑块
  Widget _buildAdjustmentSlider(
    String label,
    IconData icon,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return container.mb16.child(
      column.crossStart.children([
        row.children([
          icon.icon.white.s20.mk,
          w8,
          label.text.white.f14.mk,
          w16,
          '${(value * 100).toInt()}'.text.white.f14.mk,
        ]),
        h8,
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[800],
        ),
      ]),
    );
  }

  // 添加撤销/重做功能
  final List<List<DrawingPoint>> _undoHistory = [];
  final List<List<DrawingPoint>> _redoHistory = [];

  void _undo() {
    if (_drawingPoints.isNotEmpty) {
      setState(() {
        _redoHistory.add(List.from(_drawingPoints));
        _drawingPoints = _undoHistory.removeLast();
      });
    }
  }

  void _redo() {
    if (_redoHistory.isNotEmpty) {
      setState(() {
        _undoHistory.add(List.from(_drawingPoints));
        _drawingPoints = _redoHistory.removeLast();
      });
    }
  }

  // 添加画笔工具栏
  Widget _buildDrawToolbar() {
    return container.black54.p8.rounded8.child(
      row.children([
        IconButton(
          icon: Icons.undo.icon.white.s24.mk,
          onPressed: _undoHistory.isEmpty ? null : _undo,
        ),
        IconButton(
          icon: Icons.redo.icon.white.s24.mk,
          onPressed: _redoHistory.isEmpty ? null : _redo,
        ),
        IconButton(
          icon: Icons.delete.icon.white.s24.mk,
          onPressed: _drawingPoints.isEmpty ? null : () => setState(() => _drawingPoints.clear()),
        ),
      ]),
    );
  }

  // 添加文字编辑功能
  void _showTextEditor() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.p16.child(
        column.crossStart.children([
          '编辑文字'.text.f16.bold.mk,
          h16,
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '输入文字',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                _addText(value);
              }
              Navigator.pop(context);
            },
          ),
          h16,
          // 文字样式选项
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: row.children([
              _buildTextStyleOption('小', 14),
              _buildTextStyleOption('中', 20),
              _buildTextStyleOption('大', 28),
            ]),
          ),
          h16,
          // 颜色选项
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: row.children([
              for (final color in [
                Colors.white,
                Colors.black,
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
              ])
                _buildColorOption(color),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _buildTextStyleOption(String label, double size) {
    return container.mr16.child(
      column.center.children([
        container.s40.circle.grey200.center.child(label.text.f(size).mk).click(onTap: () {
          if (_selectedItem is TextItem) {
            final index = _items.indexOf(_selectedItem!);
            _items[index] = (_selectedItem! as TextItem).copyWith(fontSize: size);
            setState(() {});
          }
        }),
        h8,
        label.text.grey600.f12.mk,
      ]),
    );
  }

  Widget _buildColorOption(Color color) {
    return container.mr16.child(
      container.s40.circle.color(color).border2.borderGrey200.click(onTap: () {
        if (_selectedItem is TextItem) {
          final index = _items.indexOf(_selectedItem!);
          _items[index] = (_selectedItem! as TextItem).copyWith(color: color);
          setState(() {});
        }
      }),
    );
  }

  // 添加贴纸缩放和旋转功能
  Widget _buildTransformableSticker(StickerItem item) {
    return Transform.rotate(
      angle: item.rotation,
      child: Transform.scale(
        scale: item.scale,
        child: GestureDetector(
          onScaleStart: (_) => _selectedItem = item,
          onScaleUpdate: (details) {
            if (_selectedItem != item) return;
            final index = _items.indexOf(item);
            _items[index] = item.copyWith(
              scale: item.scale * details.scale,
              rotation: item.rotation + details.rotation,
            );
            setState(() {});
          },
          child: item.emoji.text.f32.mk,
        ),
      ),
    );
  }

  // 添加保存能
  Future<void> _saveImage() async {
    try {
      // TODO: 实现图片保存逻辑
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '保存成功'.text.white.mk),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '保存失败'.text.white.mk),
      );
    }
  }

  // 导出选项
  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.child(
        column.crossStart.children([
          container.p16.borderB1.borderGrey200.wFull.child(
            '导出选项'.text.f16.bold.mk,
          ),
          _buildExportOption(
            Icons.image_outlined,
            '保存到相册',
            '保存原始尺寸的图片',
            onTap: () => _exportImage(ExportType.original),
          ),
          _buildExportOption(
            Icons.compress,
            '压缩图片',
            '保存压缩后的图片，节省空间',
            onTap: () => _exportImage(ExportType.compressed),
          ),
          _buildExportOption(
            Icons.share,
            '分享图片',
            '分享到其他应用',
            onTap: () => _exportImage(ExportType.share),
          ),
          _buildExportOption(
            Icons.wallpaper,
            '设为壁纸',
            '将图片设为手机壁纸',
            onTap: () => _exportImage(ExportType.wallpaper),
          ),
          container.h8.grey100.wFull.mk,
          _buildExportOption(
            Icons.close,
            '取消',
            '',
            isRed: true,
            onTap: () => Navigator.pop(context),
          ),
        ]),
      ),
    );
  }

  Widget _buildExportOption(
    IconData icon,
    String title,
    String subtitle, {
    bool isRed = false,
    VoidCallback? onTap,
  }) {
    return container.p16.wFull
        .child(
          row.children([
            icon.icon.s24.color(isRed ? Colors.red : Colors.grey[800]).mk,
            w16,
            column.crossStart.expanded.children([
              title.text.f16.color(isRed ? Colors.red : Colors.black).mk,
              if (subtitle.isNotEmpty) ...[
                h4,
                subtitle.text.grey600.f14.mk,
              ],
            ]),
          ]),
        )
        .click(onTap: onTap);
  }

  // 导出图片
  Future<void> _exportImage(ExportType type) async {
    try {
      // 显示加载状态
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: Material(
            color: Colors.transparent,
            child: container.s100.black54.rounded16.center.child(
              column.center.children([
                const CircularProgressIndicator(color: Colors.white),
                h16,
                '处理中...'.text.white.f14.mk,
              ]),
            ),
          ),
        ),
      );

      // TODO: 实现实际的导出逻辑
      await Future.delayed(const Duration(seconds: 1));

      // 关闭加载对话框
      Navigator.pop(context);
      // 关闭导出选项
      Navigator.pop(context);

      // 根据导出类型显示不同的提示
      String message;
      switch (type) {
        case ExportType.original:
          message = '已保存原始图片到相册';
        case ExportType.compressed:
          message = '已保存压缩图片到相册';
        case ExportType.share:
          message = '准备分享图片';
        case ExportType.wallpaper:
          message = '已设置为壁纸';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: message.text.white.mk),
      );

      // 如果是分享，打开分享菜单
      if (type == ExportType.share) {
        // TODO: 实现分享功能
      }

      // 导出成功后返回
      Navigator.pop(context, true);
    } catch (e) {
      // 关闭加载对话框
      Navigator.pop(context);
      // 关闭导出选项
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '导出失败'.text.white.mk),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: '编辑图片'.text.white.f20.bold.mk,
        actions: [
          container.blue.rounded8.p12.ph16.m8.center
              .child('完成'.text.white.f14.bold.mk)
              .click(onTap: _showExportOptions),
        ],
      ),
      body: column.children([
        // 图片编辑区域
        Expanded(
          child: Stack(
            children: [
              // 基础图片
              Transform.rotate(
                angle: _rotation,
                child: Transform.scale(
                  scale: _scale,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(_getColorMatrix()),
                    child: widget.imageUrl.image.wFull.cover.mk,
                  ),
                ),
              ),
              // 裁剪框
              if (_editMode == EditMode.crop && _cropRect != null) _buildCropOverlay(),
              // 绘画层
              if (_editMode == EditMode.draw)
                GestureDetector(
                  onPanStart: _onDrawingPanStart,
                  onPanUpdate: _onDrawingPanUpdate,
                  onPanEnd: _onDrawingPanEnd,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: DrawingPainter(_drawingPoints),
                  ),
                ),
              // 文字和贴纸层
              if (_editMode == EditMode.text || _editMode == EditMode.sticker)
                Stack(
                  children: _items.map(_buildEditableItem).toList(),
                ),
            ],
          ),
        ),
        // 底部工具栏
        container.black.p16.child(
          column.children([
            // 编辑模式选择
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: row.children([
                _buildModeButton(EditMode.filter, Icons.filter, '滤镜'),
                _buildModeButton(EditMode.adjust, Icons.tune, '调整'),
                _buildModeButton(EditMode.crop, Icons.crop, '裁剪'),
                _buildModeButton(EditMode.rotate, Icons.rotate_right, '旋转'),
                _buildModeButton(EditMode.draw, Icons.brush, '画笔'),
                _buildModeButton(EditMode.text, Icons.text_fields, '文字'),
                _buildModeButton(EditMode.sticker, Icons.emoji_emotions, '贴纸'),
              ]),
            ),
            h16,
            // 当前模式的工具选项
            _buildModeOptions(),
          ]),
        ),
      ]),
    );
  }

  // 构建编辑模式按钮
  Widget _buildModeButton(EditMode mode, IconData icon, String label) {
    final isSelected = _editMode == mode;
    return container.mr16.child(
      column.center.children([
        container.s50.circle
            .color(isSelected ? Colors.blue : Colors.grey[800])
            .center
            .child(icon.icon.white.s24.mk)
            .click(onTap: () => setState(() => _editMode = mode)),
        h8,
        label.text.white.f12.mk,
      ]),
    );
  }

  // 构建当前模式的工具选项
  Widget _buildModeOptions() {
    switch (_editMode) {
      case EditMode.filter:
        return _buildFilterOptions();
      case EditMode.adjust:
        return _buildAdjustOptions();
      case EditMode.crop:
        return _buildCropOptions();
      case EditMode.rotate:
        return _buildRotateOptions();
      case EditMode.draw:
        return _buildDrawOptions();
      case EditMode.text:
        return _buildTextOptions();
      case EditMode.sticker:
        return _buildStickerOptions();
    }
  }

  // ... 其他现有方法保持不变 ...

  // 新增方法
  Widget _buildCropOverlay() {
    return CustomPaint(
      painter: CropPainter(_cropRect!),
      child: GestureDetector(
        onPanUpdate: _onCropPanUpdate,
      ),
    );
  }

  Widget _buildRotateOptions() {
    return Slider(
      value: _rotation,
      min: -pi,
      max: pi,
      onChanged: (value) => setState(() => _rotation = value),
    );
  }

  Widget _buildDrawOptions() {
    return column.children([
      // 颜色选择器
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: row.children([
          for (final color in [
            Colors.red,
            Colors.blue,
            Colors.green,
            Colors.yellow,
            Colors.purple,
            Colors.orange,
          ])
            container.s40.circle
                .color(color)
                .border2
                .borderWhite
                .mr8
                .click(onTap: () => setState(() => _drawingColor = color)),
        ]),
      ),
      h16,
      // 画笔���细
      Slider(
        value: _drawingWidth,
        min: 1,
        max: 20,
        onChanged: (value) => setState(() => _drawingWidth = value),
      ),
    ]);
  }

  Widget _buildTextOptions() {
    return row.children([
      container.blue.rounded8.p12.expanded.center.child('添加文字'.text.white.f14.bold.mk).click(onTap: _addText),
      if (_selectedItem != null && _selectedItem is TextItem) ...[
        w16,
        container.grey200.rounded8.p12.expanded.center
            .child('编辑文字'.text.grey800.f14.bold.mk)
            .click(onTap: _editSelectedText),
      ],
    ]);
  }

  Widget _buildStickerOptions() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 8,
      itemBuilder: (context, index) =>
          container.grey100.rounded8.center.child('😀'.text.f32.mk).click(onTap: () => _addSticker('😀')),
    );
  }

  void _onDrawingPanStart(DragStartDetails details) {
    final point = DrawingPoint(
      point: details.localPosition,
      color: _drawingColor,
      width: _drawingWidth,
    );
    setState(() => _drawingPoints.add(point));
  }

  void _onDrawingPanUpdate(DragUpdateDetails details) {
    final point = DrawingPoint(
      point: details.localPosition,
      color: _drawingColor,
      width: _drawingWidth,
    );
    setState(() => _drawingPoints.add(point));
  }

  void _onDrawingPanEnd(DragEndDetails details) {
    setState(() => _drawingPoints.add(DrawingPoint.end));
  }

  void _addText([String? value]) {
    final item = TextItem(
      text: value ?? '双击添加文字',
      position: const Offset(100, 100),
      color: Colors.white,
      fontSize: 20,
    );
    setState(() => _items.add(item));
  }

  void _editSelectedText() {
    if (_selectedItem is TextItem) {
      // 显示文字编辑对话框
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: '编辑文字'.text.f16.bold.mk,
          content: TextField(
            controller: TextEditingController(text: (_selectedItem! as TextItem).text),
            onChanged: (value) {
              setState(() {
                final index = _items.indexOf(_selectedItem!);
                _items[index] = (_selectedItem! as TextItem).copyWith(text: value);
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: '确定'.text.blue.f14.bold.mk,
            ),
          ],
        ),
      );
    }
  }

  void _addSticker(String emoji) {
    final item = StickerItem(
      emoji: emoji,
      position: const Offset(100, 100),
      scale: 1,
      rotation: 0,
    );
    setState(() => _items.add(item));
  }

  Widget _buildEditableItem(EditableItem item) {
    return Positioned(
      left: item.position.dx,
      top: item.position.dy,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _selectedItem = item),
        onPanUpdate: (details) {
          setState(() {
            final index = _items.indexOf(item);
            _items[index] = item.copyWith(
              position: item.position + details.delta,
            );
          });
        },
        child: item is TextItem
            ? item.text.text.color(item.color).f(item.fontSize).mk
            : (item as StickerItem).emoji.text.f32.mk,
      ),
    );
  }

  Widget _buildFilterOptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: row.children([
        _buildFilterOption('原图', isSelected: !_isBlackAndWhite),
        _buildFilterOption('黑白', isSelected: _isBlackAndWhite),
      ]),
    );
  }

  Widget _buildAdjustOptions() {
    return column.children([
      _buildAdjustmentSlider(
        '亮度',
        Icons.brightness_6,
        _brightness,
        -1,
        1,
        (value) => setState(() => _brightness = value),
      ),
      _buildAdjustmentSlider(
        '对比度',
        Icons.contrast,
        _contrast,
        0,
        2,
        (value) => setState(() => _contrast = value),
      ),
      _buildAdjustmentSlider(
        '饱和度',
        Icons.palette,
        _saturation,
        0,
        2,
        (value) => setState(() => _saturation = value),
      ),
    ]);
  }

  Widget _buildCropOptions() {
    return row.spaceEvenly.children([
      _buildCropButton('1:1', const Size(1, 1)),
      _buildCropButton('4:3', const Size(4, 3)),
      _buildCropButton('16:9', const Size(16, 9)),
      _buildCropButton('自由', null),
    ]);
  }

  Widget _buildCropButton(String label, Size? ratio) {
    return container.grey200.rounded8.p12.ph24.center
        .child(label.text.grey800.f14.bold.mk)
        .click(onTap: () => _applyCropRatio(ratio));
  }

  void _applyCropRatio(Size? ratio) {
    if (ratio == null) {
      setState(() => _cropRect = null);
      return;
    }

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = width * ratio.height / ratio.width;
    final top = (size.height - height) / 2;

    setState(() {
      _cropRect = Rect.fromLTWH(0, top, width, height);
    });
  }

  void _onCropPanUpdate(DragUpdateDetails details) {
    if (_cropRect == null) return;
    setState(() {
      _cropRect = _cropRect!.translate(
        details.delta.dx,
        details.delta.dy,
      );
    });
  }

  void _onComplete() {
    // TODO: 处理图片编辑完成
    Navigator.pop(context);
  }

  List<double> _getColorMatrix() {
    // 基础矩阵
    final matrix = List<num>.from([
      _contrast,
      0,
      0,
      0,
      _brightness * 255,
      0,
      _contrast,
      0,
      0,
      _brightness * 255,
      0,
      0,
      _contrast,
      0,
      _brightness * 255,
      0,
      0,
      0,
      1,
      0,
    ]);

    // 应用饱和度
    final s = _saturation;
    final sr = 0.3086 * (1 - s);
    final sg = 0.6094 * (1 - s);
    final sb = 0.0820 * (1 - s);

    matrix[0] = sr + s;
    matrix[1] = sg;
    matrix[2] = sb;
    matrix[5] = sr;
    matrix[6] = sg + s;
    matrix[7] = sb;
    matrix[10] = sr;
    matrix[11] = sg;
    matrix[12] = sb + s;

    // 应用黑白效果
    if (_isBlackAndWhite) {
      const r = 0.2126;
      const g = 0.7152;
      const b = 0.0722;

      matrix[0] = matrix[5] = matrix[10] = r;
      matrix[1] = matrix[6] = matrix[11] = g;
      matrix[2] = matrix[7] = matrix[12] = b;
    }

    return matrix.map((v) => v.toDouble()).toList();
  }
}

// 裁剪画布
class CropPainter extends CustomPainter {
  final Rect rect;

  CropPainter(this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;

    // 绘制半透明背景
    canvas.drawRect(Offset.zero & size, paint);

    // 清除裁剪区域
    canvas.drawRect(rect, Paint()..blendMode = BlendMode.clear);

    // 绘制裁剪框
    paint
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(rect, paint);

    // 绘制网格线
    paint.strokeWidth = 1;
    final dx = rect.width / 3;
    final dy = rect.height / 3;

    for (var i = 1; i < 3; i++) {
      canvas.drawLine(
        rect.topLeft + Offset(dx * i, 0),
        rect.bottomLeft + Offset(dx * i, 0),
        paint,
      );
      canvas.drawLine(
        rect.topLeft + Offset(0, dy * i),
        rect.topRight + Offset(0, dy * i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 绘画点类
class DrawingPoint {
  final Offset? point;
  final Color color;
  final double width;

  const DrawingPoint({
    this.point,
    this.color = Colors.red,
    this.width = 5.0,
  });

  static DrawingPoint get end => const DrawingPoint();
}

// 绘画画布
class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < points.length - 1; i++) {
      if (points[i].point == null || points[i + 1].point == null) continue;
      canvas.drawLine(
        points[i].point!,
        points[i + 1].point!,
        Paint()
          ..color = points[i].color
          ..strokeWidth = points[i].width
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 可编辑项基类
abstract class EditableItem {
  final Offset position;

  const EditableItem({required this.position});

  EditableItem copyWith({Offset? position});
}

// 文字项
class TextItem extends EditableItem {
  final String text;
  final Color color;
  final double fontSize;

  const TextItem({
    required super.position,
    required this.text,
    required this.color,
    required this.fontSize,
  });

  @override
  TextItem copyWith({
    Offset? position,
    String? text,
    Color? color,
    double? fontSize,
  }) {
    return TextItem(
      position: position ?? this.position,
      text: text ?? this.text,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}

// 贴纸项
class StickerItem extends EditableItem {
  final String emoji;
  final double scale;
  final double rotation;

  const StickerItem({
    required super.position,
    required this.emoji,
    required this.scale,
    required this.rotation,
  });

  @override
  StickerItem copyWith({
    Offset? position,
    String? emoji,
    double? scale,
    double? rotation,
  }) {
    return StickerItem(
      position: position ?? this.position,
      emoji: emoji ?? this.emoji,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
    );
  }
}
