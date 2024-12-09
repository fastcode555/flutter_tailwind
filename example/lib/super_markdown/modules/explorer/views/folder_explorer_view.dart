import 'package:example/super_markdown/modules/explorer/controllers/folder_explorer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class FolderExplorerView extends GetView<FolderExplorerController> {
  const FolderExplorerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '文件浏览器'.text.f20.bold.mk,
        actions: [
          // 新建文件按钮
          IconButton(
            icon: Icons.note_add.icon.grey600.s24.mk,
            onPressed: controller.createNewFile,
          ),
          // 新建文件夹按钮
          IconButton(
            icon: Icons.create_new_folder.icon.grey600.s24.mk,
            onPressed: controller.createNewFolder,
          ),
        ],
      ),
      body: Row(
        children: [
          // 文件夹树
          container.w250.borderR1.borderGrey200.child(
            Obx(_buildFolderTree),
          ),

          // 文件列表
          Expanded(
            child: Obx(_buildFileList),
          ),
        ],
      ),
    );
  }

  Widget _buildFolderTree() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: controller.folderTree.length,
      itemBuilder: (context, index) {
        final item = controller.folderTree[index];
        return _buildFolderItem(item);
      },
    );
  }

  Widget _buildFolderItem(FolderNode node) {
    return container.pl(node.level * 16.0).child(
          row.children([
            // 展开/折叠图标
            if (node.hasChildren)
              IconButton(
                icon: node.isExpanded
                    ? Icons.keyboard_arrow_down.icon.grey600.s20.mk
                    : Icons.keyboard_arrow_right.icon.grey600.s20.mk,
                onPressed: () => controller.toggleFolder(node),
              )
            else
              w40,

            // 文件夹图标和名称
            Expanded(
              child: container.pv8
                  .child(
                    row.children([
                      Icons.folder.icon.amber.s20.mk,
                      w8,
                      node.name.text.f14.mk,
                    ]),
                  )
                  .click(onTap: () => controller.selectFolder(node)),
            ),
          ]),
        );
  }

  Widget _buildFileList() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.files.isEmpty) {
      return Center(
        child: '暂无文件'.text.grey600.f14.mk,
      );
    }

    return ListView.builder(
      itemCount: controller.files.length,
      itemBuilder: (context, index) {
        final file = controller.files[index];
        return _buildFileItem(file, context);
      },
    );
  }

  Widget _buildFileItem(FileNode file, BuildContext context) {
    return container.borderB1.borderGrey200.p16.child(
      row.children([
        // 文件图标
        Icons.description.icon.grey600.s24.mk,
        w16,
        // 文件名
        column.crossStart.expanded.children([
          file.name.text.f14.bold.mk,
          h4,
          file.modifiedTime.text.grey600.f12.mk,
        ]),
        // 操作按钮
        row.children([
          IconButton(
            icon: Icons.edit.icon.grey600.s20.mk,
            onPressed: () => controller.openFile(file),
          ),
          IconButton(
            icon: Icons.more_vert.icon.grey600.s20.mk,
            onPressed: () => _showFileMenu(context, file),
          ),
        ]),
      ]),
    );
  }

  void _showFileMenu(BuildContext context, FileNode file) {
    Get.dialog(
      AlertDialog(
        title: '文件操作'.text.f16.bold.mk,
        content: column.children([
          _buildMenuItem(
            icon: Icons.drive_file_rename_outline,
            label: '重命名',
            onTap: () {
              Get.back();
              controller.renameFile(file);
            },
          ),
          _buildMenuItem(
            icon: Icons.file_copy,
            label: '复制',
            onTap: () {
              Get.back();
              controller.copyFile(file);
            },
          ),
          _buildMenuItem(
            icon: Icons.delete,
            label: '删除',
            onTap: () {
              Get.back();
              controller.deleteFile(file);
            },
            isRed: true,
          ),
        ]),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isRed = false,
  }) {
    return container.p12.wFull
        .child(
          row.children([
            Icon(icon, size: 20, color: isRed ? Colors.red : Colors.grey[800]),
            w16,
            label.text.f14.color(isRed ? Colors.red : Colors.black).mk,
          ]),
        )
        .click(onTap: onTap);
  }
}
