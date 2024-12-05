import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookGroupCreatePage extends StatelessWidget {
  const FacebookGroupCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '创建群组'.text.f20.bold.mk,
        actions: [
          container.blue.rounded8.p12.ph16.m8.center.child(
            '创建'.text.white.f14.bold.mk,
          ),
        ],
      ),
      body: ListView(
        children: [
          // 群组封面
          container.white.p16.child(
            column.crossStart.children([
              '群组封面'.text.f16.bold.mk,
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
              _buildTextField('群组名称', '输入群组名称'),
              h16,
              _buildTextField('群组简介', '介绍一下你的群组...', maxLines: 3),
              h16,
              // 隐私设置
              '隐私设置'.text.f14.grey600.mk,
              h8,
              container.grey100.rounded8.p12.wFull.child(
                row.spaceBetween.children([
                  row.children([
                    Icons.public.icon.grey600.s24.mk,
                    w12,
                    '公开群组'.text.f16.mk,
                  ]),
                  Icons.arrow_forward_ios.icon.grey600.s16.mk,
                ]),
              ),
            ]),
          ),
          h8,
          // 邀请成员
          container.white.p16.child(
            column.crossStart.children([
              '邀请成员'.text.f16.bold.mk,
              h16,
              container.grey100.rounded8.p12.wFull.child(
                row.children([
                  Icons.search.icon.grey600.s24.mk,
                  w12,
                  '搜索好友'.text.grey600.f14.expanded.mk,
                ]),
              ),
              h16,
              // 好友列表
              _buildFriendItem(),
              _buildFriendItem(),
              _buildFriendItem(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return column.crossStart.children([
      label.text.grey600.f14.mk,
      h8,
      container.grey100.rounded8.p12.wFull.child(
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
          maxLines: maxLines,
        ),
      ),
    ]);
  }

  Widget _buildFriendItem() {
    return container.borderB1.borderGrey200.pv16.child(
      row.children([
        'https://picsum.photos/200'.image.s50.circle.mk,
        w12,
        column.crossStart.expanded.children([
          'John Doe'.text.f16.bold.mk,
          h4,
          '5个共同好友'.text.grey600.f14.mk,
        ]),
        container.s40.circle.grey100.center.child(
          Icons.add.icon.grey800.s24.mk,
        ),
      ]),
    );
  }
} 