import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookImageViewPage extends StatelessWidget {
  final String imageUrl;
  final String? userName;
  final String? timeAgo;

  const FacebookImageViewPage({
    required this.imageUrl,
    this.userName,
    this.timeAgo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 图片内容
          InteractiveViewer(
            child: Center(
              child: imageUrl.image.wFull.cover.mk,
            ),
          ),
          // 顶部信息栏
          positioned.l0.r0.t0.child(
            container.p16.child(
              row.children([
                if (userName != null) ...[
                  column.crossStart.expanded.children([
                    userName!.text.white.f16.bold.mk,
                    if (timeAgo != null) timeAgo!.text.white.f14.mk,
                  ]),
                ],
                Icons.close.icon.white.s24.iconClick(
                  onTap: () => Navigator.pop(context),
                ),
              ]),
            ),
          ),
          // 底部操作栏
          positioned.l0.r0.b0.child(
            container.p16.child(
              row.spaceEvenly.children([
                _buildActionButton(Icons.thumb_up_outlined, '赞'),
                _buildActionButton(Icons.chat_bubble_outline, '评论'),
                _buildActionButton(Icons.share_outlined, '分享'),
                _buildActionButton(Icons.more_horiz, '更多'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return column.center.children([
      icon.icon.white.s24.mk,
      h8,
      label.text.white.f12.mk,
    ]);
  }
}
