import 'package:example/facebook/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookPostSharePage extends StatelessWidget {
  final Post post;

  const FacebookPostSharePage({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '分享帖子'.text.f20.bold.mk,
        actions: [
          container.blue.rounded8.p12.ph16.m8.center.child(
            '分享'.text.white.f14.bold.mk,
          ),
        ],
      ),
      body: ListView(
        children: [
          // 分享方式
          container.white.p16.child(
            column.crossStart.children([
              '分享到'.text.f16.bold.mk,
              h16,
              row.children([
                _buildShareOption(Icons.public, '公开分享'),
                w8,
                _buildShareOption(Icons.group, '分享到群组'),
                w8,
                _buildShareOption(Icons.person, '分享给好友'),
                w8,
                _buildShareOption(Icons.messenger_outline, 'Messenger'),
              ]),
            ]),
          ),
          h8,
          // 添加说明
          container.white.p16.child(
            column.crossStart.children([
              '添加说明'.text.f16.bold.mk,
              h16,
              container.grey100.rounded8.p12.wFull.child(
                const TextField(
                  decoration: InputDecoration(
                    hintText: '说点什么...',
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                ),
              ),
            ]),
          ),
          h8,
          // 原帖内容预览
          container.white.p16.child(
            column.crossStart.children([
              row.children([
                post.userAvatar.image.s40.circle.mk,
                w12,
                column.crossStart.expanded.children([
                  post.userName.text.f16.bold.mk,
                  post.timeAgo.text.grey600.f14.mk,
                ]),
              ]),
              h12,
              post.content.text.f16.mk,
              if (post.imageUrl != null) ...[
                h12,
                post.imageUrl!.image.wFull.h200.cover.mk,
              ],
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return container.grey100.rounded8.p12.expanded.child(
      column.center.children([
        icon.icon.grey800.s24.mk,
        h8,
        label.text.f14.mk,
      ]),
    );
  }
} 