import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ColorDropper extends StatefulWidget {
  final ValueChanged<Color> onColorPicked;
  final VoidCallback onCancel;

  const ColorDropper({
    required this.onColorPicked, required this.onCancel, super.key,
  });

  @override
  State<ColorDropper> createState() => _ColorDropperState();
}

class _ColorDropperState extends State<ColorDropper> {
  Color _currentColor = Colors.transparent;
  Offset _position = Offset.zero;
  final bool _isActive = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    var renderObject = context.findRenderObject();
    if (renderObject == null) return;

    // 监听鼠标移动
    GestureBinding.instance.pointerRouter.addGlobalRoute((PointerEvent event) {
      if (event is PointerMoveEvent) {
        _updateColorAtPosition(event.position);
      }
    });
  }

  void _updateColorAtPosition(Offset position) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 16), () {
      setState(() {
        _position = position;
        // 获取位置处的颜色
        _captureColorAtPosition(position).then((color) {
          if (mounted) {
            setState(() => _currentColor = color);
          }
        });
      });
    });
  }

  Future<Color> _captureColorAtPosition(Offset position) async {
    try {
      // 获取屏幕截图
      final pixelRatio = MediaQuery.of(context).devicePixelRatio;
      final image = await _takeScreenshot(pixelRatio);
      if (image == null) return Colors.transparent;

      // 计算实际像素位置
      final x = (position.dx * pixelRatio).round();
      final y = (position.dy * pixelRatio).round();

      // 确保位置在图片范围内
      if (x < 0 || x >= image.width || y < 0 || y >= image.height) {
        return Colors.transparent;
      }

      // 获取像素数据
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      if (bytes == null) return Colors.transparent;

      // 计算像素位置
      final offset = (y * image.width + x) * 4;
      final r = bytes.getUint8(offset);
      final g = bytes.getUint8(offset + 1);
      final b = bytes.getUint8(offset + 2);
      final a = bytes.getUint8(offset + 3);

      return Color.fromARGB(a, r, g, b);
    } catch (e) {
      debugPrint('Error capturing color: $e');
      return Colors.transparent;
    }
  }

  // 获取屏幕截图
  Future<ui.Image?> _takeScreenshot(double pixelRatio) async {
    try {
      final boundary = context.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: pixelRatio);
      return image;
    } catch (e) {
      debugPrint('Error taking screenshot: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
          // 全屏遮罩
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (details) {
                widget.onColorPicked(_currentColor);
              },
              onSecondaryTapDown: (_) {
                widget.onCancel();
              },
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: '点击选择颜色，右键取消'.text.white.f16.mk,
                ),
              ),
            ),
          ),

          // 放大镜
          if (_isActive)
            Positioned(
              left: _position.dx - 75,
              top: _position.dy - 75,
              child: _buildMagnifier(),
            ),

          // 颜色信息
          if (_isActive)
            Positioned(
              left: _position.dx + 20,
              top: _position.dy + 20,
              child: _buildColorInfo(),
            ),
        ],
      ),
    );
  }

  Widget _buildMagnifier() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ui.ImageFilter.matrix(Matrix4.diagonal3Values(5, 5, 1).storage),
          child: Container(
            color: _currentColor,
          ),
        ),
      ),
    );
  }

  Widget _buildColorInfo() {
    return container.white.rounded8.p8.cardShadow.child(
      column.crossStart.children([
        // 颜色预览
        container.w40.h20.rounded4.color(_currentColor).mk,
        // HEX值
        '#${_currentColor.value.toRadixString(16).toUpperCase().padLeft(8, '0')}'.text.f12.mk,
        // RGB值
        'RGB(${_currentColor.red}, ${_currentColor.green}, ${_currentColor.blue})'.text.f12.mk,
      ]),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    GestureBinding.instance.pointerRouter.removeGlobalRoute((PointerEvent event) {});
    super.dispose();
  }
}
