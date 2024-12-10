class Comment {
  final String id;
  final String userId;
  final String userAvatar;
  final String userName;
  final String content;
  final DateTime timestamp;
  final int likes;
  final List<Comment> replies;
  final bool isLiked;

  Comment({
    required this.id,
    required this.userId,
    required this.userAvatar,
    required this.userName,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.replies = const [],
    this.isLiked = false,
  });
}

final comments = [
  Comment(
    id: '1',
    userId: 'user1',
    userAvatar: 'https://picsum.photos/200',
    userName: 'John Doe',
    content: '这是一条评论内容',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    likes: 5,
    replies: [
      Comment(
        id: '2',
        userId: 'user2',
        userAvatar: 'https://picsum.photos/201',
        userName: 'Jane Smith',
        content: '这是一条回复',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ],
  ),
];
