import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookGroupDetailPage extends StatelessWidget {
  const FacebookGroupDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 群组封面和信息
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: 'https://picsum.photos/500/200'.image.wFull.cover.mk,
            ),
          ),
          SliverToBoxAdapter(
            child: column.children([
              // 群组信息
              container.white.p16.child(
                column.crossStart.children([
                  'Flutter 开发者社区'.text.f20.bold.mk,
                  h8,
                  row.children([
                    Icons.public.icon.grey600.s16.mk,
                    w4,
                    '公开群组'.text.grey600.f14.mk,
                    w8,
                    '·'.text.grey600.f14.mk,
                    w8,
                    '1.2k 成员'.text.grey600.f14.mk,
                  ]),
                  h16,
                  container.blue.rounded8.p12.wFull.center.child(
                    '加入群组'.text.white.f14.bold.mk,
                  ),
                ]),
              ),
              h8,
              // 群组介绍
              container.white.p16.child(
                column.crossStart.children([
                  '关于'.text.f16.bold.mk,
                  h16,
                  '这是一个 Flutter 开发者交流的社区，欢迎大家加入讨论...'.text.f14.mk,
                ]),
              ),
              h8,
              // 最近帖子
              container.white.p16.child(
                column.crossStart.children([
                  '最近帖子'.text.f16.bold.mk,
                  h16,
                  _buildPostItem(),
                  _buildPostItem(),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildPostItem() {
    return container.borderB1.borderGrey200.pv16.child(
      column.crossStart.children([
        row.children([
          'https://picsum.photos/200'.image.s40.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            '2小时前'.text.grey600.f14.mk,
          ]),
        ]),
        h8,
        '这是一条帖子内容...'.text.f16.mk,
      ]),
    );
  }
}
