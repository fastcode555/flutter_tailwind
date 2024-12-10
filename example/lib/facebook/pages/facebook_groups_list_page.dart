import 'package:example/facebook/models/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookGroupsListPage extends StatelessWidget {
  const FacebookGroupsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: const TabBar(
            tabs: [
              Tab(text: '你的群组'),
              Tab(text: '发现'),
              Tab(text: '邀请'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildYourGroups(),
            _buildDiscoverGroups(),
            _buildInvites(),
          ],
        ),
      ),
    );
  }

  Widget _buildYourGroups() {
    return ListView(
      children: [
        // 创建群组按钮
        container.white.p16.child(
          container.blue.rounded8.p12.wFull.center.child(
            '创建新群组'.text.white.f14.bold.mk,
          ),
        ),
        h8,
        // 群组列表
        ...groups.where((g) => g.isJoined).map(_buildGroupItem),
      ],
    );
  }

  Widget _buildDiscoverGroups() {
    return ListView(
      children: [
        // 分类选择
        container.white.p16.child(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: row.children([
              _buildCategoryChip('全部'),
              _buildCategoryChip('科技'),
              _buildCategoryChip('教育'),
              _buildCategoryChip('娱乐'),
              _buildCategoryChip('生活'),
              _buildCategoryChip('运动'),
            ]),
          ),
        ),
        h8,
        // 推荐群组
        container.white.p16.child(
          column.crossStart.children([
            '为你推荐'.text.f16.bold.mk,
            h16,
            ...groups.where((g) => !g.isJoined).map(_buildGroupItem),
          ]),
        ),
      ],
    );
  }

  Widget _buildInvites() {
    return ListView(
      children: [
        container.white.p16.child(
          column.crossStart.children([
            '群组邀请'.text.f16.bold.mk,
            h16,
            _buildInviteItem(),
            _buildInviteItem(),
          ]),
        ),
      ],
    );
  }

  Widget _buildGroupItem(Group group) {
    return container.white.borderB1.borderGrey200.child(
      container.p16.child(
        column.crossStart.children([
          // 群组封面
          group.coverUrl.image.wFull.h120.rounded8.cover.mk,
          h12,
          // 群组信息
          group.name.text.f16.bold.mk,
          h4,
          row.children([
            Icons.public.icon.grey600.s14.mk,
            w4,
            (group.isPublic ? '公开群组' : '私密群组').text.grey600.f14.mk,
            w8,
            '·'.text.grey600.f14.mk,
            w8,
            '${group.members} 成员'.text.grey600.f14.mk,
          ]),
          h12,
          // 加入按钮
          if (!group.isJoined)
            container.blue.rounded8.p12.wFull.center.child(
              '加入群组'.text.white.f14.bold.mk,
            ),
        ]),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return container.grey100.rounded16.p8.ph16.mr8.child(
      label.text.f14.mk,
    );
  }

  Widget _buildInviteItem() {
    return container.white.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          'https://picsum.photos/200'.image.s60.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            h4,
            '邀请你加入「Flutter 开发者社区」'.text.grey600.f14.mk,
            h8,
            row.children([
              container.blue.rounded8.p8.ph16.expanded.center.child(
                '接受'.text.white.f14.bold.mk,
              ),
              w8,
              container.grey200.rounded8.p8.ph16.expanded.center.child(
                '忽略'.text.grey800.f14.bold.mk,
              ),
            ]),
          ]),
        ]),
      ),
    );
  }
}
