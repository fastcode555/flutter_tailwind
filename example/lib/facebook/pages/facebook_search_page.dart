import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookSearchPage extends StatelessWidget {
  const FacebookSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: container.grey100.rounded24.expanded.ph16.child(
          TextField(
            decoration: InputDecoration(
              hintText: '搜索',
              border: InputBorder.none,
              icon: Icons.search.icon.grey600.s24.mk,
            ),
          ),
        ),
      ),
      body: column.children([
        // 搜索历史
        container.p16.child(
          column.crossStart.children([
            '搜索历史'.text.grey600.f14.mk,
            h12,
            wrap.spacing8.children(
              [
                '朋友',
                '视频',
                '群组',
                '商品',
              ]
                  .map((e) => container.grey200.rounded16.p8.child(
                        e.text.f14.mk,
                      ))
                  .toList(),
            ),
          ]),
        ),
      ]),
    );
  }
}
