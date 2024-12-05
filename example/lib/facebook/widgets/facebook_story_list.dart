import 'package:example/facebook/models/story.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookStoryList extends StatelessWidget {
  final List<Story> stories;

  const FacebookStoryList({
    required this.stories,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return container.h200.child(
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildCreateStory(context);
          }
          return _buildStoryItem(context, stories[index - 1], index - 1);
        },
      ),
    );
  }

  Widget _buildCreateStory(BuildContext context) {
    return container.w120.m8.white.rounded12
        .child(
          Stack(
            children: [
              'https://picsum.photos/200'.image.wFull.h120.cover.rounded8.mk,
              positioned.b0.l0.r0.child(
                container.white.p8.center.roundedB8.child(
                  column.center.children([
                    container.s32.circle.blue.center.child(
                      Icons.add.icon.white.s24.mk,
                    ),
                    h8,
                    '创建故事'.text.f12.bold.mk,
                  ]),
                ),
              ),
            ],
          ),
        )
        .click(onTap: () => AppRoutes.toStoryCreate(context));
  }

  Widget _buildStoryItem(BuildContext context, Story story, int index) {
    return container.w120.m8.rounded12
        .child(
          Stack(
            children: [
              if (story.imageUrl != null)
                story.imageUrl!.image.wFull.hFull.rounded8.cover.mk
              else
                container.wFull.hFull.color(story.backgroundColor ?? Colors.black).mk,
              // 用户头像
              positioned.t8.l8.child(
                container.s40.circle.border2.borderBlue.child(
                  story.userAvatar.image.s40.circle.mk,
                ),
              ),
              // 用户名
              positioned.b8.l8.r8.child(
                story.userName.text.white.f12.bold.mk,
              ),
              // 未读标记
              if (!story.isViewed)
                positioned.t8.l8.child(
                  container.s40.circle.border2.borderBlue.mk,
                ),
            ],
          ),
        )
        .click(onTap: () => AppRoutes.toStoryView(context, stories, initialIndex: index));
  }
}
