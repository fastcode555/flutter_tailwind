import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductFavoritesPage extends StatelessWidget {
  const FacebookProductFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: '我的收藏'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '商品'),
              Tab(text: '店铺'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProductList(),
            _buildShopList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemBuilder: (context, index) => _buildProductItem(context),
    );
  }

  Widget _buildProductItem(BuildContext context) {
    return container.white.rounded8.mb16.p16.child(
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
        // 操作按钮
        column.center.children([
          Icons.delete_outline.icon.grey600.s24.mk,
          h8,
          '删除'.text.grey600.f12.mk,
        ]),
      ]),
    );
  }

  Widget _buildShopList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemBuilder: (context, index) => _buildShopItem(),
    );
  }

  Widget _buildShopItem() {
    return container.white.rounded8.mb16.p16.child(
      row.children([
        // 店铺头像
        'https://picsum.photos/200'.image.s50.circle.mk,
        w16,
        // 店铺信息
        column.crossStart.expanded.children([
          '店铺名称'.text.f16.bold.mk,
          h4,
          '商品 123 | 关注 456'.text.grey600.f12.mk,
        ]),
        // 操作按钮
        container.blue.rounded8.p8.ph16.center.child(
          '进店'.text.white.f14.bold.mk,
        ),
      ]),
    );
  }
}
