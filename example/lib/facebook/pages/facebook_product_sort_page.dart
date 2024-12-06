import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductSortPage extends StatelessWidget {
  const FacebookProductSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '排序'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          _buildSortItem('综合排序', true),
          _buildSortItem('价格从低到高', false),
          _buildSortItem('价格从高到低', false),
          _buildSortItem('销量优先', false),
          _buildSortItem('评分优先', false),
          _buildSortItem('最新发布', false),
        ],
      ),
    );
  }

  Widget _buildSortItem(String label, bool selected) {
    return container.white.borderB1.borderGrey200.p16.child(
      row.spaceBetween.children([
        label.text.f16.mk,
        if (selected) Icons.check.icon.blue.s24.mk,
      ]),
    );
  }
}
