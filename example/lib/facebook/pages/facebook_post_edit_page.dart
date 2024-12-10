import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookPostEditPage extends StatelessWidget {
  const FacebookPostEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '创建帖子'.text.f20.bold.mk,
        actions: [
          container.blue.rounded8.p12.ph16.m8.center.child(
            '发布'.text.white.f14.bold.mk,
          ),
        ],
      ),
      body: column.children([
        // 用户信息
        container.white.p16.child(
          row.children([
            'https://picsum.photos/200'.image.s40.circle.mk,
            w12,
            column.crossStart.expanded.children([
              'John Doe'.text.f16.bold.mk,
              container.grey100.rounded16.p4.ph8.child(
                row.center.children([
                  Icons.public.icon.grey600.s16.mk,
                  w4,
                  '公开'.text.grey600.f14.mk,
                  w4,
                  Icons.arrow_drop_down.icon.grey600.s16.mk,
                ]),
              ),
            ]),
          ]),
        ),
        // 内容编辑
        container.white.expanded.child(
          const TextField(
            decoration: InputDecoration(
              hintText: '分享你的想法...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            maxLines: null,
          ),
        ),
        // 底部工具栏
        container.white.borderT1.borderGrey200.p12.child(
          row.spaceEvenly.children([
            _buildToolButton(Icons.image, '图片'),
            _buildToolButton(Icons.person_add, '标记好友'),
            _buildToolButton(Icons.emoji_emotions, '心情'),
            _buildToolButton(Icons.location_on, '位置'),
          ]),
        ),
      ]),
    );
  }

  Widget _buildToolButton(IconData icon, String label) {
    return column.center.children([
      icon.icon.grey800.s24.mk,
      h4,
      label.text.grey600.f12.mk,
    ]);
  }
}
