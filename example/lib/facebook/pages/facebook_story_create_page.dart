import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookStoryCreatePage extends StatefulWidget {
  const FacebookStoryCreatePage({super.key});

  @override
  State<FacebookStoryCreatePage> createState() => _FacebookStoryCreatePageState();
}

class _FacebookStoryCreatePageState extends State<FacebookStoryCreatePage> {
  String? _selectedImage;
  String _text = '';
  Color _textColor = Colors.white;
  double _fontSize = 24;
  final Color _backgroundColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icons.close.icon.white.s24.mk,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          container.blue.rounded8.p12.ph16.m8.center.child('分享故事'.text.white.f14.bold.mk).click(onTap: _shareStory),
        ],
      ),
      body: Stack(
        children: [
          // 背景图片或颜色
          if (_selectedImage != null)
            _selectedImage!.image.wFull.hFull.cover.mk
          else
            container.wFull.hFull.color(_backgroundColor).mk,

          // 文字内容
          if (_text.isNotEmpty)
            Center(
              child: _text.text.color(_textColor).f(_fontSize).center.mk,
            ),

          // 底部工具栏
          positioned.b0.l0.r0.child(
            container.black54.p16.child(
              column.children([
                // 文字输入框
                container.white12.rounded24.p12.child(
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: '输入文字...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => setState(() => _text = value),
                  ),
                ),
                h16,
                // 工具选项
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: row.children([
                    _buildToolButton(
                      Icons.image,
                      '添加图片',
                      onTap: _pickImage,
                    ),
                    _buildToolButton(
                      Icons.color_lens,
                      '文字颜色',
                      onTap: _showColorPicker,
                    ),
                    _buildToolButton(
                      Icons.text_fields,
                      '字体大小',
                      onTap: _showFontSizeOptions,
                    ),
                    _buildToolButton(
                      Icons.format_paint,
                      '背景颜色',
                      onTap: _showBackgroundColorPicker,
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(
    IconData icon,
    String label, {
    VoidCallback? onTap,
  }) {
    return container.mr16.child(
      column.center.children([
        container.s50.circle.black54.center.child(icon.icon.white.s24.mk).click(onTap: onTap),
        h8,
        label.text.white.f12.mk,
      ]),
    );
  }

  Future<void> _pickImage() async {
    // TODO: 实现图片选择
    setState(() => _selectedImage = 'https://picsum.photos/500/800');
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.p16.child(
        column.crossStart.children([
          '文字颜色'.text.f16.bold.mk,
          h16,
          wrap.spacing16.runSpacing16.children(
            [
              Colors.white,
              Colors.black,
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.purple,
              Colors.orange,
            ].map(_buildColorOption).toList(),
          ),
        ]),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return container.s50.circle.color(color).border2.borderGrey200.click(onTap: () {
      setState(() => _textColor = color);
      Navigator.pop(context);
    });
  }

  void _showFontSizeOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.p16.child(
        column.crossStart.children([
          '字体大小'.text.f16.bold.mk,
          h16,
          Slider(
            value: _fontSize,
            min: 16,
            max: 48,
            divisions: 8,
            label: _fontSize.round().toString(),
            onChanged: (value) => setState(() => _fontSize = value),
          ),
        ]),
      ),
    );
  }

  void _showBackgroundColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.p16.child(
        column.crossStart.children([
          '背景颜色'.text.f16.bold.mk,
          h16,
          wrap.spacing16.runSpacing16.children(
            [
              Colors.black,
              Colors.blue,
              Colors.red,
              Colors.green,
              Colors.purple,
              Colors.orange,
              Colors.teal,
              Colors.indigo,
            ].map(_buildColorOption).toList(),
          ),
        ]),
      ),
    );
  }

  void _shareStory() {
    // TODO: 实现故事分享
    Navigator.pop(context);
  }
}
