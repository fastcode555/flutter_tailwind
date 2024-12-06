import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProfilePage extends StatelessWidget {
  const FacebookProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: column.children([
          // 封面图片
          'https://picsum.photos/500/200'.image.h200.wFull.cover.mk,
          // 头像和基本信息
          column.p16.children([
            // 头像
            'https://picsum.photos/200'.image.s100.circle.border4.borderWhite.cover.mk,
            h12,
            // 用户名
            'John Doe'.text.f20.bold.mk,
            h8,
            // 简介
            '这是我的个人简介'.text.grey600.f14.mk,
            h16,
            // 操作按钮
            row.spaceEvenly.children([
              container.blue.rounded8.p12.child(
                '编辑资料'.text.white.f14.bold.mk,
              ),
              container.grey200.rounded8.p12.child(
                '添加故事'.text.grey800.f14.bold.mk,
              ),
            ]),
          ]),
        ]),
      ),
    );
  }
}
