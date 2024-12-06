import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookArchivedContentPage extends StatelessWidget {
  const FacebookArchivedContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: '已归档内容'.text.f20.bold.mk,
          bottom: const TabBar(
            tabs: [
              Tab(text: '帖子'),
              Tab(text: '故事'),
              Tab(text: '照片'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildArchivedPosts(),
            _buildArchivedStories(),
            _buildArchivedPhotos(),
          ],
        ),
      ),
    );
  }

  Widget _buildArchivedPosts() {
    return ListView.builder(
      itemBuilder: (context, index) => _buildArchivedPostItem(),
    );
  }

  Widget _buildArchivedStories() {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) => _buildArchivedStoryItem(),
    );
  }

  Widget _buildArchivedPhotos() {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) => _buildArchivedPhotoItem(),
    );
  }

  Widget _buildArchivedPostItem() {
    return container.white.borderB1.borderGrey200.p16.child(
      column.crossStart.children([
        row.children([
          'https://picsum.photos/200'.image.s40.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            '2023-12-25'.text.grey600.f14.mk,
          ]),
          container.blue.rounded8.p8.ph16.center.child(
            '恢复'.text.white.f14.bold.mk,
          ),
        ]),
        h12,
        '这是一条已归档的帖子内容...'.text.f14.mk,
      ]),
    );
  }

  Widget _buildArchivedStoryItem() {
    return Stack(
      children: [
        'https://picsum.photos/200'.image.wFull.hFull.cover.rounded8.mk,
        positioned.t8.r8.child(
          container.blue.rounded8.p4.ph8.center.child(
            '恢复'.text.white.f12.bold.mk,
          ),
        ),
      ],
    );
  }

  Widget _buildArchivedPhotoItem() {
    return Stack(
      children: [
        'https://picsum.photos/200'.image.wFull.hFull.cover.rounded8.mk,
        positioned.t8.r8.child(
          container.blue.rounded8.p4.ph8.center.child(
            '恢复'.text.white.f12.bold.mk,
          ),
        ),
      ],
    );
  }
}
