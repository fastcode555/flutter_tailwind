import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookChatSettingsPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const FacebookChatSettingsPage({
    required this.userName,
    required this.userAvatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '聊天设置'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 用户信息
          container.white.p16.child(
            column.center.children([
              userAvatar.image.s80.circle.mk,
              h16,
              userName.text.f20.bold.mk,
              h8,
              '在线'.text.grey600.f14.mk,
            ]),
          ),
          h8,
          // 快捷操作
          _buildSection('快捷操作', [
            _buildActionItem(Icons.videocam, '视频通话', onTap: () {}),
            _buildActionItem(Icons.phone, '语音通话', onTap: () {}),
            _buildActionItem(Icons.search, '搜索聊天记录', onTap: () {}),
          ]),
          h8,
          // 聊天设置
          _buildSection('聊天设置', [
            _buildSettingItem('消息通知', true),
            _buildSettingItem('聊天气泡颜色', false, showColor: true),
            _buildSettingItem('显示在线状态', true),
          ]),
          h8,
          // 隐私设置
          _buildSection('隐私设置', [
            _buildActionItem(Icons.block, '屏蔽此人', isRed: true),
            _buildActionItem(Icons.report, '举报', isRed: true),
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

  Widget _buildActionItem(
    IconData icon,
    String label, {
    bool isRed = false,
    VoidCallback? onTap,
  }) {
    return container.borderB1.borderGrey200.child(
      container.p16
          .child(
            row.children([
              icon.icon.s24.color(isRed ? Colors.red : Colors.grey[800]).mk,
              w16,
              label.text.f16.color(isRed ? Colors.red : Colors.black).mk,
              const Spacer(),
              Icons.chevron_right.icon.grey600.s24.mk,
            ]),
          )
          .click(onTap: onTap),
    );
  }

  Widget _buildSettingItem(String label, bool value, {bool showColor = false}) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          if (showColor)
            container.s24.circle.blue.mk
          else
            Switch(
              value: value,
              onChanged: (_) {},
            ),
        ]),
      ),
    );
  }
}
