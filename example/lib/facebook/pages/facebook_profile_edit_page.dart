import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProfileEditPage extends StatelessWidget {
  const FacebookProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '编辑资料'.text.f20.bold.mk,
        actions: [
          container.blue.rounded8.p12.ph16.m8.center.child(
            '保存'.text.white.f14.bold.mk,
          ),
        ],
      ),
      body: ListView(
        children: [
          // 头像和封面
          container.white.p16.child(
            column.crossStart.children([
              '头像'.text.f16.bold.mk,
              h16,
              Center(
                child: Stack(
                  children: [
                    'https://picsum.photos/200'.image.s100.circle.mk,
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: container.s32.circle.blue.center.child(
                        Icons.camera_alt.icon.white.s20.mk,
                      ),
                    ),
                  ],
                ),
              ),
              h24,
              '封面图片'.text.f16.bold.mk,
              h16,
              container.h150.grey100.rounded8.center.child(
                Icons.add_a_photo.icon.grey600.s32.mk,
              ),
            ]),
          ),
          h8,
          // 基本信息
          container.white.p16.child(
            column.crossStart.children([
              '基本信息'.text.f16.bold.mk,
              h16,
              _buildTextField('昵称', 'John Doe'),
              h16,
              _buildTextField('简介', '这是我的个人简介', maxLines: 3),
              h16,
              _buildTextField('所在地', '上海'),
              h16,
              _buildTextField('工作', 'Flutter 开发者'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value, {int maxLines = 1}) {
    return column.crossStart.children([
      label.text.grey600.f14.mk,
      h8,
      container.grey100.rounded8.p12.wFull.child(
        TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: value,
          ),
          maxLines: maxLines,
        ),
      ),
    ]);
  }
} 