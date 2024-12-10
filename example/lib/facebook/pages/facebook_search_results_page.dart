import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookSearchResultsPage extends StatelessWidget {
  const FacebookSearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: container.grey100.rounded24.expanded.ph16.child(
          const TextField(
            decoration: InputDecoration(
              hintText: '搜索',
              border: InputBorder.none,
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: column.children([
          const TabBar(
            tabs: [
              Tab(text: '全部'),
              Tab(text: '帖子'),
              Tab(text: '用户'),
              Tab(text: '群组'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildAllResults(),
                _buildPostResults(),
                _buildUserResults(),
                _buildGroupResults(),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildAllResults() {
    return ListView(
      children: [
        _buildSection('用户', [_buildUserItem(), _buildUserItem()]),
        _buildSection('帖子', [_buildPostItem(), _buildPostItem()]),
        _buildSection('群组', [_buildGroupItem(), _buildGroupItem()]),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return container.white.child(
      column.crossStart.children([
        container.p16.child(title.text.f16.bold.mk),
        ...items,
      ]),
    );
  }

  Widget _buildUserItem() {
    return container.borderB1.borderGrey200.p16.child(
      row.children([
        'https://picsum.photos/200'.image.s50.circle.mk,
        w12,
        column.crossStart.expanded.children([
          'John Doe'.text.f16.bold.mk,
          h4,
          '5个共同好友'.text.grey600.f14.mk,
        ]),
      ]),
    );
  }

  Widget _buildPostItem() {
    return container.borderB1.borderGrey200.p16.child(
      column.crossStart.children([
        row.children([
          'https://picsum.photos/200'.image.s40.circle.mk,
          w12,
          column.crossStart.expanded.children([
            'John Doe'.text.f16.bold.mk,
            '2小时前'.text.grey600.f14.mk,
          ]),
        ]),
        h8,
        '这是一条帖子内容...'.text.f16.mk,
      ]),
    );
  }

  Widget _buildGroupItem() {
    return container.borderB1.borderGrey200.p16.child(
      row.children([
        'https://picsum.photos/300'.image.s50.rounded8.mk,
        w12,
        column.crossStart.expanded.children([
          'Flutter 开发者社区'.text.f16.bold.mk,
          h4,
          '1.2k 成员'.text.grey600.f14.mk,
        ]),
      ]),
    );
  }

  Widget _buildPostResults() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => _buildPostItem(),
    );
  }

  Widget _buildUserResults() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => _buildUserItem(),
    );
  }

  Widget _buildGroupResults() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => _buildGroupItem(),
    );
  }
}
