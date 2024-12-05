import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookChatThemePage extends StatelessWidget {
  const FacebookChatThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: '主题设置'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '推荐'),
              Tab(text: '简约'),
              Tab(text: '炫彩'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRecommendThemes(),
            _buildSimpleThemes(),
            _buildColorfulThemes(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendThemes() {
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        _buildThemeItem(
          '默认主题',
          Colors.blue,
          Colors.grey[100]!,
          isSelected: true,
        ),
        h16,
        _buildThemeItem(
          '暗夜模式',
          Colors.grey[900]!,
          Colors.grey[800]!,
        ),
        h16,
        _buildThemeItem(
          '护眼模式',
          Colors.green[100]!,
          Colors.green[50]!,
        ),
      ],
    );
  }

  Widget _buildSimpleThemes() {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildSimpleThemeItem(
        '简约主题 ${index + 1}',
        Colors.primaries[index],
      ),
    );
  }

  Widget _buildColorfulThemes() {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildColorfulThemeItem(
        '炫彩主题 ${index + 1}',
        'https://picsum.photos/200/300?random=$index',
      ),
    );
  }

  Widget _buildThemeItem(
    String name,
    Color primary,
    Color secondary, {
    bool isSelected = false,
  }) {
    return container.white.rounded12.cardShadow.child(
      column.crossStart.children([
        // 预览区域
        container.h160.color(primary).p16.child(
              column.spaceBetween.children([
                row.spaceBetween.children([
                  name.text.white.f16.bold.mk,
                  if (isSelected)
                    container.s24.circle.white.center.child(
                      Icons.check.icon.color(primary).s16.mk,
                    ),
                ]),
                row.end.children([
                  container.rounded16.p8.color(secondary).child(
                        '示例消息'.text.color(primary).f14.mk,
                      ),
                ]),
              ]),
            ),
        // 操作按钮
        container.p12.center.child(
          container.blue.rounded8.p12.ph24.center.child(
            '使用'.text.white.f14.bold.mk,
          ),
        ),
      ]),
    );
  }

  Widget _buildSimpleThemeItem(String name, Color color) {
    return container.white.rounded12.cardShadow.child(
      column.crossStart.children([
        container.h160.color(color).p16.child(
              column.spaceBetween.children([
                name.text.white.f16.bold.mk,
                row.end.children([
                  container.rounded16.p8.white.child(
                    '示例消息'.text.color(color).f14.mk,
                  ),
                ]),
              ]),
            ),
        container.p12.center.child(
          container.blue.rounded8.p12.ph24.center.child(
            '使用'.text.white.f14.bold.mk,
          ),
        ),
      ]),
    );
  }

  Widget _buildColorfulThemeItem(String name, String imageUrl) {
    return container.white.rounded12.cardShadow.child(
      column.crossStart.children([
        Stack(
          children: [
            imageUrl.image.h160.wFull.cover.mk,
            container.h160.wFull.p16.child(
              column.spaceBetween.children([
                name.text.white.f16.bold.mk,
                row.end.children([
                  container.rounded16.p8.black54.child(
                    '示例消息'.text.white.f14.mk,
                  ),
                ]),
              ]),
            ),
          ],
        ),
        container.p12.center.child(
          container.blue.rounded8.p12.ph24.center.child(
            '使用'.text.white.f14.bold.mk,
          ),
        ),
      ]),
    );
  }
}
