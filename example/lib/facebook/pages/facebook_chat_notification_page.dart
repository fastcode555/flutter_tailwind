import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookChatNotificationPage extends StatelessWidget {
  const FacebookChatNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '通知设置'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          _buildSection('消息通知', [
            _buildSettingItem('通知提醒', true),
            _buildSettingItem('声音', true),
            _buildSettingItem('振动', true),
          ]),
          h8,
          _buildSection('通知显示', [
            _buildSettingItem('锁屏显示', true),
            _buildSettingItem('横幅通知', true),
            _buildSettingItem('预览消息内容', false),
          ]),
          h8,
          _buildSection('特别关注', [
            _buildActionItem('特别关注的好友', '2人'),
            _buildSettingItem('特别关注消息置顶', true),
            _buildSettingItem('特别关注消息提示音', true),
          ]),
          h8,
          _buildSection('免打扰时段', [
            _buildSettingItem('开启免打扰', false),
            _buildActionItem('免打扰时段', '23:00 - 7:00'),
            _buildActionItem('例外联系人', '无'),
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

  Widget _buildSettingItem(String label, bool value) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          Switch(
            value: value,
            onChanged: (_) {},
          ),
        ]),
      ),
    );
  }

  Widget _buildActionItem(String label, String value) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          label.text.f16.mk,
          const Spacer(),
          value.text.grey600.f14.mk,
          w8,
          Icons.chevron_right.icon.grey600.s24.mk,
        ]),
      ),
    );
  }
}
