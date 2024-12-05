import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookVideoCallPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const FacebookVideoCallPage({
    required this.userName,
    required this.userAvatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 对方视频画面
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(userAvatar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 自己的小窗口
          positioned.t16.t100.child(
            container.w120.h160.rounded12.child(
              'https://picsum.photos/200'.image.wFull.hFull.cover.mk,
            ),
          ),
          // 顶部信息栏
          positioned.t0.l0.r0.child(
            container.p16.child(
              row.spaceBetween.children([
                column.crossStart.children([
                  userName.text.white.f16.bold.mk,
                  '00:32'.text.white.f14.mk,
                ]),
                row.children([
                  container.s40.circle.black54.center.child(
                    Icons.switch_camera_outlined.icon.white.s24.mk,
                  ),
                  w16,
                  container.s40.circle.black54.center.child(
                    Icons.more_horiz.icon.white.s24.mk,
                  ),
                ]),
              ]),
            ),
          ),
          // 底部控制栏
          positioned.b0.l0.r0.child(
            container.p16.child(
              row.spaceEvenly.children([
                _buildControlButton(
                  Icons.videocam_off,
                  '关闭视频',
                  onTap: () {},
                ),
                _buildControlButton(
                  Icons.mic_off,
                  '静音',
                  onTap: () {},
                ),
                _buildControlButton(
                  Icons.call_end,
                  '挂断',
                  color: Colors.red,
                  onTap: () => Navigator.pop(context),
                ),
                _buildControlButton(
                  Icons.volume_up,
                  '扬声器',
                  onTap: () {},
                ),
                _buildControlButton(
                  Icons.chat,
                  '聊天',
                  onTap: () {},
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    IconData icon,
    String label, {
    Color? color,
    VoidCallback? onTap,
  }) {
    return column.center.children([
      container.s50.circle
          .color(color ?? Colors.grey[800])
          .center
          .child(
            icon.icon.white.s24.mk,
          )
          .click(onTap: onTap),
      h8,
      label.text.white.f12.mk,
    ]);
  }
}
