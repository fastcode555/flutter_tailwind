import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookCallHistoryPage extends StatelessWidget {
  const FacebookCallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: '通话记录'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '全部'),
              Tab(text: '未接'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCallList(),
            _buildCallList(showMissed: true),
          ],
        ),
      ),
    );
  }

  Widget _buildCallList({bool showMissed = false}) {
    return ListView(
      children: [
        _buildCallItem(
          userName: 'John Doe',
          userAvatar: 'https://picsum.photos/200',
          time: '昨天 14:30',
          isVideo: true,
          isMissed: showMissed,
          isOutgoing: true,
        ),
        _buildCallItem(
          userName: 'Jane Smith',
          userAvatar: 'https://picsum.photos/201',
          time: '昨天 12:20',
          isMissed: showMissed,
        ),
      ],
    );
  }

  Widget _buildCallItem({
    required String userName,
    required String userAvatar,
    required String time,
    bool isVideo = false,
    bool isMissed = false,
    bool isOutgoing = false,
  }) {
    return container.white.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          userAvatar.image.s50.circle.mk,
          w12,
          column.crossStart.expanded.children([
            userName.text.f16.bold.mk,
            h4,
            row.center.children([
              if (isOutgoing)
                Icons.call_made.icon.s16.color(isMissed ? Colors.red : Colors.green).mk
              else
                Icons.call_received.icon.s16.color(isMissed ? Colors.red : Colors.green).mk,
              w4,
              time.text.grey600.f14.mk,
            ]),
          ]),
          row.children([
            container.s40.circle.grey100.center.child(
              (isVideo ? Icons.videocam : Icons.phone).icon.grey800.s24.mk,
            ),
            w8,
            container.s40.circle.grey100.center.child(
              Icons.info_outline.icon.grey800.s24.mk,
            ),
          ]),
        ]),
      ),
    );
  }
} 