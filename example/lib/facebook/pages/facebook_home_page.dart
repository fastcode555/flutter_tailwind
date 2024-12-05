import 'package:example/facebook/models/story.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:example/facebook/widgets/facebook_app_bar.dart';
import 'package:example/facebook/widgets/facebook_post_list.dart';
import 'package:example/facebook/widgets/facebook_story_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookHomePage extends StatelessWidget {
  const FacebookHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const FacebookAppBar(),
      body: SingleChildScrollView(
        child: column.children([
          // 故事列表
          FacebookStoryList(stories: stories),
          // 分隔线
          container.h8.grey200.mk,
          // 帖子列表
          const FacebookPostList(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRoutes.toPostEdit(context),
        child: Icons.edit.icon.white.s24.mk,
      ),
    );
  }
}
