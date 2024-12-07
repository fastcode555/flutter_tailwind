import 'package:example/facebook/models/product.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookMarketplacePage extends StatelessWidget {
  const FacebookMarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '商城'.text.f20.bold.mk,
        actions: [
          container.s40.circle.grey100.center.child(
            Icons.search.icon.grey800.s24.mk,
          ),
          w16,
        ],
      ),
      body: column.children([
        // 分类列表
        container.h100.white.child(
          ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(16.r),
            children: [
              _buildCategoryItem(Icons.car_rental, '汽车', context),
              _buildCategoryItem(Icons.house, '房产', context),
              _buildCategoryItem(Icons.phone_android, '电子产品', context),
              _buildCategoryItem(Icons.chair, '家具', context),
              _buildCategoryItem(Icons.shopping_bag, '服饰', context),
            ],
          ),
        ),
        // 商品列表
        Expanded(
          child: gridview.crossAxisCount2.p16.p16.ratio80.builder(
            20,
            (context, index) => _buildProductItem(context),
          ),
        ),
      ]),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, BuildContext context) {
    return container.w80.mr8
        .child(
          column.center.spaceEvenly.children([
            container.s50.circle.grey100.center.child(
              icon.icon.grey800.s24.mk,
            ),
            label.text.f14.mk,
          ]),
        )
        .click(onTap: () => AppRoutes.toProductCategory(context, label));
  }

  Widget _buildProductItem(BuildContext context) {
    return container.white.rounded8.cardShadow
        .child(
          column.crossStart.children([
            // 商品图片
            'https://picsum.photos/200'.image.roundedT8.h120.wFull.cover.mk,
            // 商品信息
            column.crossStart.pl12.children([
              h8,
              '商品名称'.text.f16.bold.mk,
              '¥99.99'.text.blue.f14.bold.mk,
              '上海'.text.grey600.f12.mk,
            ]),
          ]),
        )
        .click(onTap: () => AppRoutes.toProductDetail(context, products[0]));
  }
}
