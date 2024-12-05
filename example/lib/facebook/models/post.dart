class Post {
  final String userAvatar;
  final String userName;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;

  Post({
    required this.userAvatar,
    required this.userName,
    required this.timeAgo,
    required this.content,
    required this.likes, required this.comments, required this.shares, this.imageUrl,
  });
}

final posts = [
  Post(
    userAvatar: 'https://picsum.photos/200',
    userName: 'John Doe',
    timeAgo: '3小时前',
    content: '今天是个美好的一天！',
    imageUrl: 'https://picsum.photos/400/300',
    likes: 156,
    comments: 48,
    shares: 12,
  ),
  Post(
    userAvatar: 'https://picsum.photos/201',
    userName: 'Jane Smith',
    timeAgo: '5小时前',
    content: '分享一些美好时光...',
    imageUrl: 'https://picsum.photos/401/300',
    likes: 289,
    comments: 76,
    shares: 24,
  ),
  // 添加更多帖子数据...
]; 