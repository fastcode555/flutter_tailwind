import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookChatPrivacyPage extends StatelessWidget {
  const FacebookChatPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '聊天隐私'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          _buildSection('消息设置', [
            _buildSettingItem('已读回执', true),
            _buildSettingItem('输入状态', true),
            _buildSettingItem('在线状态', true),
          ]),
          h8,
          _buildSection('权限设置', [
            _buildActionItem('谁可以给我发消息', '所有人'),
            _buildActionItem('谁可以看到我的在线状态', '好友'),
            _buildActionItem('黑名单管理', '3人'),
          ]),
          h8,
          _buildSection('安全设置', [
            _buildSettingItem('消息加密', true),
            _buildSettingItem('指纹解锁', false),
            _buildActionItem('修改聊天密码', null),
          ]),
          h8,
          _buildSection('存储设置', [
            _buildSettingItem('自动下载图片', true),
            _buildSettingItem('自动下载视频', false),
            _buildActionItem('清理聊天记录', '1.2GB'),
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

  Widget _buildActionItem(String label, String? value) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          label.text.f16.mk,
          const Spacer(),
          if (value != null) value.text.grey600.f14.mk,
          w8,
          Icons.chevron_right.icon.grey600.s24.mk,
        ]),
      ),
    );
  }
} 