enum NotificationType {
  like,
  comment,
  share,
  friendRequest,
  groupInvite,
  birthday,
  post,
  mention,
  groupActivity,
}

class Notification {
  final String id;
  final NotificationType type;
  final String userId;
  final String userAvatar;
  final String userName;
  final String? content;
  final DateTime timestamp;
  final bool isRead;
  final String? targetId; // 关联的帖子、评论等的ID
  final String? imageUrl;
  final Map<String, dynamic>? extraData;

  const Notification({
    required this.id,
    required this.type,
    required this.userId,
    required this.userAvatar,
    required this.userName,
    required this.timestamp, this.content,
    this.isRead = false,
    this.targetId,
    this.imageUrl,
    this.extraData,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}月前';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}

// 示例数据
final notifications = [
  Notification(
    id: '1',
    type: NotificationType.like,
    userId: 'user1',
    userAvatar: 'https://picsum.photos/200',
    userName: 'John Doe',
    content: '赞了你的帖子',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    targetId: 'post1',
    imageUrl: 'https://picsum.photos/400/300',
  ),
  Notification(
    id: '2',
    type: NotificationType.comment,
    userId: 'user2',
    userAvatar: 'https://picsum.photos/201',
    userName: 'Jane Smith',
    content: '评论了你的帖子: "这是一条评论"',
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    targetId: 'post1',
  ),
  Notification(
    id: '3',
    type: NotificationType.friendRequest,
    userId: 'user3',
    userAvatar: 'https://picsum.photos/202',
    userName: 'Mike Johnson',
    content: '请求添加你为好友',
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  Notification(
    id: '4',
    type: NotificationType.groupInvite,
    userId: 'user4',
    userAvatar: 'https://picsum.photos/203',
    userName: 'Sarah Wilson',
    content: '邀请你加入群组 "Flutter 开发者"',
    timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
    targetId: 'group1',
  ),
  Notification(
    id: '5',
    type: NotificationType.birthday,
    userId: 'user5',
    userAvatar: 'https://picsum.photos/204',
    userName: 'Tom Brown',
    content: '今天生日',
    timestamp: DateTime.now(),
  ),
]; 