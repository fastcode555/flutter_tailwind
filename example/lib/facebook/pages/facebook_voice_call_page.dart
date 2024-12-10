import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookVoiceCallPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const FacebookVoiceCallPage({
    required this.userName,
    required this.userAvatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: column.spaceBetween.children([
          // 顶部信息
          container.p16.child(
            column.center.children([
              userAvatar.image.s100.circle.border4.borderWhite.mk,
              h16,
              userName.text.white.f20.bold.mk,
              h8,
              '正在通话'.text.white.f16.mk,
              h8,
              '00:32'.text.white.f14.mk,
            ]),
          ),
          // 底部控制按钮
          container.p32.child(
            row.spaceEvenly.children([
              _buildControlButton(
                Icons.volume_up,
                '扬声器',
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
            ]),
          ),
        ]),
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
      container.s60.circle
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
