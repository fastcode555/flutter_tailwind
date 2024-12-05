import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookCallSettingsPage extends StatelessWidget {
  const FacebookCallSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '通话设置'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          _buildSection('通话偏好', [
            _buildSettingItem('来电提醒', true),
            _buildSettingItem('震动提醒', true),
            _buildSettingItem('自动接听', false),
          ]),
          h8,
          _buildSection('音频设置', [
            _buildActionItem(Icons.volume_up, '扬声器'),
            _buildActionItem(Icons.headset, '耳机'),
            _buildActionItem(Icons.bluetooth, '蓝牙设备'),
          ]),
          h8,
          _buildSection('视频设置', [
            _buildActionItem(Icons.videocam, '默认摄像头'),
            _buildActionItem(Icons.photo_filter, '视频美颜'),
            _buildSettingItem('高清视频', true),
          ]),
          h8,
          _buildSection('隐私设置', [
            _buildSettingItem('显示通话记录', true),
            _buildSettingItem('允许陌生人通话', false),
            _buildActionItem(Icons.block, '黑名单管理'),
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

  Widget _buildActionItem(IconData icon, String label) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          icon.icon.s24.grey800.mk,
          w16,
          label.text.f16.mk,
          const Spacer(),
          Icons.chevron_right.icon.grey600.s24.mk,
        ]),
      ),
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
} 