import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookGroupMembersPage extends StatelessWidget {
  const FacebookGroupMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: '成员管理'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '全部成员'),
              Tab(text: '管理员'),
              Tab(text: '待审核'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAllMembers(),
            _buildAdmins(),
            _buildPendingMembers(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllMembers() {
    return ListView(
      children: [
        // 搜索框
        container.white.p16.child(
          container.grey100.rounded24.p12.wFull.child(
            row.children([
              Icons.search.icon.grey600.s24.mk,
              w12,
              '搜索成员'.text.grey600.f14.expanded.mk,
            ]),
          ),
        ),
        h8,
        // 成员列表
        container.white.child(
          column.children([
            _buildMemberItem(isAdmin: true),
            _buildMemberItem(),
            _buildMemberItem(),
          ]),
        ),
      ],
    );
  }

  Widget _buildAdmins() {
    return ListView(
      children: [
        container.white.child(
          column.children([
            _buildMemberItem(isAdmin: true),
            _buildMemberItem(isAdmin: true),
          ]),
        ),
      ],
    );
  }

  Widget _buildPendingMembers() {
    return ListView(
      children: [
        container.white.child(
          column.children([
            _buildPendingMemberItem(),
            _buildPendingMemberItem(),
          ]),
        ),
      ],
    );
  }

  Widget _buildMemberItem({bool isAdmin = false}) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          'https://picsum.photos/200'.image.s50.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            h4,
            if (isAdmin) '管理员'.text.blue.f14.mk,
          ]),
          container.s40.circle.grey100.center.child(
            Icons.more_horiz.icon.grey800.s24.mk,
          ),
        ]),
      ),
    );
  }

  Widget _buildPendingMemberItem() {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          'https://picsum.photos/200'.image.s50.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            h4,
            '申请加入群组'.text.grey600.f14.mk,
            h8,
            row.children([
              container.blue.rounded8.p8.ph16.expanded.center.child(
                '通过'.text.white.f14.bold.mk,
              ),
              w8,
              container.grey200.rounded8.p8.ph16.expanded.center.child(
                '拒绝'.text.grey800.f14.bold.mk,
              ),
            ]),
          ]),
        ]),
      ),
    );
  }
} 