import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookNotificationsPage extends StatelessWidget {
  const FacebookNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '通知'.text.f20.bold.mk,
      ),
      body: listview.builder(
        10,
        (context, index) => _buildNotificationItem(),
      ),
    );
  }

  Widget _buildNotificationItem() {
    return container.white.borderB1.borderGrey200.child(
      container.p16.child(row.children([
        // 头像或图标
        container.s50.circle.blue.center.child(
          Icons.thumb_up.icon.white.s24.mk,
        ),
        w12,
        // 通知内容
        column.crossStart.expanded.children([
          row.children([
            'John Doe'.text.f16.bold.mk,
            w4,
            '赞了你的帖子'.text.f16.mk,
          ]),
          h4,
          '2小时前'.text.grey600.f14.mk,
        ]),
        // 更多按钮
        Icons.more_horiz.icon.grey600.s24.mk,
      ])),
    );
  }
}
