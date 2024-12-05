import 'package:example/facebook/models/post.dart';

class Group {
  final String coverUrl;
  final String name;
  final bool isPublic;
  final int members;
  final String description;
  final List<String> recentMembers;
  final List<Post> recentPosts;
  final bool isJoined;

  Group({
    required this.coverUrl,
    required this.name,
    required this.isPublic,
    required this.members,
    required this.description,
    required this.recentMembers,
    required this.recentPosts,
    this.isJoined = false,
  });
}

final groups = [
  Group(
    coverUrl: 'https://picsum.photos/500/200',
    name: 'Flutter 开发者社区',
    isPublic: true,
    members: 1200,
    description: '这是一个 Flutter 开发者交流的社区...',
    recentMembers: [
      'https://picsum.photos/200',
      'https://picsum.photos/201',
      'https://picsum.photos/202',
    ],
    recentPosts: [],
  ),
  // 添加更多群组数据...
];
