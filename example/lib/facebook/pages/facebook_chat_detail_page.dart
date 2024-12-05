import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookChatDetailPage extends StatelessWidget {
  const FacebookChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: row.children([
          container.s40.circle
              .child(
                'https://picsum.photos/200'.image.s40.circle.mk,
              )
              .click(onTap: () => AppRoutes.toUserProfile(context, 'user1')),
          w12,
          column.crossStart.children([
            'John Doe'.text.f16.bold.mk,
            '在线'.text.grey600.f14.mk,
          ]),
        ]),
        actions: [
          container.s40.circle.grey100.center.child(Icons.phone.icon.grey800.s24.mk).click(
              onTap: () => AppRoutes.toVoiceCall(
                    context,
                    userName: 'John Doe',
                    userAvatar: 'https://picsum.photos/200',
                  )),
          w16,
          container.s40.circle.grey100.center.child(Icons.videocam.icon.grey800.s24.mk).click(
              onTap: () => AppRoutes.toVideoCall(
                    context,
                    userName: 'John Doe',
                    userAvatar: 'https://picsum.photos/200',
                  )),
          w16,
          container.s40.circle.grey100.center.child(Icons.info_outline.icon.grey800.s24.mk).click(
              onTap: () => AppRoutes.toChatSettings(
                    context,
                    userName: 'John Doe',
                    userAvatar: 'https://picsum.photos/200',
                  )),
          w16,
        ],
      ),
      body: column.children([
        // 聊天内容
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.r),
            children: [
              _buildMessage(
                '你好！',
                isSelf: false,
                avatar: 'https://picsum.photos/200',
                userId: 'user1',
                time: '14:30',
                context: context,
              ),
              _buildMessage(
                '你好，最近怎么样？',
                isSelf: true,
                avatar: 'https://picsum.photos/201',
                userId: 'user2',
                time: '14:31',
                context: context,
              ),
              _buildMessage(
                '挺好的，在学习 Flutter',
                isSelf: false,
                avatar: 'https://picsum.photos/200',
                userId: 'user1',
                time: '14:32',
                context: context,
              ),
              _buildMessage(
                '我也是！Flutter真的很有趣，尤其是用Tailwind风格来写UI，感觉开发效率提高了很多。',
                isSelf: true,
                avatar: 'https://picsum.photos/201',
                userId: 'user2',
                time: '14:33',
                context: context,
              ),
            ],
          ),
        ),
        // 输入框
        container.white.borderT1.borderGrey200.p12.child(
          row.children([
            container.s40.circle.grey100.center.child(
              Icons.add.icon.grey800.s24.mk,
            ),
            w12,
            container.grey100.rounded24.expanded.p12.child(
              row.children([
                '发消息...'.text.grey600.f14.expanded.mk,
                Icons.emoji_emotions.icon.grey600.s24.mk,
                w12,
                Icons.camera_alt.icon.grey600.s24.mk,
              ]),
            ),
            w12,
            container.s40.circle.grey100.center.child(
              Icons.thumb_up.icon.grey800.s24.mk,
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _buildMessage(
    String text, {
    required bool isSelf,
    required String avatar,
    required String userId,
    required String time,
    required BuildContext context,
  }) {
    return container.mb16.child(
      column.crossStart.children([
        row.crossStart.children([
          if (!isSelf) ...[
            container.s32.circle
                .child(
                  avatar.image.s32.circle.mk,
                )
                .click(onTap: () => AppRoutes.toUserProfile(context, userId)),
            w8,
          ],
          Expanded(
            child: column.crossStart.children([
              container.wFull70.child(
                container.p12.color(isSelf ? Colors.blue : Colors.grey[100]).rounded16.child(
                      text.text.f14.color(isSelf ? Colors.white : Colors.black).mk,
                    ),
              ),
              h4,
              time.text.grey600.f12.mk,
            ]),
          ),
          if (isSelf) ...[
            w8,
            container.s32.circle
                .child(
                  avatar.image.s32.circle.mk,
                )
                .click(onTap: () => AppRoutes.toUserProfile(context, userId)),
          ],
        ]),
      ]),
    );
  }
}
