import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookBlockListPage extends StatelessWidget {
  const FacebookBlockListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '黑名单'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 黑名单说明
          container.white.p16.child(
            '被加入黑名单的用户将无法看到你的动态、给你发消息或添加你为好友。'.text.grey600.f14.mk,
          ),
          h8,
          // 黑名单列表
          container.white.child(
            column.children([
              _buildBlockedItem(),
              _buildBlockedItem(),
              _buildBlockedItem(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildBlockedItem() {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          'https://picsum.photos/200'.image.s50.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            h4,
            '已屏蔽'.text.grey600.f14.mk,
          ]),
          container.blue.rounded8.p8.ph16.center.child(
            '解除屏蔽'.text.white.f14.bold.mk,
          ),
        ]),
      ),
    );
  }
}
