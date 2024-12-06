import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookAboutPage extends StatelessWidget {
  const FacebookAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '关于'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 应用信息
          container.white.p16.child(
            column.center.children([
              'https://picsum.photos/100'.image.s80.mk,
              h16,
              'Facebook'.text.f20.bold.mk,
              h8,
              '版本 1.0.0'.text.grey600.f14.mk,
            ]),
          ),
          h8,
          // 基本信息
          _buildSection('基本信息', [
            _buildInfoItem('开发者', 'Meta'),
            _buildInfoItem('更新日期', '2024-01-01'),
            _buildInfoItem('系统要求', 'Android 5.0 / iOS 12.0 及以上'),
          ]),
          h8,
          // 法律信息
          _buildSection('法律信息', [
            _buildActionItem('用户协议'),
            _buildActionItem('隐私政策'),
            _buildActionItem('第三方开源许可'),
          ]),
          h8,
          // 其他信息
          _buildSection('其他信息', [
            _buildActionItem('给应用评分'),
            _buildActionItem('分享应用'),
            _buildActionItem('检查更新'),
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

  Widget _buildInfoItem(String label, String value) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          value.text.grey600.f14.mk,
        ]),
      ),
    );
  }

  Widget _buildActionItem(String label) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          Icons.chevron_right.icon.grey600.s24.mk,
        ]),
      ),
    );
  }
}
