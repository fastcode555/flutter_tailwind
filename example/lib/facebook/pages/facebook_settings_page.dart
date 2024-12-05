import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookSettingsPage extends StatelessWidget {
  const FacebookSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '设置'.text.f20.bold.mk,
      ),
      body: ListView(children: [
        _buildSection('账号设置', [
          _buildSettingItem(Icons.lock, '隐私设置'),
          _buildSettingItem(Icons.security, '安全和登录'),
          _buildSettingItem(Icons.person, '个人资料设置'),
        ]),
        h8,
        _buildSection('偏好设置', [
          _buildSettingItem(Icons.notifications, '通知'),
          _buildSettingItem(Icons.language, '语言'),
          _buildSettingItem(Icons.dark_mode, '深色模式'),
        ]),
        h8,
        _buildSection('支持', [
          _buildSettingItem(Icons.help, '帮助中心'),
          _buildSettingItem(Icons.info, '关于'),
          _buildSettingItem(Icons.logout, '退出登录', isRed: true),
        ]),
      ]),
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
