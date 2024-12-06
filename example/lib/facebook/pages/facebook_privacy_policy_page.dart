import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookPrivacyPolicyPage extends StatelessWidget {
  const FacebookPrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '隐私政策'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 政策标题
          '隐私政策'.text.f24.bold.center.mk,
          h16,
          '最后更新日期: 2024-01-01'.text.grey600.f14.center.mk,
          h24,
          // 政策内容
          _buildSection(
            '1. 信息收集',
            '1.1 我们收集的信息类型\n'
                '- 您提供的信息（如注册信息）\n'
                '- 使用服务时产生的信息\n'
                '- 设备和日志信息\n\n'
                '1.2 收集方式\n'
                '- 直接收集\n'
                '- 自动收集\n'
                '- 第三方提供',
          ),
          h16,
          _buildSection(
            '2. 信息使用',
            '2.1 用途\n'
                '- 提供和改进服务\n'
                '- 个性化体验\n'
                '- 安全���护\n'
                '- 分析和统计',
          ),
          h16,
          _buildSection(
            '3. 信息共享',
            '3.1 共享对象\n'
                '- 关联公司\n'
                '- 服务提供商\n'
                '- 广告合作伙伴\n\n'
                '3.2 共享原则\n'
                '- 必要性原则\n'
                '- 安全性原则\n'
                '- 合规性原则',
          ),
          h16,
          _buildSection(
            '4. 信息存储',
            '4.1 存储位置\n'
                '- 境内服务器\n'
                '- 境外服务器\n\n'
                '4.2 存储期限\n'
                '- 服务期间\n'
                '- 法律要求期限',
          ),
          h16,
          _buildSection(
            '5. 信息安全',
            '5.1 安全措施\n'
                '- 技术保护\n'
                '- 管理保护\n'
                '- 访问控制',
          ),
          h16,
          _buildSection(
            '6. 用户权利',
            '6.1 您的权利\n'
                '- 访问权\n'
                '- 更正权\n'
                '- 删除权\n'
                '- 撤回同意权',
          ),
          h16,
          _buildSection(
            '7. Cookie使用',
            '7.1 Cookie政策\n'
                '- 使用目的\n'
                '- 类型说明\n'
                '- 控制方式',
          ),
          h16,
          _buildSection(
            '8. 儿童隐私',
            '8.1 保护措施\n'
                '- 年龄限制\n'
                '- 信息处理\n'
                '- 家长控制',
          ),
          h16,
          _buildSection(
            '9. 政策更新',
            '9.1 更新方式\n'
                '- 通知方式\n'
                '- 生效时间\n'
                '- 重要变更',
          ),
          h16,
          _buildSection(
            '10. 联系我们',
            '10.1 联系方式\n'
                '- 邮箱地址\n'
                '- 联系电话\n'
                '- 办公地址',
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return column.crossStart.children([
      title.text.f16.bold.mk,
      h8,
      content.text.f14.height(1.5).mk,
    ]);
  }
}
