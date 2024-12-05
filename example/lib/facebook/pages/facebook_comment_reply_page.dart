import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookCommentReplyPage extends StatelessWidget {
  const FacebookCommentReplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '回复评论'.text.f20.bold.mk,
      ),
      body: column.children([
        // 原评论
        container.white.p16.child(
          row.crossStart.children([
            'https://picsum.photos/200'.image.s40.circle.mk,
            w12,
            column.crossStart.expanded.children([
              container.grey100.rounded16.p12.child(
                column.crossStart.children([
                  'John Doe'.text.f16.bold.mk,
                  h4,
                  '这是一条评论内容'.text.f14.mk,
                ]),
              ),
              h8,
              row.children([
                '2小时前'.text.grey600.f12.mk,
                w16,
                '赞'.text.grey600.f12.bold.mk,
              ]),
            ]),
          ]),
        ),
        // 回复列表
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.r),
            children: List.generate(5, (index) => _buildReplyItem()),
          ),
        ),
        // 输入框
        container.white.borderT1.borderGrey200.p12.child(
          row.children([
            'https://picsum.photos/200'.image.s32.circle.mk,
            w12,
            container.grey100.rounded24.expanded.p12.child(
              row.children([
                '写回复...'.text.grey600.f14.expanded.mk,
                Icons.emoji_emotions.icon.grey600.s24.mk,
                w12,
                Icons.camera_alt.icon.grey600.s24.mk,
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _buildReplyItem() {
    return container.mb16.child(
      row.crossStart.children([
        'https://picsum.photos/200'.image.s32.circle.mk,
        w12,
        column.crossStart.expanded.children([
          container.grey100.rounded16.p12.child(
            column.crossStart.children([
              'Jane Smith'.text.f14.bold.mk,
              h4,
              '这是一条回复内容'.text.f14.mk,
            ]),
          ),
          h8,
          row.children([
            '1小时前'.text.grey600.f12.mk,
            w16,
            '赞'.text.grey600.f12.bold.mk,
          ]),
        ]),
      ]),
    );
  }
} 