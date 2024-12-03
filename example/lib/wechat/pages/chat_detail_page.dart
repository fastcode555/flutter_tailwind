import 'package:example/wechat/widgets/chat_message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ChatDetailPage extends StatefulWidget {
  final String name;
  final String avatar;

  const ChatDetailPage({
    required this.name,
    required this.avatar,
    super.key,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = mockMessages;
  bool _showSend = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _showSend = _controller.text.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.name.text.bold.f18.mk,
        actions: [
          Icons.more_horiz.icon.s24.iconClick(
            onTap: () {
              /* Show chat settings */
            },
          ),
        ],
      ),
      body: column.children([
        // Messages list
        Expanded(
          child: listview.expanded.reverse.builder(
            _messages.length,
            (context, index) {
              final message = _messages[index];
              return ChatMessageItem(
                message: message,
                avatar: message.isMe ? null : widget.avatar,
              );
            },
          ),
        ),
        // Input area
        container.white.shadowSm.p8.child(
          Row(
            children: [
              Icons.mic.icon.grey.s24.p8.iconClick(
                onTap: () {
                  /* Handle voice recording */
                },
              ),
              container.grey100.expanded.rounded8.p8.child(
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type a message',
                  ),
                ),
              ),
              if (!_showSend) ...[
                Icons.emoji_emotions.icon.grey.s24.p8.iconClick(
                  onTap: () {
                    /* Show emoji picker */
                  },
                ),
                Icons.add_circle.icon.grey.s24.p8.iconClick(
                  onTap: () {
                    /* Show more options */
                  },
                ),
              ] else
                container.green.rounded8.p8.ph16.child('Send'.text.white.bold.mk).click(onTap: _sendMessage),
            ],
          ),
        ),
      ]),
    );
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          content: _controller.text,
          isMe: true,
          time: DateTime.now(),
        ),
      );
    });
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
