import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookLoginPage extends StatelessWidget {
  const FacebookLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            // Logo
            h32,
            'https://picsum.photos/100'.image.s100.center.mk,
            h32,
            // 登录表单
            container.white.rounded12.p16.child(
              column.crossStart.children([
                // 手机号/邮箱输入框
                _buildTextField(
                  label: '手机号/邮箱',
                  hintText: '请输入手机号或邮箱',
                  keyboardType: TextInputType.emailAddress,
                ),
                h16,
                // 密码输入框
                _buildTextField(
                  label: '密码',
                  hintText: '请输入密码',
                  obscureText: true,
                ),
                h24,
                // 登录按钮
                container.blue.rounded8.p16.wFull.center
                    .child('登录'.text.white.f16.bold.mk)
                    .click(onTap: () => _login(context)),
                h16,
                // 忘记密码
                '忘记密码?'.text.blue.f14.center.mk.click(onTap: () => AppRoutes.toForgotPassword(context)),
              ]),
            ),
            h32,
            // 其他登录方式
            column.center.children([
              '其他登录方式'.text.grey600.f14.mk,
              h16,
              row.center.children([
                _buildSocialLoginButton(
                  icon: Icons.phone_android,
                  label: '手机号登录',
                  onTap: () => _phoneLogin(context),
                ),
                w16,
                _buildSocialLoginButton(
                  icon: Icons.wechat,
                  label: '微信登录',
                  onTap: () => _wechatLogin(context),
                ),
                w16,
                _buildSocialLoginButton(
                  icon: Icons.apple,
                  label: 'Apple登录',
                  onTap: () => _appleLogin(context),
                ),
              ]),
            ]),
            h32,
            // 注册入口
            row.center.children([
              '还没有账号? '.text.grey600.f14.mk,
              '立即注册'.text.blue.f14.bold.mk.click(onTap: () => AppRoutes.toRegister(context)),
            ]),
            h16,
            // 用户协议
            row.center.children([
              '登录即表示同意'.text.grey600.f12.mk,
              '用户协议'.text.blue.f12.mk.click(onTap: () => AppRoutes.toUserAgreement(context)),
              '和'.text.grey600.f12.mk,
              '隐私政策'.text.blue.f12.mk.click(onTap: () => AppRoutes.toPrivacyPolicy(context)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return column.crossStart.children([
      label.text.grey600.f14.mk,
      h8,
      container.grey100.rounded8.p12.wFull.child(
        TextField(
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

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return container.grey100.rounded8.p12.w100.center
        .child(
          column.center.children([
            icon.icon.grey800.s24.mk,
            h8,
            label.text.grey800.f12.mk,
          ]),
        )
        .click(onTap: onTap);
  }

  void _login(BuildContext context) {
    // TODO: 实现账号密码登录
    AppRoutes.toMain(context);
  }

  void _phoneLogin(BuildContext context) {
    // TODO: 实现手机号登录
  }

  void _wechatLogin(BuildContext context) {
    // TODO: 实现微信登录
  }

  void _appleLogin(BuildContext context) {
    // TODO: 实现Apple登录
  }
}
