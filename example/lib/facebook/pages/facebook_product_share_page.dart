import 'package:example/facebook/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductSharePage extends StatelessWidget {
  final Product product;

  const FacebookProductSharePage({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '分享商品'.text.f20.bold.mk,
        actions: [
          container.blue.rounded8.p12.ph16.m8.center.child(
            '分享'.text.white.f14.bold.mk,
          ),
        ],
      ),
      body: ListView(
        children: [
          // 分享方式
          container.white.p16.child(
            column.crossStart.children([
              '分享到'.text.f16.bold.mk,
              h16,
              row.children([
                _buildShareOption(Icons.public, '动态'),
                w8,
                _buildShareOption(Icons.group, '群组'),
                w8,
                _buildShareOption(Icons.person, '好友'),
                w8,
                _buildShareOption(Icons.messenger_outline, 'Messenger'),
              ]),
            ]),
          ),
          h8,
          // 商品预览
          container.white.p16.child(
            column.crossStart.children([
              row.children([
                product.imageUrl.image.s80.rounded8.mk,
                w12,
                column.crossStart.expanded.children([
                  product.name.text.f16.bold.mk,
                  h4,
                  '¥${product.price}'.text.blue.f14.bold.mk,
                ]),
              ]),
            ]),
          ),
          h8,
          // 添加说明
          container.white.p16.child(
            column.crossStart.children([
              '添加说明'.text.f16.bold.mk,
              h16,
              container.grey100.rounded8.p12.wFull.child(
                const TextField(
                  decoration: InputDecoration(
                    hintText: '说点什么...',
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return container.grey100.rounded8.p12.expanded.child(
      column.center.children([
        icon.icon.grey800.s24.mk,
        h8,
        label.text.f14.mk,
      ]),
    );
  }
}
