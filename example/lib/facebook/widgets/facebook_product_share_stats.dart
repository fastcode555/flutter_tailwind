import 'package:example/facebook/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductShareStats extends StatelessWidget {
  final Product product;

  const FacebookProductShareStats({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return container.white.p16.child(
      column.crossStart.children([
        // 标题
        row.spaceBetween.children([
          '分享统计'.text.f16.bold.mk,
          '查看详情'.text.blue.f14.mk,
        ]),
        h16,
        // 统计数据
        row.spaceEvenly.children([
          _buildStatItem('总分享', '1234'),
          _buildStatItem('今日分享', '123'),
          _buildStatItem('分享转化', '12.3%'),
        ]),
        h16,
        // 分享渠道占比
        column.crossStart.children([
          '分享渠道'.text.f14.grey600.mk,
          h8,
          _buildChannelBar('朋友圈', 0.4),
          h8,
          _buildChannelBar('好友', 0.3),
          h8,
          _buildChannelBar('群组', 0.2),
          h8,
          _buildChannelBar('其他', 0.1),
        ]),
      ]),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return column.center.children([
      value.text.f20.bold.mk,
      h4,
      label.text.grey600.f14.mk,
    ]);
  }

  Widget _buildChannelBar(String label, double value) {
    return row.children([
      label.text.grey600.f14.mk,
      Expanded(
        child: container.h4.grey100.rounded2.child(
          container.h4.blue.roundedL2.mk,
        ),
      ),
      '${(value * 100).toInt()}%'.text.grey600.f14.right.mk,
    ]);
  }
}
