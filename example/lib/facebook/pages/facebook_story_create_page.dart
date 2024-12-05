import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookStoryCreatePage extends StatefulWidget {
  const FacebookStoryCreatePage({super.key});

  @override
  _FacebookStoryCreatePageState createState() => _FacebookStoryCreatePageState();
}

class _FacebookStoryCreatePageState extends State<FacebookStoryCreatePage> {
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    // 实现图片选择逻辑
  }

  void _publishStory() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icons.close.icon.white.s24.iconClick(
          onTap: () => Navigator.pop(context),
        ),
        actions: [
          container.blue.rounded8.p12.ph16
              .child(
                '分享到故事'.text.white.f14.bold.mk,
              )
              .click(onTap: _publishStory),
          w16,
        ],
      ),
      body: column.children([
        // 预览区域
        Expanded(
          child: container.center.child(
            Icons.add_a_photo.icon.white.s48.mk,
          ),
        ),
        // 底部工具栏
        container.p16.child(
          row.spaceEvenly.children([
            _buildToolButton(Icons.image, '相册'),
            _buildToolButton(Icons.text_fields, '文字'),
            _buildToolButton(Icons.brush, '画笔'),
            _buildToolButton(Icons.emoji_emotions, '贴纸'),
          ]),
        ),
      ]),
    );
  }

  Widget _buildToolButton(IconData icon, String label) {
    return column.center.children([
      icon.icon.white.s24.mk,
      h8,
      label.text.white.f12.mk,
    ]);
  }
}
