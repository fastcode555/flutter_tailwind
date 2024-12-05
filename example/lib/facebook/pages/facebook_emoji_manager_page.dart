import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookEmojiManagerPage extends StatelessWidget {
  const FacebookEmojiManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: '表情管理'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '常用'),
              Tab(text: '收藏'),
              Tab(text: '表情包'),
              Tab(text: '商店'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRecentEmojis(),
            _buildFavoriteEmojis(),
            _buildStickerPacks(),
            _buildEmojiStore(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentEmojis() {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: 20,
      itemBuilder: (context, index) => _buildEmojiItem('😀'),
    );
  }

  Widget _buildFavoriteEmojis() {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: 12,
      itemBuilder: (context, index) => _buildEmojiItem('❤️'),
    );
  }

  Widget _buildStickerPacks() {
    return ListView(
      children: List.generate(
        5,
        (index) => _buildStickerPackItem(
          '表情包 ${index + 1}',
          'https://picsum.photos/100?random=$index',
        ),
      ),
    );
  }

  Widget _buildEmojiStore() {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: 10,
      itemBuilder: (context, index) => _buildStoreItem(
        '表情包 ${index + 1}',
        'https://picsum.photos/200/300?random=$index',
        index % 2 == 0,
      ),
    );
  }

  Widget _buildEmojiItem(String emoji) {
    return container.grey100.rounded12.center.child(
      emoji.text.f32.mk,
    );
  }

  Widget _buildStickerPackItem(String name, String imageUrl) {
    return container.white.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          imageUrl.image.s60.rounded12.mk,
          w16,
          column.crossStart.expanded.children([
            name.text.f16.bold.mk,
            h4,
            '12个表情'.text.grey600.f14.mk,
          ]),
          container.blue.rounded8.p8.ph16.center.child(
            '使用'.text.white.f14.bold.mk,
          ),
        ]),
      ),
    );
  }

  Widget _buildStoreItem(String name, String imageUrl, bool isFree) {
    return container.white.rounded12.cardShadow.child(
      column.crossStart.children([
        imageUrl.image.wFull.h160.cover.mk,
        container.p12.child(
          column.crossStart.children([
            name.text.f16.bold.mk,
            h4,
            '12个表情'.text.grey600.f14.mk,
            h8,
            container.blue.rounded8.p8.wFull.center.child(
              (isFree ? '免费获取' : '￥6.00').text.white.f14.bold.mk,
            ),
          ]),
        ),
      ]),
    );
  }
}
