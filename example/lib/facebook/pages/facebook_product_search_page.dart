import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductSearchPage extends StatelessWidget {
  const FacebookProductSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: container.grey100.rounded24.expanded.ph16.child(
          TextField(
            decoration: InputDecoration(
              hintText: '搜索商品',
              border: InputBorder.none,
              icon: Icons.search.icon.grey600.s24.mk,
            ),
            onSubmitted: (value) => _search(context, value),
          ),
        ),
      ),
      body: ListView(
        children: [
          // 搜索历史
          container.white.p16.child(
            column.crossStart.children([
              row.spaceBetween.children([
                '搜索历史'.text.grey600.f14.mk,
                '清空'.text.grey600.f14.mk.click(onTap: () => _clearHistory()),
              ]),
              h16,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'iPhone',
                  '电脑',
                  '耳机',
                  '��机',
                ].map((e) => _buildHistoryItem(context, e)).toList(),
              ),
            ]),
          ),
          h8,
          // 热门搜索
          container.white.p16.child(
            column.crossStart.children([
              '热门搜索'.text.grey600.f14.mk,
              h16,
              _buildHotSearchList(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, String keyword) {
    return container.grey100.rounded16.p8.ph12.child(
      row.center.children([
        keyword.text.f14.mk,
        w8,
        Icons.close.icon.grey600.s16.mk.click(
          onTap: () => _removeHistory(keyword),
        ),
      ]),
    ).click(onTap: () => _search(context, keyword));
  }

  Widget _buildHotSearchList(BuildContext context) {
    return column.children(
      List.generate(
        5,
        (index) => container.pv12.child(
          row.children([
            '${index + 1}'.text.grey600.f14.mk,
            w16,
            'Hot Keyword ${index + 1}'.text.f14.expanded.mk,
            '${10000 - index * 1000}次搜索'.text.grey600.f12.mk,
          ]),
        ).click(onTap: () => _search(context, 'Hot Keyword ${index + 1}')),
      ),
    );
  }

  void _search(BuildContext context, String keyword) {
    // TODO: 实现搜索功能
  }

  void _clearHistory() {
    // TODO: 清空搜索历史
  }

  void _removeHistory(String keyword) {
    // TODO: 删除单个搜索历史
  }
} 