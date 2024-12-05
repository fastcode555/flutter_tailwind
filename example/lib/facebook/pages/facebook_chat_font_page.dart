import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookChatFontPage extends StatelessWidget {
  const FacebookChatFontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '字体设置'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 预览区域
          container.white.p16.child(
            column.crossStart.children([
              '预览效果'.text.grey600.f14.mk,
              h16,
              container.grey100.rounded12.p16.wFull.child(
                column.crossStart.children([
                  row.children([
                    'https://picsum.photos/200'.image.s40.circle.mk,
                    w12,
                    '你好，最近怎么样？'.text.f16.mk,
                  ]),
                  h16,
                  row.end.children([
                    '挺好的，在学习Flutter'.text.f16.mk,
                    w12,
                    'https://picsum.photos/201'.image.s40.circle.mk,
                  ]),
                ]),
              ),
            ]),
          ),
          h8,
          // 字体大小
          _buildSection('字体大小', [
            _buildSliderItem('聊天字体', 16),
            _buildSliderItem('昵称字体', 14),
            _buildSliderItem('时间字体', 12),
          ]),
          h8,
          // 字体样式
          _buildSection('字体样式', [
            _buildFontItem('系统默认', 'System'),
            _buildFontItem('苹方', 'PingFang SC'),
            _buildFontItem('黑体', 'Heiti SC'),
            _buildFontItem('圆体', 'Yuanti SC'),
          ]),
          h8,
          // 其他设置
          _buildSection('其他设置', [
            _buildSettingItem('粗体显示', false),
            _buildSettingItem('斜体显示', false),
            _buildSettingItem('下划线', false),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return container.white.child(
      column.crossStart.children([
        container.p16.child(
          title.text.grey600.f14.mk,
        ),
        ...items,
      ]),
    );
  }

  Widget _buildSliderItem(String label, double value) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        column.crossStart.children([
          label.text.f16.mk,
          h8,
          row.children([
            'A'.text.f12.grey600.mk,
            Expanded(
              child: Slider(
                value: value,
                min: 12,
                max: 24,
                onChanged: (_) {},
              ),
            ),
            'A'.text.f20.grey600.mk,
          ]),
        ]),
      ),
    );
  }

  Widget _buildFontItem(String label, String fontFamily) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.fontFamily(fontFamily).mk,
          Radio(
            value: true,
            groupValue: fontFamily == 'System',
            onChanged: (_) {},
          ),
        ]),
      ),
    );
  }

  Widget _buildSettingItem(String label, bool value) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          Switch(
            value: value,
            onChanged: (_) {},
          ),
        ]),
      ),
    );
  }
}
