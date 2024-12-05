import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookUserProfilePage extends StatelessWidget {
  final String userId;

  const FacebookUserProfilePage({
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // 封面和头像
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // 封面图片
                  'https://picsum.photos/500/200'.image.wFull.h200.cover.mk,
                  // 头像
                  positioned.b16.l16.child(
                    'https://picsum.photos/200'.image.s100.circle.border4.borderWhite.mk,
                  ),
                ],
              ),
            ),
          ),
          // 用户信息
          SliverToBoxAdapter(
            child: column.children([
              // 基本信息
              container.white.p16.child(
                column.crossStart.children([
                  // 用户名和简介
                  'John Doe'.text.f20.bold.mk,
                  h8,
                  '这是我的个人简介'.text.grey600.f14.mk,
                  h16,
                  // 操作按钮
                  row.children([
                    container.blue.rounded8.p12.expanded.center.child(
                      '添加好友'.text.white.f14.bold.mk,
                    ),
                    w8,
                    container.grey200.rounded8.p12.expanded.center.child(
                      '发消息'.text.grey800.f14.bold.mk,
                    ),
                    w8,
                    container.grey200.rounded8.p12.w40.center.child(
                      Icons.more_horiz.icon.grey800.s24.mk,
                    ),
                  ]),
                ]),
              ),
              h8,
              // 详细信息
              container.white.p16.child(
                column.crossStart.children([
                  '详细信息'.text.f16.bold.mk,
                  h16,
                  _buildInfoItem(Icons.work, '在 Flutter 工作'),
                  h8,
                  _buildInfoItem(Icons.location_on, '居住在上海'),
                  h8,
                  _buildInfoItem(Icons.school, '毕业于某大学'),
                  h8,
                  _buildInfoItem(Icons.favorite, '单身'),
                ]),
              ),
              h8,
              // 照片
              container.white.p16.child(
                column.crossStart.children([
                  row.spaceBetween.children([
                    '照片'.text.f16.bold.mk,
                    '查看全部'.text.blue.f14.mk,
                  ]),
                  h16,
                  container.h200.child(
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: List.generate(
                        9,
                        (index) => 'https://picsum.photos/200?random=$index'
                            .image.wFull.hFull.cover.rounded8.mk,
                      ),
                    ),
                  ),
                ]),
              ),
              h8,
              // 好友
              container.white.p16.child(
                column.crossStart.children([
                  row.spaceBetween.children([
                    '好友'.text.f16.bold.mk,
                    '查看全部'.text.blue.f14.mk,
                  ]),
                  h16,
                  container.h200.child(
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: List.generate(
                        6,
                        (index) => column.crossStart.children([
                          'https://picsum.photos/200?random=${index + 10}'
                              .image.wFull.h100.cover.rounded8.mk,
                          h4,
                          '好友名称'.text.f14.bold.mk,
                        ]),
                      ),
                    ),
                  ),
                ]),
              ),
              h8,
              // 帖子列表
              container.white.p16.child(
                column.crossStart.children([
                  '帖子'.text.f16.bold.mk,
                  h16,
                  // TODO: 使用 FacebookPostList 组件
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return row.children([
      icon.icon.grey600.s20.mk,
      w8,
      text.text.f14.mk,
    ]);
  }
}
