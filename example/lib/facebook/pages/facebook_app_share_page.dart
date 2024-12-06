import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookAppSharePage extends StatelessWidget {
  const FacebookAppSharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '分享应用'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 应用信息
          container.white.p16.child(
            column.center.children([
              'https://picsum.photos/100'.image.s80.mk,
              h16,
              'Facebook'.text.f20.bold.mk,
              h8,
              '版本 1.0.0'.text.grey600.f14.mk,
            ]),
          ),
          h16,
          // 分享方式
          container.white.child(
            column.children([
              _buildShareItem(
                Icons.message,
                '发送给朋友',
                '通过私信分享给好友',
              ),
              _buildShareItem(
                Icons.share,
                '分享到动态',
                '分享到你的个人动态',
              ),
              _buildShareItem(
                Icons.qr_code,
                '二维码分享',
                '生成应用二维码',
              ),
              _buildShareItem(
                Icons.link,
                '复制链接',
                '复制应用下载链接',
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildShareItem(IconData icon, String title, String subtitle) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          container.s50.circle.grey100.center.child(
            icon.icon.grey800.s24.mk,
          ),
          w12,
          column.crossStart.expanded.children([
            title.text.f16.bold.mk,
            h4,
            subtitle.text.grey600.f14.mk,
          ]),
          Icons.chevron_right.icon.grey600.s24.mk,
        ]),
      ),
    );
  }
} 