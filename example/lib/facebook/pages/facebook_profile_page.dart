import 'package:example/facebook/models/story.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProfilePage extends StatelessWidget {
  const FacebookProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: column.children([
          // 封面和头像
          Stack(
            children: [
              // 封面图片
              'https://picsum.photos/500/200'.image.h200.wFull.cover.mk,
              // 编辑封面按钮
              positioned.b16.r16.child(
                container.s40.circle.black54.center
                    .child(Icons.camera_alt.icon.white.s24.mk)
                    .click(onTap: () => _editCoverPhoto(context)),
              ),
              // 头像
              positioned.b(-40).l16.child(
                    Stack(
                      children: [
                        'https://picsum.photos/200'.image.s100.circle.border4.borderWhite.cover.mk,
                        positioned.b0.r0.child(
                          container.s32.circle.blue.center
                              .child(Icons.camera_alt.icon.white.s20.mk)
                              .click(onTap: () => _editProfilePhoto(context)),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
          // 个人信息
          container.pt56.p16.white.child(
            column.crossStart.children([
              // 用户名和简介
              'John Doe'.text.f20.bold.mk,
              h8,
              '这是我的个人简介'.text.grey600.f14.mk,
              h16,
              // 操作按钮
              row.spaceEvenly.children([
                container.blue.rounded8.p12.expanded.center
                    .child('编辑资料'.text.white.f14.bold.mk)
                    .click(onTap: () => AppRoutes.toProfileEdit(context)),
                w8,
                container.grey200.rounded8.p12.expanded.center
                    .child('添加故事'.text.grey800.f14.bold.mk)
                    .click(onTap: () => AppRoutes.toStoryCreate(context)),
                w8,
                container.grey200.rounded8.p12.center
                    .child(Icons.more_horiz.icon.grey800.s24.mk)
                    .click(onTap: () => _showMoreOptions(context)),
              ]),
            ]),
          ),
          h8,
          // 故事列表
          container.white.p16.child(
            column.crossStart.children([
              row.spaceBetween.children([
                '故事集锦'.text.f16.bold.mk,
                '管理'.text.blue.f14.mk,
              ]),
              h16,
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildAddStoryItem(context);
                    }
                    return _buildStoryItem(context, stories[index - 1]);
                  },
                ),
              ),
            ]),
          ),
          h8,
          // 详细信息
          container.white.p16.child(
            column.crossStart.children([
              '详细信息'.text.f16.bold.mk,
              h16,
              _buildInfoItem(Icons.work, '在 Flutter 工作'),
              h8,
              _buildInfoItem(Icons.location_on, '居住在上海'),
              h8,
              _buildInfoItem(Icons.school, '毕业于某大学'),
              h8,
              _buildInfoItem(Icons.favorite, '单身'),
            ]),
          ),
          h8,
          // 照片
          container.white.p16.child(
            column.crossStart.children([
              row.spaceBetween.children([
                '照片'.text.f16.bold.mk,
                '查看全部'.text.blue.f14.mk,
              ]),
              h16,
              container.h400.child(
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: List.generate(
                    9,
                    (index) => 'https://picsum.photos/200?random=$index'.image.wFull.hFull.cover.rounded8.mk,
                  ),
                ),
              ),
            ]),
          ),
          h8,
          // 好友
          container.white.p16.child(
            column.crossStart.children([
              row.spaceBetween.children([
                '好友'.text.f16.bold.mk,
                '查看全部'.text.blue.f14.mk,
              ]),
              h16,
              container.h300.child(
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8,
                  children: List.generate(
                    6,
                    (index) => column.crossStart.children([
                      'https://picsum.photos/200?random=${index + 10}'.image.wFull.h100.cover.rounded8.mk,
                      h4,
                      '好友名称'.text.f14.bold.mk,
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return row.children([
      icon.icon.grey600.s20.mk,
      w8,
      text.text.f14.mk,
    ]);
  }

  Widget _buildAddStoryItem(BuildContext context) {
    return container.w100.mr8.white.rounded12
        .child(
          Stack(
            children: [
              'https://picsum.photos/200'.image.wFull.h100.roundedT8.cover.mk,
              positioned.b0.l0.r0.child(
                container.white.p8.center.child(
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

  Widget _buildStoryItem(BuildContext context, Story story) {
    return container.w100.mr8.rounded12
        .child(
          Stack(
            children: [
              if (story.imageUrl != null)
                story.imageUrl!.image.wFull.hFull.rounded8.cover.mk
              else
                container.wFull.hFull.rounded8.color(story.backgroundColor ?? Colors.black).mk,
              positioned.t8.l8.child(
                story.userAvatar.image.s40.circle.border2.borderBlue.mk,
              ),
              positioned.b8.l8.r8.child(
                story.text?.text.white.f12.bold.mk ?? const SizedBox(),
              ),
            ],
          ),
        )
        .click(onTap: () => AppRoutes.toStoryView(context, [story]));
  }

  void _editCoverPhoto(BuildContext context) {
    // TODO: 实现封面照片编辑
  }

  void _editProfilePhoto(BuildContext context) {
    // TODO: 实现头像照片编辑
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.child(
        column.crossStart.children([
          container.p16.borderB1.borderGrey200.wFull.child(
            '更多选项'.text.f16.bold.mk,
          ),
          _buildOptionItem(Icons.settings, '设置', onTap: () => AppRoutes.toSettings(context)),
          _buildOptionItem(Icons.qr_code, '我的二维码'),
          _buildOptionItem(Icons.archive, '存档'),
          _buildOptionItem(Icons.block, '黑名单'),
          container.h8.grey100.wFull.mk,
          _buildOptionItem(Icons.logout, '退出登录', isRed: true),
        ]),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String label, {bool isRed = false, VoidCallback? onTap}) {
    return container.p16.wFull
        .child(
          row.children([
            icon.icon.s24.color(isRed ? Colors.red : Colors.grey[800]).mk,
            w16,
            label.text.f16.color(isRed ? Colors.red : Colors.black).mk,
          ]),
        )
        .click(onTap: onTap);
  }
}
