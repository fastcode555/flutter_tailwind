import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookForgotPasswordPage extends StatefulWidget {
  const FacebookForgotPasswordPage({super.key});

  @override
  State<FacebookForgotPasswordPage> createState() => _FacebookForgotPasswordPageState();
}

class _FacebookForgotPasswordPageState extends State<FacebookForgotPasswordPage> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '忘记密码'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 说明文字
          container.white.p16.child(
            '请输入注册时使用的手机号，我们将发送验证码帮助你重置密码。'.text.grey600.f14.mk,
          ),
          h16,
          // 重置密码表单
          container.white.rounded12.p16.child(
            column.crossStart.children([
              // 手机号输入框
              _buildTextField(
                label: '手机号',
                hintText: '请输入手机号',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              h16,
              // 验证码输入框
              _buildVerifyCodeField(),
              h16,
              // 新密码输入框
              _buildTextField(
                label: '新密码',
                hintText: '请设置6-20位新密码',
                controller: _passwordController,
                obscureText: true,
              ),
              h16,
              // 确认新密码输入框
              _buildTextField(
                label: '确认新密码',
                hintText: '请再次输入新密码',
                controller: _confirmPasswordController,
                obscureText: true,
              ),
              h24,
              // 重置密码按钮
              container.blue.rounded8.p16.wFull.center
                  .child('重置密码'.text.white.f16.bold.mk)
                  .click(onTap: _resetPassword),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return column.crossStart.children([
      label.text.grey600.f14.mk,
      h8,
      container.grey100.rounded8.p12.wFull.child(
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
        ),
      ),
    ]);
  }

  Widget _buildVerifyCodeField() {
    return column.crossStart.children([
      '验证码'.text.grey600.f14.mk,
      h8,
      row.children([
        container.grey100.rounded8.p12.expanded.child(
          TextField(
            controller: _codeController,
            decoration: const InputDecoration(
              hintText: '请输入验证码',
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        w16,
        container.blue.rounded8.p12.ph16.center
            .child('获取验证码'.text.white.f14.bold.mk)
            .click(onTap: _getVerifyCode),
      ]),
    ]);
  }

  void _getVerifyCode() {
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '请输入手机号'.text.white.mk),
      );
      return;
    }
    // TODO: 实现获取验证码
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: '验证码已发送'.text.white.mk),
    );
  }

  void _resetPassword() {
    // 表单验证
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '请输入手机号'.text.white.mk),
      );
      return;
    }

    if (_codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '请输入验证码'.text.white.mk),
      );
      return;
    }

    if (_passwordController.text.length < 6 || _passwordController.text.length > 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '密码长度应为6-20位'.text.white.mk),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '两次输入的密码不一致'.text.white.mk),
      );
      return;
    }

    // TODO: 实现重置密码
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: '密码重置成功'.text.white.mk),
    );
    Navigator.pop(context);
  }
}
