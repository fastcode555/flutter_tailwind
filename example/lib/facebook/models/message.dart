enum MessageType {
  text,
  image,
  video,
  file,
}

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String senderAvatar;
  final MessageType type;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderAvatar,
    required this.type,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });
}

class Chat {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isGroup;
  final String? groupName;
  final String? groupAvatar;
  final int unreadCount;

  Chat({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    this.isGroup = false,
    this.groupName,
    this.groupAvatar,
    this.unreadCount = 0,
  });
}

final chats = [
  Chat(
    id: '1',
    participants: ['user1', 'user2'],
    lastMessage: '你好，最近怎么样？',
    lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
    unreadCount: 1,
  ),
  // 添加更多聊天数据...
];
