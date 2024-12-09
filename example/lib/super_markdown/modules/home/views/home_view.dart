import 'package:example/super_markdown/modules/home/controllers/home_controller.dart';
import 'package:example/super_markdown/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: container.p32.child(
        column.crossStart.children([
          // 标题
          row.spaceBetween.children([
            'Super Markdown'.text.f32.bold.mk,
            IconButton(
              icon: Icons.settings.icon.grey600.s24.mk,
              onPressed: () => Get.toNamed(Routes.SETTINGS),
            ),
          ]),
          h32,
          // 最近文件
          Obx(() => column.crossStart.children([
                '最近文件'.text.f20.bold.mk,
                h16,
                if (controller.recentFiles.isEmpty)
                  '暂无最近文件'.text.grey600.f14.mk
                else
                  ...controller.recentFiles.map(_buildRecentFileItem),
              ])),

          h32,

          // 快速操作
          column.crossStart.children([
            '快速操作'.text.f20.bold.mk,
            h16,
            row.spacing16.children([
              _buildActionButton(
                icon: Icons.add,
                label: '新建文档',
                onTap: controller.createNewFile,
              ),
              _buildActionButton(
                icon: Icons.folder_open,
                label: '打开文件',
                onTap: controller.openFile,
              ),
              _buildActionButton(
                icon: Icons.folder,
                label: '打开文件夹',
                onTap: controller.openFolder,
              ),
            ]),
          ]),
        ]),
      ),
    );
  }

  Widget _buildRecentFileItem(String filePath) {
    return container.white.rounded8.p16.mb8.cardShadow.child(
      row.children([
        // 文件图标
        container.s40.grey100.rounded8.center.child(
          Icons.description.icon.grey600.s24.mk,
        ),
        w16,
        // 文件信息
        column.crossStart.expanded.children([
          filePath.split('/').last.text.f16.bold.mk,
          filePath.text.grey600.f12.mk,
        ]),
        // 打开按钮
        IconButton(
          icon: Icons.arrow_forward.icon.grey600.s24.mk,
          onPressed: () => controller.openRecentFile(filePath),
        ),
      ]),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return container.white.rounded8.p16.w150.cardShadow.center
        .child(
          column.center.children([
            icon.icon.s32.grey600.mk,
            h8,
            label.text.f14.mk,
          ]),
        )
        .click(onTap: onTap);
  }
}
