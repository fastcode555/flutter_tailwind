import 'package:example/wechat/widgets/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'WeChat'.text.bold.f18.mk,
        actions: [
          Icons.add_circle_outline.icon.s24.iconClick(
            onTap: () {
              /* Add new chat */
            },
          ),
        ],
      ),
      body: listview
          .separated(
        const Divider(height: 1),
      )
          .builder(
        _mockChats.length,
        (context, index) {
          final chat = _mockChats[index];
          return ChatListItem(
            avatar: chat.avatar,
            name: chat.name,
            lastMessage: chat.lastMessage,
            time: chat.time,
            hasUnread: chat.hasUnread,
          );
        },
      ),
    );
  }
}

// Mock data
class ChatInfo {
  final String avatar;
  final String name;
  final String lastMessage;
  final String time;
  final bool hasUnread;

  const ChatInfo({
    required this.avatar,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.hasUnread = false,
  });
}

final _mockChats = [
  const ChatInfo(
    avatar: 'https://randomuser.me/api/portraits/men/1.jpg',
    name: 'John Doe',
    lastMessage: 'Hey, how are you?',
    time: '11:30',
    hasUnread: true,
  ),
  const ChatInfo(
    avatar: 'https://randomuser.me/api/portraits/women/2.jpg',
    name: 'Jane Smith',
    lastMessage: 'See you tomorrow!',
    time: '10:15',
  ),
  // Add more mock chats...
];
