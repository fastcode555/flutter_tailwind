import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookMessengerPage extends StatelessWidget {
  const FacebookMessengerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '消息'.text.f20.bold.mk,
        actions: [
          container.s40.circle.grey100.center.child(
            Icons.edit.icon.grey800.s24.mk,
          ),
          w16,
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _buildChatItem(),
      ),
    );
  }

  Widget _buildChatItem() {
    return container.p16.child(
      row.children([
        // 头像
        'https://picsum.photos/200'.image.s50.circle.mk,
        w12,
        // 消息内容
        column.crossStart.expanded.children([
          '用户名'.text.f16.bold.mk,
          h4,
          '最新消息内容'.text.grey600.f14.mk,
        ]),
        // 时间
        '12:30'.text.grey600.f12.mk,
      ]),
    );
  }
}
