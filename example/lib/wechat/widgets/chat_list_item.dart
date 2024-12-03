import 'package:example/wechat/pages/chat_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ChatListItem extends StatelessWidget {
  final String avatar;
  final String name;
  final String lastMessage;
  final String time;
  final bool hasUnread;

  const ChatListItem({
    super.key,
    required this.avatar,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.hasUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return row.p16.children(
      [
        // Avatar
        avatar.image.circle.s50.mk,
        w12,
        // Chat info
        column.crossStart.expanded.children([
          name.text.bold.f16.mk,
          h4,
          lastMessage.text.grey.f14.maxLine1.ellipsis.mk,
        ]),
        w12,
        // Time and unread indicator
        column.crossEnd.children([
          time.text.grey.f12.mk,
          h4,
          if (hasUnread)
            container.s20.circle.red.center.child(
              '1'.text.white.bold.f12.mk,
            ),
        ]),
      ],
    ).click(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailPage(
            name: name,
            avatar: avatar,
          ),
        ),
      ),
    );
  }
}
