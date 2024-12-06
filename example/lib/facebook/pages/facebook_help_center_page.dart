import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookHelpCenterPage extends StatelessWidget {
  const FacebookHelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '帮助中心'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 搜索框
          container.white.p16.child(
            container.grey100.rounded24.p12.wFull.child(
              row.children([
                Icons.search.icon.grey600.s24.mk,
                w12,
                '搜索帮助'.text.grey600.f14.expanded.mk,
              ]),
            ),
          ),
          h8,
          // 常见问题
          _buildSection('常见问题', [
            _buildHelpItem('如何修改密码?'),
            _buildHelpItem('如何设置隐私?'),
            _buildHelpItem('如何举报内容?'),
          ]),
          h8,
          // 账号和安全
          _buildSection('账号和安全', [
            _buildHelpItem('账号被盗怎么办?'),
            _buildHelpItem('无法登录怎么办?'),
            _buildHelpItem('如何开启双重认证?'),
          ]),
          h8,
          // 隐私和数据
          _buildSection('隐私和数据', [
            _buildHelpItem('如何管理个人数据?'),
            _buildHelpItem('如何下载我的数据?'),
            _buildHelpItem('如何删除账号?'),
          ]),
          h8,
          // 联系我们
          _buildSection('联系我们', [
            _buildContactItem(Icons.email, '发送邮件'),
            _buildContactItem(Icons.chat, '在线客服'),
            _buildContactItem(Icons.phone, '电话支持'),
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

  Widget _buildHelpItem(String title) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          title.text.f16.mk,
          Icons.chevron_right.icon.grey600.s24.mk,
        ]),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          icon.icon.grey800.s24.mk,
          w16,
          label.text.f16.mk,
        ]),
      ),
    );
  }
}
