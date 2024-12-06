import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookRegisterPage extends StatefulWidget {
  const FacebookRegisterPage({super.key});

  @override
  State<FacebookRegisterPage> createState() => _FacebookRegisterPageState();
}

class _FacebookRegisterPageState extends State<FacebookRegisterPage> {
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
        title: '注册账号'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 注册表单
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
              // 密码输入框
              _buildTextField(
                label: '设置密码',
                hintText: '请设置6-20位密码',
                controller: _passwordController,
                obscureText: true,
              ),
              h16,
              // 确认密码输入框
              _buildTextField(
                label: '确认密码',
                hintText: '请再次输入密码',
                controller: _confirmPasswordController,
                obscureText: true,
              ),
              h24,
              // 注册按钮
              container.blue.rounded8.p16.wFull.center.child('注册'.text.white.f16.bold.mk).click(onTap: _register),
            ]),
          ),
          h16,
          // 用户协议
          row.center.children([
            '注册即表示同意'.text.grey600.f12.mk,
            '用户协议'.text.blue.f12.mk.click(onTap: () => AppRoutes.toUserAgreement(context)),
            '和'.text.grey600.f12.mk,
            '隐私政策'.text.blue.f12.mk.click(onTap: () => AppRoutes.toPrivacyPolicy(context)),
          ]),
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
        container.blue.rounded8.p12.ph16.center.child('获取验证码'.text.white.f14.bold.mk).click(onTap: _getVerifyCode),
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

  void _register() {
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

    // TODO: 实现注册
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: '注册成功'.text.white.mk),
    );
    Navigator.pop(context);
  }
}
