import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookUserAgreementPage extends StatelessWidget {
  const FacebookUserAgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '用户协议'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 协议标题
          '用户协议'.text.f24.bold.center.mk,
          h16,
          '最后更新日期: 2024-01-01'.text.grey600.f14.center.mk,
          h24,
          // 协议内容
          _buildSection(
            '1. 服务条款',
            '欢迎使用我们的服务。通过使用我们的服务，即表示您同意本协议。请仔细阅读以下条款。',
          ),
          h16,
          _buildSection(
            '2. 账号注册',
            '2.1 您必须年满13周岁才能注册账号。\n'
                '2.2 您必须提供真实、准确的个人信息。\n'
                '2.3 您有责任保护好自己的账号和密码。',
          ),
          h16,
          _buildSection(
            '3. 用户行为',
            '3.1 您同意不发布任何违法、有害或不当的内容。\n'
                '3.2 您同意不侵犯他人的知识产权。\n'
                '3.3 您同意不从事任何可能损害服务正常运行的行为。',
          ),
          h16,
          _buildSection(
            '4. 隐私保护',
            '4.1 我们重视您的隐私保护。\n'
                '4.2 我们会按照隐私政策收集和使用您的信息。\n'
                '4.3 您可以随时查看和管理您的隐私设置。',
          ),
          h16,
          _buildSection(
            '5. 服务变更',
            '5.1 我们保留随时修改或终止服务的权利。\n'
                '5.2 我们会及时通知您服务的重要变更。\n'
                '5.3 继续使用服务即表示您接受变更后的条款。',
          ),
          h16,
          _buildSection(
            '6. 免责声明',
            '6.1 我们不对用户产生的内容负责。\n'
                '6.2 我们不保证服务不会中断或出错。\n'
                '6.3 我们不对因使用服务造成的损失承担责任。',
          ),
          h16,
          _buildSection(
            '7. 知识产权',
            '7.1 服务中的内容归我们或第三方所有。\n'
                '7.2 未经许可，您不得使用这些内容。\n'
                '7.3 您发布的内容，您保留���有权。',
          ),
          h16,
          _buildSection(
            '8. 终止服务',
            '8.1 您可以随时终止使用服务。\n'
                '8.2 我们可能因违规行为终止您的账号。\n'
                '8.3 终止后相关条款仍继续有效。',
          ),
          h16,
          _buildSection(
            '9. 法律适用',
            '9.1 本协议受相关法律管辖。\n'
                '9.2 争议解决优先采用友好协商。\n'
                '9.3 协商不成可提交法院裁决。',
          ),
          h16,
          _buildSection(
            '10. 其他条款',
            '10.1 本协议构成完整的协议。\n'
                '10.2 协议部分无效不影响其他部分。\n'
                '10.3 我们保留解释权。',
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
