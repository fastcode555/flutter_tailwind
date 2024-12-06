import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookFeedbackPage extends StatelessWidget {
  const FacebookFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '反馈问题'.text.f20.bold.mk,
        actions: [
          container.blue.rounded8.p12.ph16.m8.center.child(
            '提交'.text.white.f14.bold.mk,
          ),
        ],
      ),
      body: ListView(
        children: [
          // 问题类型
          container.white.p16.child(
            column.crossStart.children([
              '问题类型'.text.f16.bold.mk,
              h16,
              _buildTypeItem('功能异常', true),
              _buildTypeItem('界面问题', false),
              _buildTypeItem('性能问题', false),
              _buildTypeItem('其他问题', false),
            ]),
          ),
          h8,
          // 问题描述
          container.white.p16.child(
            column.crossStart.children([
              '问题描述'.text.f16.bold.mk,
              h16,
              container.grey100.rounded8.p12.wFull.child(
                const TextField(
                  decoration: InputDecoration(
                    hintText: '请详细描述你遇到的问题...',
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                ),
              ),
            ]),
          ),
          h8,
          // 上传截图
          container.white.p16.child(
            column.crossStart.children([
              '上传截图'.text.f16.bold.mk,
              h16,
              container.grey100.rounded8.p16.wFull.center.child(
                column.center.children([
                  Icons.add_photo_alternate.icon.grey600.s48.mk,
                  h16,
                  '点击上传截图'.text.grey600.f14.mk,
                  h8,
                  '(最多3张)'.text.grey600.f12.mk,
                ]),
              ),
            ]),
          ),
          h8,
          // 联系方式
          container.white.p16.child(
            column.crossStart.children([
              '联系方式'.text.f16.bold.mk,
              h16,
              _buildTextField('邮箱', 'example@email.com'),
              h16,
              _buildTextField('手机号', '请输入手机号'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeItem(String label, bool selected) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.spaceBetween.children([
          label.text.f16.mk,
          Radio(
            value: selected,
            groupValue: true,
            onChanged: (_) {},
          ),
        ]),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return column.crossStart.children([
      label.text.grey600.f14.mk,
      h8,
      container.grey100.rounded8.p12.wFull.child(
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
    ]);
  }
}
