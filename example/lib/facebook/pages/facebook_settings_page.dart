import 'package:example/facebook/routes/app_routes.dart';
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
      body: ListView(
        children: [
          _buildSection('账号设置', [
            _buildSettingItem(
              Icons.lock,
              '隐私设置',
              onTap: () => AppRoutes.toSettingsDetail(context, '隐私设置'),
            ),
            _buildSettingItem(
              Icons.security,
              '安全和登录',
              onTap: () => AppRoutes.toSettingsDetail(context, '安全和登录'),
            ),
            _buildSettingItem(
              Icons.person,
              '个人资料设置',
              onTap: () => AppRoutes.toProfileEdit(context),
            ),
          ]),
          h8,
          _buildSection('偏好设置', [
            _buildSettingItem(
              Icons.notifications,
              '通知',
              onTap: () => AppRoutes.toSettingsDetail(context, '通知'),
            ),
            _buildSettingItem(
              Icons.language,
              '语言',
              onTap: () => AppRoutes.toSettingsDetail(context, '语言'),
            ),
            _buildSettingItem(
              Icons.dark_mode,
              '深色模式',
              onTap: () => AppRoutes.toSettingsDetail(context, '深色模式'),
            ),
          ]),
          h8,
          _buildSection('隐私', [
            _buildSettingItem(
              Icons.block,
              '黑名单',
              onTap: () => AppRoutes.toBlockList(context),
            ),
            _buildSettingItem(
              Icons.visibility_off,
              '已归档内容',
              onTap: () => AppRoutes.toArchivedContent(context),
            ),
            _buildSettingItem(
              Icons.history,
              '登录记录',
              onTap: () => AppRoutes.toLoginHistory(context),
            ),
          ]),
          h8,
          _buildSection('数据', [
            _buildSettingItem(
              Icons.download,
              '下载个人数据',
              onTap: () => _downloadData(context),
            ),
            _buildSettingItem(
              Icons.delete_outline,
              '清除缓存',
              onTap: () => _clearCache(context),
            ),
          ]),
          h8,
          _buildSection('支持', [
            _buildSettingItem(
              Icons.help,
              '帮助中心',
              onTap: () => AppRoutes.toHelpCenter(context),
            ),
            _buildSettingItem(
              Icons.bug_report,
              '反馈问题',
              onTap: () => AppRoutes.toFeedback(context),
            ),
            _buildSettingItem(
              Icons.info,
              '关于',
              onTap: () => AppRoutes.toAbout(context),
            ),
          ]),
          h8,
          _buildSection('账号', [
            _buildSettingItem(
              Icons.logout,
              '退出登录',
              isRed: true,
              onTap: () => _showLogoutDialog(context),
            ),
            _buildSettingItem(
              Icons.delete_forever,
              '注销账号',
              isRed: true,
              onTap: () => _showDeleteAccountDialog(context),
            ),
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

  Widget _buildSettingItem(
    IconData icon,
    String label, {
    bool isRed = false,
    VoidCallback? onTap,
  }) {
    return container.borderB1.borderGrey200
        .child(
          container.p16.child(
            row.children([
              icon.icon.s24.color(isRed ? Colors.red : Colors.grey[800]).mk,
              w16,
              label.text.f16.color(isRed ? Colors.red : Colors.black).expanded.mk,
              Icons.chevron_right.icon.grey600.s24.mk,
            ]),
          ),
        )
        .click(onTap: onTap);
  }

  void _downloadData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: '下载个人数据'.text.f16.bold.mk,
        content: '导出的数据包含你的个人信息、照片、视频等内容。导出可能需要几分钟时间。'.text.f14.mk,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: '取消'.text.grey600.f14.mk,
          ),
          TextButton(
            onPressed: () {
              // TODO: 实现数据导出
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: '开始导出数据,完成后将通知你'.text.white.mk),
              );
            },
            child: '导出'.text.blue.f14.mk,
          ),
        ],
      ),
    );
  }

  void _clearCache(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: '清除缓存'.text.f16.bold.mk,
        content: '这将清除应用的缓存数据,但不会删除你的个人数据。'.text.f14.mk,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: '取消'.text.grey600.f14.mk,
          ),
          TextButton(
            onPressed: () {
              // TODO: 实现清除缓存
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: '缓存已清除'.text.white.mk),
              );
            },
            child: '清除'.text.blue.f14.mk,
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: '退出登录'.text.f16.bold.mk,
        content: '确定要退出登录吗？'.text.f14.mk,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: '取消'.text.grey600.f14.mk,
          ),
          TextButton(
            onPressed: () {
              // TODO: 实现退出登录
              Navigator.pop(context);
              AppRoutes.toLogin(context);
            },
            child: '退出'.text.red.f14.mk,
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: '注销账号'.text.f16.bold.mk,
        content: '注销账号后,你的所有数据将被永久删除且无法恢复。确定要继续吗？'.text.f14.mk,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: '取消'.text.grey600.f14.mk,
          ),
          TextButton(
            onPressed: () {
              // TODO: 实现账号注销
              Navigator.pop(context);
              AppRoutes.toLogin(context);
            },
            child: '注销'.text.red.f14.mk,
          ),
        ],
      ),
    );
  }
}
