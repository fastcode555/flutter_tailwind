import 'package:flutter/material.dart';

class Story {
  final String id;
  final String userId;
  final String userAvatar;
  final String userName;
  final String? imageUrl;
  final String? text;
  final Color? backgroundColor;
  final DateTime createdAt;
  final bool isViewed;

  const Story({
    required this.id,
    required this.userId,
    required this.userAvatar,
    required this.userName,
    required this.createdAt, this.imageUrl,
    this.text,
    this.backgroundColor,
    this.isViewed = false,
  });
}

final stories = [
  Story(
    id: '1',
    userId: 'user1',
    userAvatar: 'https://picsum.photos/200',
    userName: 'John Doe',
    imageUrl: 'https://picsum.photos/300/500',
    text: 'This is a story about John Doe',
    backgroundColor: Colors.blue,
    createdAt: DateTime.now(),
  ),
  Story(
    id: '2',
    userId: 'user2',
    userAvatar: 'https://picsum.photos/201',
    userName: 'Jane Smith',
    imageUrl: 'https://picsum.photos/301/500',
    text: 'This is a story about Jane Smith',
    backgroundColor: Colors.green,
    createdAt: DateTime.now(),
  ),
  // 添加更多故事数据...
];
