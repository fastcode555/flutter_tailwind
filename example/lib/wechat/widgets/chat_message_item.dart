import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ChatMessage {
  final String content;
  final bool isMe;
  final DateTime time;

  const ChatMessage({
    required this.content,
    required this.isMe,
    required this.time,
  });
}

class ChatMessageItem extends StatelessWidget {
  final ChatMessage message;
  final String? avatar;

  const ChatMessageItem({
    required this.message,
    super.key,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return container.p16.child(
      column.children(
        [
          // Time stamp
          // _buildTimeStamp(),
          h8,
          // Message content
          Row(
            mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isMe) ...[
                if (avatar != null) avatar!.image.circle.s40.mk else container.s40.circle.grey200.mk,
                w8,
              ],
              Flexible(
                child: container
                    .color(message.isMe ? const Color(0xFF95EC69) : Colors.white)
                    .p12
                    .rounded16
                    //.maxW(280.r)
                    .child(
                      message.content.text.f16.mk,
                    ),
              ),
              if (message.isMe) ...[
                w8,
                'https://randomuser.me/api/portraits/men/1.jpg'.image.circle.s40.mk,
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// Mock messages for testing
final mockMessages = [
  ChatMessage(
    content: 'Hey, how are you?',
    isMe: false,
    time: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  ChatMessage(
    content: "I'm good, thanks! How about you?",
    isMe: true,
    time: DateTime.now().subtract(const Duration(minutes: 4)),
  ),
  ChatMessage(
    content: "I'm doing great! Want to grab lunch tomorrow?",
    isMe: false,
    time: DateTime.now().subtract(const Duration(minutes: 3)),
  ),
  ChatMessage(
    content: 'Sure, that sounds good! Where should we meet?',
    isMe: true,
    time: DateTime.now().subtract(const Duration(minutes: 2)),
  ),
  ChatMessage(
    content: 'How about that new restaurant downtown?',
    isMe: false,
    time: DateTime.now().subtract(const Duration(minutes: 1)),
  ),
];
