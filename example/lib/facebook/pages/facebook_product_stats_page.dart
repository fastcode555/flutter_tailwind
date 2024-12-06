import 'package:example/facebook/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductStatsPage extends StatelessWidget {
  final Product product;

  const FacebookProductStatsPage({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '商品数据'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 概览数据
          container.white.p16.child(
            column.crossStart.children([
              '数据概览'.text.f16.bold.mk,
              h16,
              row.spaceEvenly.children([
                _buildOverviewItem('浏览量', '1234', '12%'),
                _buildOverviewItem('收藏数', '456', '8%'),
                _buildOverviewItem('分享数', '789', '15%'),
              ]),
            ]),
          ),
          h8,
          // 趋势图表
          container.white.p16.child(
            column.crossStart.children([
              row.spaceBetween.children([
                '数据趋势'.text.f16.bold.mk,
                row.children([
                  _buildTimeButton('7天', true),
                  w8,
                  _buildTimeButton('30天', false),
                  w8,
                  _buildTimeButton('全部', false),
                ]),
              ]),
              h16,
              // TODO: 添加趋势图表
              container.h200.grey100.rounded8.center.child(
                '趋势图表'.text.grey600.f14.mk,
              ),
            ]),
          ),
          h8,
          // 用户画像
          container.white.p16.child(
            column.crossStart.children([
              '用户画像'.text.f16.bold.mk,
              h16,
              row.spaceEvenly.children([
                _buildUserPortrait('年龄分布', [
                  _buildPortraitItem('18-24岁', 0.3),
                  _buildPortraitItem('25-34岁', 0.4),
                  _buildPortraitItem('35-44岁', 0.2),
                  _buildPortraitItem('45岁以上', 0.1),
                ]),
                _buildUserPortrait('性别分布', [
                  _buildPortraitItem('男', 0.6),
                  _buildPortraitItem('女', 0.4),
                ]),
              ]),
            ]),
          ),
          h8,
          // 地域分布
          container.white.p16.child(
            column.crossStart.children([
              '地域分布'.text.f16.bold.mk,
              h16,
              column.crossStart.children([
                _buildRegionItem('上海', 0.3),
                _buildRegionItem('北京', 0.25),
                _buildRegionItem('广州', 0.2),
                _buildRegionItem('深圳', 0.15),
                _buildRegionItem('其他', 0.1),
              ]),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value, String rate) {
    return column.center.children([
      value.text.f24.bold.mk,
      h4,
      label.text.grey600.f14.mk,
      h4,
      row.center.children([
        Icons.arrow_upward.icon.green.s14.mk,
        rate.text.green.f12.mk,
      ]),
    ]);
  }

  Widget _buildTimeButton(String label, bool selected) {
    return container.grey100.rounded16.p8.ph12.color(selected ? Colors.blue : null).child(
          label.text.color(selected ? Colors.white : Colors.grey[600]).f14.mk,
        );
  }

  Widget _buildUserPortrait(String title, List<Widget> items) {
    return column.crossStart.expanded.children([
      title.text.f14.grey600.mk,
      h8,
      ...items,
    ]);
  }

  Widget _buildPortraitItem(String label, double value) {
    return container.pv4.child(
      row.spaceBetween.children([
        label.text.f12.grey600.mk,
        '${(value * 100).toInt()}%'.text.f12.grey600.mk,
      ]),
    );
  }

  Widget _buildRegionItem(String region, double value) {
    return container.pv8.child(
      row.children([
        region.text.grey600.f14.mk,
        Expanded(
          child: container.h4.grey100.rounded2.child(
            container.h4.blue.roundedL2.mk,
          ),
        ),
        '${(value * 100).toInt()}%'.text.grey600.f14.right.mk,
      ]),
    );
  }
}
