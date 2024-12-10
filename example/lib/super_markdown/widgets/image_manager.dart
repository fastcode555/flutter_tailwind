import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ImageManager extends StatefulWidget {
  final List<String> initialImages;
  final ValueChanged<List<String>> onChanged;

  const ImageManager({
    required this.onChanged,
    super.key,
    this.initialImages = const [],
  });

  @override
  State<ImageManager> createState() => _ImageManagerState();
}

class _ImageManagerState extends State<ImageManager> {
  final List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _images.addAll(widget.initialImages);
  }

  Future<void> _pickImage() async {
    // TODO: 实现图片选择
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      widget.onChanged(_images);
    });
  }

  @override
  Widget build(BuildContext context) {
    return column.crossStart.children([
      // 图片列表
      if (_images.isNotEmpty)
        container.h120.child(
          ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _images.length,
            separatorBuilder: (_, __) => w8,
            itemBuilder: (context, index) => _buildImageItem(index),
          ),
        ),

      h16,

      // 添加按钮
      container.grey100.rounded8.p16.center
          .child(
            column.center.children([
              Icons.add_photo_alternate.icon.grey600.s32.mk,
              h8,
              '添加图片'.text.grey600.f14.mk,
            ]),
          )
          .click(onTap: _pickImage),
    ]);
  }

  Widget _buildImageItem(int index) {
    return Stack(
      children: [
        _images[index].image.s100.rounded8.cover.mk,
        positioned.r4.t4.child(
          container.red.circle.s24.center.child(Icons.close.icon.white.s16.mk).click(onTap: () => _removeImage(index)),
        ),
      ],
    );
  }
}
