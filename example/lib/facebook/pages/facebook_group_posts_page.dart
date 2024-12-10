import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookGroupPostsPage extends StatelessWidget {
  const FacebookGroupPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: '帖子管理'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '待审核'),
              Tab(text: '已发布'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPendingPosts(),
            _buildPublishedPosts(),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingPosts() {
    return ListView(
      children: [
        container.white.p16.child(
          column.crossStart.children([
            '待审核帖子'.text.f16.bold.mk,
            h16,
            _buildPostItem(isPending: true),
            _buildPostItem(isPending: true),
          ]),
        ),
      ],
    );
  }

  Widget _buildPublishedPosts() {
    return ListView(
      children: [
        container.white.p16.child(
          column.crossStart.children([
            '已发布帖子'.text.f16.bold.mk,
            h16,
            _buildPostItem(),
            _buildPostItem(),
          ]),
        ),
      ],
    );
  }

  Widget _buildPostItem({bool isPending = false}) {
    return container.borderB1.borderGrey200.pv16.child(
      column.crossStart.children([
        row.children([
          'https://picsum.photos/200'.image.s40.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            '2小时前'.text.grey600.f14.mk,
          ]),
          if (isPending)
            row.children([
              container.blue.rounded8.p8.ph16.center.child(
                '通过'.text.white.f14.bold.mk,
              ),
              w8,
              container.grey200.rounded8.p8.ph16.center.child(
                '拒绝'.text.grey800.f14.bold.mk,
              ),
            ])
          else
            container.s40.circle.grey100.center.child(
              Icons.more_horiz.icon.grey800.s24.mk,
            ),
        ]),
        h8,
        '这是一条帖子内容...'.text.f16.mk,
        if (isPending)
          container.mt8.grey100.rounded8.p12.wFull.child(
            row.children([
              Icons.warning.icon.amber.s24.mk,
              w12,
              '需要审核'.text.grey600.f14.expanded.mk,
            ]),
          ),
      ]),
    );
  }
}
