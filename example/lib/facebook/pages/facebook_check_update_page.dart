import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookCheckUpdatePage extends StatefulWidget {
  const FacebookCheckUpdatePage({super.key});

  @override
  State<FacebookCheckUpdatePage> createState() => _FacebookCheckUpdatePageState();
}

class _FacebookCheckUpdatePageState extends State<FacebookCheckUpdatePage> {
  bool _isChecking = false;
  bool _autoCheck = true;
  bool _wifiOnly = true;
  bool _autoDownload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '检查更新'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 当前版本
          container.white.p16.child(
            column.center.children([
              'https://picsum.photos/100'.image.s80.mk,
              h16,
              'Facebook'.text.f20.bold.mk,
              h8,
              '当前版本 1.0.0'.text.grey600.f14.mk,
            ]),
          ),
          h16,
          // 更新状态
          container.white.p16.child(
            column.center.children([
              if (_isChecking)
                const CircularProgressIndicator()
              else ...[
                Icons.check_circle.icon.green.s48.mk,
                h16,
                '已是最新版本'.text.f16.bold.mk,
                h8,
                '上次检查: 2024-01-01 12:00'.text.grey600.f14.mk,
              ],
            ]),
          ),
          h16,
          // 自动更新设置
          container.white.child(
            column.children([
              _buildSettingItem(
                '自动检查更新',
                _autoCheck,
                onChanged: (value) => setState(() => _autoCheck = value),
              ),
              _buildSettingItem(
                '仅在WIFI下更新',
                _wifiOnly,
                onChanged: (value) => setState(() => _wifiOnly = value),
              ),
              _buildSettingItem(
                '自动下载更新',
                _autoDownload,
                onChanged: (value) => setState(() => _autoDownload = value),
              ),
            ]),
          ),
          h16,
          // 手动检查按钮
          container.blue.rounded8.p16.center
              .child('立即检查更新'.text.white.f16.bold.mk)
              .click(onTap: _checkUpdate),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    String label,
    bool value, {
    required ValueChanged<bool> onChanged,
  }) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ]),
      ),
    );
  }

  Future<void> _checkUpdate() async {
    setState(() => _isChecking = true);

    // 模拟检查更新
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isChecking = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: '已是最新版本'.text.white.mk),
    );
  }
} 