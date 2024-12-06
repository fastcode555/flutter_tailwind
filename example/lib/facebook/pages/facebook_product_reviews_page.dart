import 'package:example/facebook/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductReviewsPage extends StatelessWidget {
  final Product product;

  const FacebookProductReviewsPage({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '商品评价'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 评分统计
          container.white.p16.child(
            column.crossStart.children([
              row.children([
                column.center.expanded.children([
                  '4.8'.text.f32.bold.mk,
                  '综合评分'.text.grey600.f14.mk,
                ]),
                column.crossStart.expanded.children([
                  _buildRatingBar('5星', 0.8),
                  _buildRatingBar('4星', 0.15),
                  _buildRatingBar('3星', 0.03),
                  _buildRatingBar('2星', 0.01),
                  _buildRatingBar('1星', 0.01),
                ]),
              ]),
            ]),
          ),
          h8,
          // 评价标签
          container.white.p16.child(
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                '质量不错(123)',
                '物流快(98)',
                '服务好(76)',
                '性价比高(45)',
              ].map((e) => _buildTag(e)).toList(),
            ),
          ),
          h8,
          // 评价列表
          container.white.child(
            column.children([
              _buildReviewItem(),
              _buildReviewItem(),
              _buildReviewItem(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String label, double value) {
    return container.mb8.child(
      row.children([
        label.text.grey600.f12.mk,
        container.h4.grey100.rounded2.expanded.child(
          container.h4.blue.roundedL2.mk,
        ),
        '${(value * 100).toInt()}%'.text.grey600.f12.right.mk,
      ]),
    );
  }

  Widget _buildTag(String text) {
    return container.grey100.rounded16.p8.ph12.child(
      text.text.grey600.f12.mk,
    );
  }

  Widget _buildReviewItem() {
    return container.borderB1.borderGrey200.p16.child(
      column.crossStart.children([
        // 用户信息
        row.children([
          'https://picsum.photos/200'.image.s40.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            row.children([
              _buildStarRating(4.5),
              w8,
              '2023-12-25'.text.grey600.f12.mk,
            ]),
          ]),
        ]),
        h12,
        // 评价内容
        '这是一条商品评价内容...'.text.f14.mk,
        h12,
        // 评价图片
        Wrap(
          spacing: 8.r,
          runSpacing: 8.r,
          children: [
            'https://picsum.photos/200'.image.s80.rounded8.mk,
            'https://picsum.photos/201'.image.s80.rounded8.mk,
            'https://picsum.photos/202'.image.s80.rounded8.mk,
          ],
        ),
      ]),
    );
  }

  Widget _buildStarRating(double rating) {
    return row.children([
      for (var i = 0; i < 5; i++) Icons.star.icon.s14.color(i < rating ? Colors.amber : Colors.grey[300]).mk,
    ]);
  }
}
