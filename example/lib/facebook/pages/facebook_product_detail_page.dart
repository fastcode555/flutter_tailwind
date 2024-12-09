import 'package:example/facebook/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductDetailPage extends StatelessWidget {
  final Product product;

  const FacebookProductDetailPage({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 商品图片
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: product.imageUrl.image.wFull.cover.mk,
            ),
          ),
          SliverToBoxAdapter(
            child: column.children([
              // 商品信息
              container.white.p16.child(
                column.crossStart.children([
                  // 价格
                  '¥${product.price}'.text.blue.f24.bold.mk,
                  h8,
                  // 商品名称
                  product.name.text.f20.bold.mk,
                  h8,
                  // 位置
                  row.children([
                    Icons.location_on.icon.grey600.s16.mk,
                    w4,
                    product.location.text.grey600.f14.mk,
                  ]),
                  h16,
                  // 商品状态
                  wrap.spacing8.runSpacing8.children(
                    [
                      _buildTag(product.condition),
                      _buildTag(product.category),
                    ],
                  ),
                ]),
              ),
              h8,
              // 商品描述
              container.white.p16.child(
                column.crossStart.children([
                  '商品描述'.text.f16.bold.mk,
                  h16,
                  product.description.text.f14.mk,
                ]),
              ),
              h8,
              // 卖家信息
              container.white.p16.child(
                column.crossStart.children([
                  '卖家信息'.text.f16.bold.mk,
                  h16,
                  row.children([
                    product.sellerAvatar.image.s50.circle.mk,
                    w12,
                    column.crossStart.expanded.children([
                      product.sellerName.text.f16.bold.mk,
                      h4,
                      '在售商品 12'.text.grey600.f14.mk,
                    ]),
                    container.blue.rounded8.p12.center.child(
                      '联系卖家'.text.white.f14.bold.mk,
                    ),
                  ]),
                ]),
              ),
            ]),
          ),
        ],
      ),
      // 底部操作栏
      bottomNavigationBar: container.white.borderT1.borderGrey200.p12.h56.child(
        row.children([
          container.s40.circle.grey100.center.child(
            Icons.favorite_border.icon.grey800.s24.mk,
          ),
          w16,
          container.s40.circle.grey100.center.child(
            Icons.share.icon.grey800.s24.mk,
          ),
          w16,
          container.blue.rounded8.p12.expanded.center.child(
            '立即购买'.text.white.f16.bold.mk,
          ),
        ]),
      ),
    );
  }

  Widget _buildTag(String text) {
    return container.grey100.rounded16.p8.ph12.child(
      text.text.grey600.f12.mk,
    );
  }
}
