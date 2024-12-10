import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookGroupsPage extends StatelessWidget {
  const FacebookGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '群组'.text.f20.bold.mk,
        actions: [
          container.s40.circle.grey100.center.child(
            Icons.search.icon.grey800.s24.mk,
          ),
          w16,
          container.s40.circle.grey100.center.child(
            Icons.add.icon.grey800.s24.mk,
          ),
          w16,
        ],
      ),
      body: listview.builder(
        10,
        (context, index) => _buildGroupItem(),
      ),
    );
  }

  Widget _buildGroupItem() {
    return container.white.mb8.child(column.children([
      // 群组封面
      container.h120.child(
        'https://picsum.photos/500/200'.image.wFull.cover.mk,
      ),
      // 群组信息
      container.p16.child(column.crossStart.children([
        '群组名称'.text.f16.bold.mk,
        h4,
        row.children([
          Icons.public.icon.grey600.s14.mk,
          w4,
          '公开群组'.text.grey600.f14.mk,
          w8,
          '·'.text.grey600.f14.mk,
          w8,
          '1.2k 成员'.text.grey600.f14.mk,
        ]),
        h12,
        container.blue.rounded8.p12.wFull.center.child(
          '加入群组'.text.white.f14.bold.mk,
        ),
      ])),
    ]));
  }
}
