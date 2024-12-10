import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductHistoryPage extends StatelessWidget {
  const FacebookProductHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '浏览历史'.text.f20.bold.mk,
        actions: [
          '清空'.text.blue.f14.mk.click(onTap: () => _clearHistory(context)),
          w16,
        ],
      ),
      body: ListView(
        children: [
          // 今天
          _buildDateSection('今天', [
            _buildHistoryItem(context),
            _buildHistoryItem(context),
          ]),
          // 昨天
          _buildDateSection('昨天', [
            _buildHistoryItem(context),
            _buildHistoryItem(context),
          ]),
          // 更早
          _buildDateSection('更早', [
            _buildHistoryItem(context),
            _buildHistoryItem(context),
          ]),
        ],
      ),
    );
  }

  Widget _buildDateSection(String date, List<Widget> items) {
    return column.crossStart.children([
      container.p16.child(
        date.text.grey600.f14.mk,
      ),
      ...items,
    ]);
  }

  Widget _buildHistoryItem(BuildContext context) {
    return container.white.borderB1.borderGrey200.p16.child(
      row.children([
        // 商品图片
        'https://picsum.photos/200'.image.s80.rounded8.mk,
        w16,
        // 商品信息
        column.crossStart.expanded.children([
          '商品名称'.text.f16.bold.mk,
          h4,
          '¥99.99'.text.blue.f14.bold.mk,
          h4,
          '上海'.text.grey600.f12.mk,
        ]),
        // 删除按钮
        Icons.close.icon.grey600.s24.mk,
      ]),
    );
  }

  void _clearHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: '清空浏览历史'.text.f16.bold.mk,
        content: '确定要清空全部浏览历史吗？'.text.f14.mk,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: '取消'.text.grey600.f14.mk,
          ),
          TextButton(
            onPressed: () {
              // TODO: 清空浏览历史
              Navigator.pop(context);
            },
            child: '确定'.text.blue.f14.mk,
          ),
        ],
      ),
    );
  }
}
