import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookSettingsDetailPage extends StatelessWidget {
  final String title;
  const FacebookSettingsDetailPage({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          if (title == '隐私设置') _buildPrivacySettings(),
          if (title == '通知') _buildNotificationSettings(),
          if (title == '语言') _buildLanguageSettings(),
          if (title == '深色模式') _buildDarkModeSettings(),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return column.children([
      _buildSection('帖子隐私', [
        _buildSwitchItem('允许他人分享我的帖子', true),
        _buildSwitchItem('允许他人评论我的帖子', true),
      ]),
      h8,
      _buildSection('个人资料隐私', [
        _buildSelectItem('谁可以看到我的好友列表', '所有人'),
        _buildSelectItem('谁可以看到我的生日', '仅好友'),
        _buildSelectItem('谁可以给我发消息', '所有人'),
      ]),
    ]);
  }

  Widget _buildNotificationSettings() {
    return column.children([
      _buildSection('推送通知', [
        _buildSwitchItem('新消息通知', true),
        _buildSwitchItem('好友请求通知', true),
        _buildSwitchItem('生日提醒', false),
      ]),
      h8,
      _buildSection('邮件通知', [
        _buildSwitchItem('重要更新', true),
        _buildSwitchItem('活动邀请', false),
      ]),
    ]);
  }

  Widget _buildLanguageSettings() {
    return column.children([
      _buildSection('应用语言', [
        _buildRadioItem('简体中文', true),
        _buildRadioItem('English', false),
        _buildRadioItem('日本語', false),
      ]),
      h8,
      _buildSection('内容语言', [
        _buildSwitchItem('自动翻译外语内容', true),
      ]),
    ]);
  }

  Widget _buildDarkModeSettings() {
    return _buildSection('主题设置', [
      _buildRadioItem('跟随系统', true),
      _buildRadioItem('浅色模式', false),
      _buildRadioItem('深色模式', false),
    ]);
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

  Widget _buildSwitchItem(String label, bool value) {
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

  Widget _buildSelectItem(String label, String value) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          row.children([
            value.text.grey600.f14.mk,
            w8,
            Icons.chevron_right.icon.grey600.s24.mk,
          ]),
        ]),
      ),
    );
  }

  Widget _buildRadioItem(String label, bool selected) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          Radio(
            value: selected,
            groupValue: true,
            onChanged: (_) {},
          ),
        ]),
      ),
    );
  }
} 