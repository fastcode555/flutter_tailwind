import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookPhoneLoginPage extends StatelessWidget {
  const FacebookPhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '手机号登录'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 手机号输入框
          _buildTextField(
            label: '手机号',
            hintText: '请输入手机号',
            keyboardType: TextInputType.phone,
          ),
          h16,
          // 验证码输入框
          _buildVerifyCodeField(),
          h24,
          // 登录按钮
          container.blue.rounded8.p16.wFull.center
              .child('登录'.text.white.f16.bold.mk)
              .click(onTap: () => _login(context)),
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
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
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
          const TextField(
            decoration: InputDecoration(
              hintText: '请输入验证码',
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        w16,
        container.blue.rounded8.p12.ph16.center.child(
          '获取验证码'.text.white.f14.bold.mk,
        ),
      ]),
    ]);
  }

  void _login(BuildContext context) {
    // TODO: 实现手机号登录
    AppRoutes.toMain(context);
  }
}
