import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookChatBackgroundPage extends StatelessWidget {
  const FacebookChatBackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: '聊天背景'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '纯色'),
              Tab(text: '图片'),
              Tab(text: '自定义'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildColorList(),
            _buildImageList(),
            _buildCustomBackground(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorList() {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
    ];

    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: colors.length,
      itemBuilder: (context, index) => _buildColorItem(colors[index]),
    );
  }

  Widget _buildColorItem(Color color) {
    return container.rounded12.color(color).center.child(
          container.s32.circle.white.center.child(
            Icons.check.icon.color(color).s24.mk,
          ),
        );
  }

  Widget _buildImageList() {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildImageItem(
        'https://picsum.photos/300/400?random=$index',
      ),
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return container.rounded12.child(
      Stack(
        children: [
          imageUrl.image.wFull.hFull.cover.mk,
          positioned.r16.t16.child(
            container.s32.circle.white.center.child(
              Icons.check.icon.blue.s24.mk,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBackground() {
    return container.p16.child(
      column.crossStart.children([
        // 上传图片按钮
        container.grey100.rounded12.p16.wFull.center.child(
          column.center.children([
            Icons.add_photo_alternate.icon.grey600.s48.mk,
            h16,
            '上传图片'.text.grey600.f16.mk,
          ]),
        ),
        h24,
        // 背景设置
        '背景设置'.text.grey600.f14.mk,
        h16,
        _buildSettingItem('模糊效果', true),
        _buildSettingItem('暗色模式', false),
        _buildSettingItem('显示气泡边框', true),
      ]),
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
