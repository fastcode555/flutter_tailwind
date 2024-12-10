class Video {
  final String userAvatar;
  final String userName;
  final String timeAgo;
  final String content;
  final String thumbnailUrl;
  final String videoUrl;
  final int likes;
  final int comments;
  final int shares;
  final int views;
  final bool isLiked;

  Video({
    required this.userAvatar,
    required this.userName,
    required this.timeAgo,
    required this.content,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.views,
    this.isLiked = false,
  });
}

final videos = [
  Video(
    userAvatar: 'https://picsum.photos/200',
    userName: 'John Doe',
    timeAgo: '2小时前',
    content: '这是一个有趣的视频',
    thumbnailUrl: 'https://picsum.photos/400/300',
    videoUrl: 'https://example.com/video1.mp4',
    likes: 1200,
    comments: 300,
    shares: 50,
    views: 5000,
  ),
  Video(
    userAvatar: 'https://picsum.photos/201',
    userName: 'Jane Smith',
    timeAgo: '3小时前',
    content: '分享一个精彩时刻',
    thumbnailUrl: 'https://picsum.photos/401/300',
    videoUrl: 'https://example.com/video2.mp4',
    likes: 800,
    comments: 150,
    shares: 30,
    views: 3000,
  ),
];
