enum FriendRequestStatus {
  pending,
  accepted,
  declined,
}

class FriendRequest {
  final String id;
  final String userId;
  final String userAvatar;
  final String userName;
  final int mutualFriends;
  final DateTime timestamp;
  final FriendRequestStatus status;

  FriendRequest({
    required this.id,
    required this.userId,
    required this.userAvatar,
    required this.userName,
    required this.mutualFriends,
    required this.timestamp,
    this.status = FriendRequestStatus.pending,
  });
}

class Friend {
  final String id;
  final String userAvatar;
  final String userName;
  final int mutualFriends;
  final bool isOnline;
  final DateTime lastActive;

  Friend({
    required this.id,
    required this.userAvatar,
    required this.userName,
    required this.mutualFriends,
    required this.lastActive, this.isOnline = false,
  });
}

final friendRequests = [
  FriendRequest(
    id: '1',
    userId: 'user1',
    userAvatar: 'https://picsum.photos/200',
    userName: 'John Doe',
    mutualFriends: 5,
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

final friends = [
  Friend(
    id: '1',
    userAvatar: 'https://picsum.photos/200',
    userName: 'John Doe',
    mutualFriends: 5,
    isOnline: true,
    lastActive: DateTime.now(),
  ),
]; 