import 'package:example/facebook/models/friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookFriendsListPage extends StatelessWidget {
  const FacebookFriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: '好友'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '全部好友'),
              Tab(text: '好友请求'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFriendsList(),
            _buildFriendRequests(),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsList() {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) => container.white.borderB1.borderGrey200.child(
        container.p16.child(
          row.children([
            friends[index].userAvatar.image.s60.circle.mk,
            w12,
            column.crossStart.expanded.children([
              friends[index].userName.text.f16.bold.mk,
              h4,
              '${friends[index].mutualFriends}个共同好友'.text.grey600.f14.mk,
            ]),
            container.s40.circle.grey100.center.child(
              Icons.more_horiz.icon.grey800.s24.mk,
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildFriendRequests() {
    return ListView.builder(
      itemCount: friendRequests.length,
      itemBuilder: (context, index) => container.white.borderB1.borderGrey200.child(
        container.p16.child(
          row.children([
            friendRequests[index].userAvatar.image.s60.circle.mk,
            w12,
            column.crossStart.expanded.children([
              friendRequests[index].userName.text.f16.bold.mk,
              h4,
              '${friendRequests[index].mutualFriends}个共同好友'.text.grey600.f14.mk,
              h8,
              row.children([
                container.blue.rounded8.p8.ph16.expanded.center.child(
                  '接受'.text.white.f14.bold.mk,
                ),
                w8,
                container.grey200.rounded8.p8.ph16.expanded.center.child(
                  '删除'.text.grey800.f14.bold.mk,
                ),
              ]),
            ]),
          ]),
        ),
      ),
    );
  }
} 