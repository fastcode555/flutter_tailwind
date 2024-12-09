import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductFilterPage extends StatelessWidget {
  const FacebookProductFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '筛选'.text.f20.bold.mk,
        actions: [
          '重置'.text.blue.f14.mk.click(onTap: () => _resetFilter(context)),
          w16,
        ],
      ),
      body: ListView(
        children: [
          // 价格区间
          _buildSection(
            '价格区间',
            child: column.crossStart.children([
              row.children([
                container.grey100.rounded8.p12.expanded.child(
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '最低价',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                w16,
                container.grey100.rounded8.p12.expanded.child(
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '最高价',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ]),
              h16,
              wrap.spacing8.runSpacing8.children(
                [
                  '0-1000',
                  '1000-3000',
                  '3000-5000',
                  '5000以上',
                ].map(_buildPriceTag).toList(),
              ),
            ]),
          ),
          // 品牌
          _buildSection(
            '品牌',
            child: wrap.spacing8.runSpacing8.children(
              [
                'Apple',
                'Samsung',
                'Huawei',
                'Xiaomi',
                'OPPO',
                'VIVO',
              ].map(_buildBrandTag).toList(),
            ),
          ),
          // 商品状态
          _buildSection(
            '商品状态',
            child: wrap.spacing8.runSpacing8.children(
              [
                '全新',
                '99新',
                '95新',
                '9成新',
                '8成新',
              ].map(_buildConditionTag).toList(),
            ),
          ),
          // 更多筛选
          _buildSection(
            '更多筛选',
            child: column.crossStart.children([
              _buildSwitchItem('包邮', true),
              _buildSwitchItem('7天无理由退货', true),
              _buildSwitchItem('正品保障', true),
              _buildSwitchItem('急速发货', false),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: container.white.borderT1.borderGrey200.p12.h56.child(
        row.children([
          container.grey200.rounded8.p12.expanded.center.child(
            '重置'.text.grey800.f16.bold.mk,
          ),
          w16,
          container.blue.rounded8.p12.expanded.center.child(
            '确定'.text.white.f16.bold.mk,
          ),
        ]),
      ),
    );
  }

  Widget _buildSection(String title, {required Widget child}) {
    return container.white.p16.borderB1.borderGrey200.child(
      column.crossStart.children([
        title.text.f16.bold.mk,
        h16,
        child,
      ]),
    );
  }

  Widget _buildPriceTag(String text) {
    return container.grey100.rounded8.p8.ph16.child(
      text.text.f14.mk,
    );
  }

  Widget _buildBrandTag(String text) {
    return container.grey100.rounded8.p8.ph16.child(
      text.text.f14.mk,
    );
  }

  Widget _buildConditionTag(String text) {
    return container.grey100.rounded8.p8.ph16.child(
      text.text.f14.mk,
    );
  }

  Widget _buildSwitchItem(String label, bool value) {
    return container.pv12.child(
      row.spaceBetween.children([
        label.text.f14.mk,
        Switch(
          value: value,
          onChanged: (_) {},
        ),
      ]),
    );
  }

  void _resetFilter(BuildContext context) {
    // TODO: 实现重置筛选
  }
}
