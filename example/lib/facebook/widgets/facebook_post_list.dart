import 'package:example/facebook/models/post.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookPostList extends StatelessWidget {
  const FacebookPostList({super.key});

  @override
  Widget build(BuildContext context) {
    return column.children(
      posts.map((post) => _buildPostCard(post, context)).toList(),
    );
  }

  Widget _buildPostCard(Post post, BuildContext context) {
    return container.white.mb8
        .child(column.children([
          // 帖子头部
          container.p16.child(
            row.children([
              post.userAvatar.image.s40.circle.mk,
              w12,
              column.crossStart.expanded.children([
                post.userName.text.f16.bold.mk,
                row.children([
                  post.timeAgo.text.grey600.f14.mk,
                  w4,
                  Icons.public.icon.grey600.s14.mk,
                ]),
              ]),
              container.s40.circle.grey100.center.child(
                Icons.more_horiz.icon.grey800.s24.mk,
              ),
            ]),
          ),
          // 帖子内容
          container.p16.pt0.centerLeft.child(
            post.content.text.f16.mk,
          ),
          // 帖子图片
          if (post.imageUrl != null)
            post.imageUrl!.image.wFull.h200.cover.mk
                .click(onTap: () => AppRoutes.toImagePreview(
                      context,
                      [post.imageUrl!],
                    )),
          // 点赞评论数
          container.p12.borderT1.borderGrey200.child(
            row.spaceBetween.children([
              row.children([
                Icons.thumb_up.icon.blue.s16.mk,
                w4,
                '${post.likes}'.text.grey600.f14.mk,
              ]),
              row.children([
                '${post.comments} 条评论'.text.grey600.f14.mk,
                w16,
                '${post.shares} 次分享'.text.grey600.f14.mk,
              ])
            ]),
          ),
          // 操作按钮
          container.pt8.pb8.borderT1.borderGrey200.child(
            row.spaceEvenly.children([
              _buildActionButton(Icons.thumb_up_outlined, '赞'),
              _buildActionButton(Icons.chat_bubble_outline, '评论')
                  .click(onTap: () => AppRoutes.toComments(context, post)),
              _buildActionButton(Icons.share_outlined, '分享'),
            ]),
          ),
        ]))
        .click(onTap: () => AppRoutes.toPostDetail(context, post));
  }

  Widget _buildActionButton(IconData icon, String label) {
    return row.center.children([
      icon.icon.grey600.s20.mk,
      w4,
      label.text.grey600.f14.mk,
    ]);
  }
}
