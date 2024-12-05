import 'package:example/facebook/models/post.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookPostDetailPage extends StatelessWidget {
  final Post post;

  const FacebookPostDetailPage({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '帖子详情'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 帖子内容
          container.white.child(
            column.children([
              // 作者信息
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
                    .click(onTap: () => AppRoutes.toImagePreview(context, [post.imageUrl!])),
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
            ]),
          ),
          h8,
          // 评论列表
          container.white.p16.child(
            column.crossStart.children([
              '评论'.text.f16.bold.mk,
              h16,
              _buildCommentItem(
                'Jane Smith',
                'https://picsum.photos/201',
                '这是一条评论',
                '1小时前',
              ),
              _buildCommentItem(
                'Mike Johnson',
                'https://picsum.photos/202',
                '这是另一条评论',
                '30分钟前',
              ),
            ]),
          ),
        ],
      ),
      // 底部评论框
      bottomNavigationBar: container.white.borderT1.borderGrey200.p12.child(
        row.children([
          'https://picsum.photos/200'.image.s32.circle.mk,
          w12,
          container.grey100.rounded24.expanded.p12.child(
            '写评论...'.text.grey600.f14.mk,
          ),
          w12,
          Icons.emoji_emotions.icon.grey600.s24.mk,
          w12,
          Icons.camera_alt.icon.grey600.s24.mk,
        ]),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return row.center.children([
      icon.icon.grey600.s20.mk,
      w4,
      label.text.grey600.f14.mk,
    ]);
  }

  Widget _buildCommentItem(
    String userName,
    String userAvatar,
    String content,
    String time,
  ) {
    return container.mb12.child(
      row.crossStart.children([
        userAvatar.image.s32.circle.mk,
        w12,
        column.crossStart.expanded.children([
          container.grey100.rounded12.p12.child(
            column.crossStart.children([
              userName.text.f14.bold.mk,
              h4,
              content.text.f14.mk,
            ]),
          ),
          h4,
          row.children([
            time.text.grey600.f12.mk,
            w16,
            '赞'.text.grey600.f12.bold.mk,
            w16,
            '回复'.text.grey600.f12.bold.mk,
          ]),
        ]),
      ]),
    );
  }
}
