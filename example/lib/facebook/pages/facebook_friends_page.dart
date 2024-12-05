import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookFriendsPage extends StatelessWidget {
  const FacebookFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '好友'.text.f20.bold.mk,
        actions: [
          container.s40.circle.grey100.center.child(
            Icons.search.icon.grey800.s24.mk,
          ),
          w16,
        ],
      ),
      body: ListView(children: [
        // 好友请求
        container.white.p16.child(
          column.crossStart.children([
            '好友请求'.text.f16.bold.mk,
            h16,
          ]),
        ),
        h8,
        // 所有好友
        container.white.p16.child(
          column.crossStart.children([
            '所有好友'.text.f16.bold.mk,
            h16,
            _buildFriendItem(),
            _buildFriendItem(),
            _buildFriendItem(),
          ]),
        ),
      ]),
    );
  }

  Widget _buildFriendItem() {
    return container.borderB1.borderGrey200.pv16.child(
      row.children([
        'https://picsum.photos/200'.image.s60.circle.mk,
        w12,
        column.crossStart.expanded.children([
          'John Doe'.text.f16.bold.mk,
          h4,
          '5个共同好友'.text.grey600.f14.mk,
        ]),
        container.s40.circle.grey100.center.child(
          Icons.more_horiz.icon.grey800.s24.mk,
        ),
      ]),
    );
  }
}
