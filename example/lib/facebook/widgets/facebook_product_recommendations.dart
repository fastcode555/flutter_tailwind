import 'package:example/facebook/models/product.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductRecommendations extends StatelessWidget {
  final Product currentProduct;

  const FacebookProductRecommendations({
    required this.currentProduct,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return container.white.p16.child(
      column.crossStart.children([
        // 标题
        row.spaceBetween.children([
          '相关推荐'.text.f16.bold.mk,
          '查看更多'.text.blue.f14.mk,
        ]),
        h16,
        // 推荐列表
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) => _buildRecommendItem(
              context,
              products[index],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildRecommendItem(BuildContext context, Product product) {
    return container.w120.mr8
        .child(
          column.crossStart.children([
            // 商品图片
            product.imageUrl.image.h120.wFull.rounded8.cover.mk,
            h8,
            // 商品信息
            product.name.text.f14.bold.maxLine2.mk,
            h4,
            '¥${product.price}'.text.blue.f14.bold.mk,
          ]),
        )
        .click(onTap: () => AppRoutes.toProductDetail(context, product));
  }
}
