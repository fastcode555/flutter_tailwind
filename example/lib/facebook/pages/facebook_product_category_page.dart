import 'package:example/facebook/models/product.dart';
import 'package:example/facebook/pages/facebook_product_filter_page.dart';
import 'package:example/facebook/pages/facebook_product_sort_page.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductCategoryPage extends StatelessWidget {
  final String category;

  const FacebookProductCategoryPage({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: category.text.f20.bold.mk,
        actions: [
          container.s40.circle.grey100.center.child(
            Icons.search.icon.grey800.s24.mk,
          ),
          w16,
          container.s40.circle.grey100.center
              .child(
                Icons.sort.icon.grey800.s24.mk,
              )
              .click(onTap: () => _showSortOptions(context)),
          w16,
          container.s40.circle.grey100.center
              .child(
                Icons.filter_list.icon.grey800.s24.mk,
              )
              .click(onTap: () => _showFilterOptions(context)),
          w16,
        ],
      ),
      body: column.children([
        // 筛选条件
        container.white.p12.child(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: row.children([
              _buildFilterChip('全部'),
              _buildFilterChip('价格'),
              _buildFilterChip('品牌'),
              _buildFilterChip('新旧'),
              _buildFilterChip('位置'),
            ]),
          ),
        ),
        // 商品列表
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16.r),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => _buildProductItem(
              context,
              products[index],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildFilterChip(String label) {
    return container.grey100.rounded16.p8.ph16.mr8.child(
      row.center.children([
        label.text.f14.mk,
        w4,
        Icons.arrow_drop_down.icon.grey600.s16.mk,
      ]),
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    return container.white.rounded8.cardShadow
        .child(
          column.crossStart.children([
            // 商品图片
            product.imageUrl.image.roundedT8.h120.wFull.cover.mk,
            // 商品信息
            container.p12.child(
              column.crossStart.children([
                product.name.text.f16.bold.mk,
                h4,
                '¥${product.price}'.text.blue.f14.bold.mk,
                h4,
                product.location.text.grey600.f12.mk,
              ]),
            ),
          ]),
        )
        .click(onTap: () => AppRoutes.toProductDetail(context, product));
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FacebookProductSortPage(),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const FacebookProductFilterPage(),
    );
  }
}
