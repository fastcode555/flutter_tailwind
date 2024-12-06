import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookUpdateLogPage extends StatelessWidget {
  const FacebookUpdateLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '更新日志'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 当前版本
          container.white.p16.child(
            column.center.children([
              'https://picsum.photos/100'.image.s80.mk,
              h16,
              'Facebook'.text.f20.bold.mk,
              h8,
              '当前版本 1.0.0'.text.grey600.f14.mk,
            ]),
          ),
          h16,
          // 版本历史
          container.white.child(
            column.children([
              _buildVersionItem(
                version: '1.0.0',
                date: '2024-01-01',
                changes: [
                  '新增商品收藏夹功能',
                  '新增商品浏览历史功能',
                  '新增商品举报功能',
                  '新增商品分享统计功能',
                  '优化页面性能和用户体验',
                  '修复已知问题',
                ],
              ),
              _buildVersionItem(
                version: '0.9.0',
                date: '2023-12-01',
                changes: [
                  '新增商品搜索功能',
                  '新增商品分类功能',
                  '新增商品详情页',
                  '新增商品评价功能',
                  '优化UI界面',
                  '修复已知问题',
                ],
              ),
              _buildVersionItem(
                version: '0.8.0',
                date: '2023-11-01',
                changes: [
                  '新增个人主页功能',
                  '新增设置页面',
                  '新增消息通知功能',
                  '新增好友系统',
                  '优化应用性能',
                  '修复已知问题',
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionItem({
    required String version,
    required String date,
    required List<String> changes,
  }) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        column.crossStart.children([
          // 版本号和日期
          row.spaceBetween.children([
            'v$version'.text.f16.bold.mk,
            date.text.grey600.f14.mk,
          ]),
          h12,
          // 更新内容
          ...changes.map((change) => container.pv4.child(
                row.crossStart.children([
                  '•'.text.grey600.f14.mk,
                  w8,
                  change.text.f14.expanded.mk,
                ]),
              )),
        ]),
      ),
    );
  }
}
