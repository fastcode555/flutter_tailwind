import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookFriendRequestsPage extends StatelessWidget {
  const FacebookFriendRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '好友请求'.text.f20.bold.mk,
      ),
      body: ListView(
        children: List.generate(5, (index) => _buildRequestItem()),
      ),
    );
  }

  Widget _buildRequestItem() {
    return container.white.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          'https://picsum.photos/200'.image.s60.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            h4,
            '5个共同好友'.text.grey600.f14.mk,
            h8,
            row.children([
              container.blue.rounded8.p8.ph16.expanded.center.child(
                '接受'.text.white.f14.bold.mk,
              ),
              w8,
              container.grey200.rounded8.p8.ph16.expanded.center.child(
                '删除'.text.grey800.f14.bold.mk,
              ),
            ]),
          ]),
        ]),
      ),
    );
  }
}
