import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookGroupSettingsPage extends StatelessWidget {
  const FacebookGroupSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '群组设置'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          _buildSection('基本设置', [
            _buildSettingItem(Icons.edit, '编辑群组信息'),
            _buildSettingItem(Icons.public, '隐私设置'),
            _buildSettingItem(Icons.notifications, '通知设置'),
          ]),
          h8,
          _buildSection('成员管理', [
            _buildSettingItem(Icons.group, '成员列表'),
            _buildSettingItem(Icons.person_add, '邀请成员'),
            _buildSettingItem(Icons.block, '已屏蔽成员'),
          ]),
          h8,
          _buildSection('内容管理', [
            _buildSettingItem(Icons.post_add, '帖子审核'),
            _buildSettingItem(Icons.comment, '评论设置'),
            _buildSettingItem(Icons.report, '举报管理'),
          ]),
          h8,
          _buildSection('高级设置', [
            _buildSettingItem(Icons.archive, '群组归档'),
            _buildSettingItem(Icons.delete_outline, '删除群组', isRed: true),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return container.white.child(
      column.crossStart.children([
        container.p16.child(
          title.text.grey600.f14.mk,
        ),
        ...items,
      ]),
    );
  }

  Widget _buildSettingItem(IconData icon, String label, {bool isRed = false}) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          icon.icon.s24.color(isRed ? Colors.red : Colors.grey[800]).mk,
          w16,
          label.text.f16.color(isRed ? Colors.red : Colors.black).mk,
          const Spacer(),
          Icons.chevron_right.icon.grey600.s24.mk,
        ]),
      ),
    );
  }
}
