import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookVideoPage extends StatelessWidget {
  const FacebookVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '视频'.text.f20.bold.mk,
        actions: [
          container.s40.circle.grey100.center.child(
            Icons.search.icon.grey800.s24.mk,
          ),
          w16,
        ],
      ),
      body: listview.builder(
        10,
        (context, index) => _buildVideoItem(),
      ),
    );
  }

  Widget _buildVideoItem() {
    return container.white.mb8.child(column.children([
      // 视频作者信息
      container.p16.child(row.children([
        'https://picsum.photos/200'.image.s40.circle.mk,
        w12,
        column.crossStart.expanded.children([
          '视频作者'.text.f16.bold.mk,
          row.children([
            '2小时前'.text.grey600.f14.mk,
            w4,
            Icons.public.icon.grey600.s14.mk,
          ])
        ]),
        Icons.more_horiz.icon.grey600.s24.mk,
      ])),
      // 视频描述
      container.ph16.pb8.centerLeft.child(
        '这是一个有趣的视频'.text.f16.mk,
      ),
      // 视频预览图
      container.h200.black.center.child(
        Icons.play_circle_outline.icon.white.s48.mk,
      ),
      // 互动数据
      container.p12.borderT1.borderGrey200.child(row.spaceBetween.children([
        row.children([
          Icons.thumb_up.icon.blue.s16.mk,
          w4,
          '1.2k'.text.grey600.f14.mk,
        ]),
        row.children([
          '300 条评论'.text.grey600.f14.mk,
          w16,
          '50 次分享'.text.grey600.f14.mk,
        ])
      ])),
      // 操作按钮
      container.pt8.pb8.borderT1.borderGrey200.child(row.spaceEvenly.children([
        row.center.children([
          Icons.thumb_up_outlined.icon.grey600.s20.mk,
          w4,
          '赞'.text.grey600.f14.mk,
        ]),
        row.center.children([
          Icons.chat_bubble_outline.icon.grey600.s20.mk,
          w4,
          '评论'.text.grey600.f14.mk,
        ]),
        row.center.children([
          Icons.share_outlined.icon.grey600.s20.mk,
          w4,
          '分享'.text.grey600.f14.mk,
        ]),
      ]))
    ]));
  }
}
