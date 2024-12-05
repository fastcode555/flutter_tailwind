import 'package:example/facebook/models/notification.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookNotificationDetailPage extends StatelessWidget {
  final Notification notification;

  const FacebookNotificationDetailPage({
    required this.notification,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '通知详情'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 通知内容
          container.white.p16.child(
            row.children([
              container.s50.circle.blue.center.child(
                _getNotificationIcon().icon.white.s24.mk,
              ),
              w12,
              column.crossStart.expanded.children([
                row.children([
                  notification.userName.text.f16.bold.mk,
                  w4,
                  _getNotificationText().text.f16.mk,
                ]),
                h4,
                notification.timeAgo.text.grey600.f14.mk,
              ]),
            ]),
          ),
          h8,
          // 相关内容
          if (notification.targetId != null || notification.imageUrl != null)
            container.white.p16.child(
              column.crossStart.children([
                '相关内容'.text.f16.bold.mk,
                h16,
                if (notification.imageUrl != null) notification.imageUrl!.image.wFull.h200.cover.mk,
                if (notification.content != null) ...[
                  h16,
                  notification.content!.text.f16.mk,
                ],
                h16,
                // 操作按钮
                _buildActionButtons(context),
              ]),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    switch (notification.type) {
      case NotificationType.friendRequest:
        return row.children([
          container.blue.rounded8.p12.expanded.center.child(
            '接受'.text.white.f14.bold.mk,
          ),
          w8,
          container.grey200.rounded8.p12.expanded.center.child(
            '拒绝'.text.grey800.f14.bold.mk,
          ),
        ]);
      case NotificationType.groupInvite:
        return container.blue.rounded8.p12.wFull.center.child(
          '查看群组'.text.white.f14.bold.mk,
        );
      case NotificationType.like:
      case NotificationType.comment:
      case NotificationType.share:
        return container.blue.rounded8.p12.wFull.center.child(
          '查看帖子'.text.white.f14.bold.mk,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.like:
        return Icons.thumb_up;
      case NotificationType.comment:
        return Icons.chat_bubble;
      case NotificationType.share:
        return Icons.share;
      case NotificationType.friendRequest:
        return Icons.person_add;
      case NotificationType.groupInvite:
        return Icons.group_add;
      case NotificationType.birthday:
        return Icons.cake;
      default:
        return Icons.notifications;
    }
  }

  String _getNotificationText() {
    switch (notification.type) {
      case NotificationType.like:
        return '赞了你的帖子';
      case NotificationType.comment:
        return '评论了你的帖子';
      case NotificationType.share:
        return '分享了你的帖子';
      case NotificationType.friendRequest:
        return '请求添加你为好友';
      case NotificationType.groupInvite:
        return '邀请你加入群组';
      case NotificationType.birthday:
        return '今天生日';
      default:
        return notification.content ?? '';
    }
  }
}
