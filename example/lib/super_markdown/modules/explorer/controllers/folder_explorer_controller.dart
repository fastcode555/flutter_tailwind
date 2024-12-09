import 'dart:io';

import 'package:example/super_markdown/core/services/file_service.dart';
import 'package:example/super_markdown/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderExplorerController extends GetxController {
  final FileService _fileService = Get.find();

  // 加载状态
  final RxBool isLoading = false.obs;

  // 当前文件夹路径
  final RxString currentPath = ''.obs;

  // 文件夹树
  final RxList<FolderNode> folderTree = <FolderNode>[].obs;

  // 文件列表
  final RxList<FileNode> files = <FileNode>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialFolder();
  }

  // 加载初始文件夹
  Future<void> loadInitialFolder() async {
    isLoading.value = true;
    try {
      // TODO: 加载上次打开的文件夹或默认文件夹
      final defaultPath = Directory.current.path;
      await loadFolder(defaultPath);
    } finally {
      isLoading.value = false;
    }
  }

  // 加载文件夹
  Future<void> loadFolder(String path) async {
    isLoading.value = true;
    try {
      currentPath.value = path;
      await _loadFolderTree(path);
      await _loadFiles(path);
    } finally {
      isLoading.value = false;
    }
  }

  // 加载文件夹树
  Future<void> _loadFolderTree(String rootPath) async {
    final tree = <FolderNode>[];
    await _buildFolderTree(Directory(rootPath), tree, 0);
    folderTree.value = tree;
  }

  // 递归构建文件夹树
  Future<void> _buildFolderTree(Directory dir, List<FolderNode> tree, int level) async {
    final node = FolderNode(
      path: dir.path,
      name: dir.path.split(Platform.pathSeparator).last,
      level: level,
    );

    try {
      final entities = dir.listSync();
      final folders = entities.whereType<Directory>().toList();

      node.hasChildren = folders.isNotEmpty;
      tree.add(node);

      if (node.isExpanded && node.hasChildren) {
        for (final folder in folders) {
          await _buildFolderTree(folder, tree, level + 1);
        }
      }
    } catch (e) {
      print('Error loading folder: $e');
    }
  }

  // 加载文件列表
  Future<void> _loadFiles(String path) async {
    try {
      final dir = Directory(path);
      final entities = dir.listSync();
      final fileList = entities
          .whereType<File>()
          .where((f) => f.path.endsWith('.md'))
          .map((f) => FileNode(
                path: f.path,
                name: f.path.split(Platform.pathSeparator).last,
                modifiedTime: f.lastModifiedSync().toString(),
              ))
          .toList();
      files.value = fileList;
    } catch (e) {
      print('Error loading files: $e');
      files.value = [];
    }
  }

  // 展开/折叠文件夹
  void toggleFolder(FolderNode node) {
    node.isExpanded = !node.isExpanded;
    loadFolder(currentPath.value);
  }

  // 选择文件夹
  void selectFolder(FolderNode node) {
    loadFolder(node.path);
  }

  // 打开文件
  Future<void> openFile(FileNode file) async {
    await _fileService.openFile(file.path);
    Get.toNamed(Routes.EDITOR);
  }

  // 创建新文件
  Future<void> createNewFile() async {
    final result = await Get.dialog<String>(
      AlertDialog(
        title: const Text('新建文件'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: '输入文件名',
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: 'filename.md'),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result != null) {
      final path = '${currentPath.value}${Platform.pathSeparator}$result';
      await File(path).create();
      loadFolder(currentPath.value);
    }
  }

  // 创建新文件夹
  Future<void> createNewFolder() async {
    final result = await Get.dialog<String>(
      AlertDialog(
        title: const Text('新建文件夹'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: '输入文件夹名',
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: 'newfolder'),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result != null) {
      final path = '${currentPath.value}${Platform.pathSeparator}$result';
      await Directory(path).create();
      loadFolder(currentPath.value);
    }
  }

  // 重命名文件
  Future<void> renameFile(FileNode file) async {
    final result = await Get.dialog<String>(
      AlertDialog(
        title: const Text('重命名文件'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: '输入新文件名',
          ),
          controller: TextEditingController(text: file.name),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: 'newname.md'),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result != null) {
      final newPath = '${currentPath.value}${Platform.pathSeparator}$result';
      await File(file.path).rename(newPath);
      loadFolder(currentPath.value);
    }
  }

  // 复制文件
  Future<void> copyFile(FileNode file) async {
    final newPath = '${file.path}.copy';
    await File(file.path).copy(newPath);
    loadFolder(currentPath.value);
  }

  // 删除文件
  Future<void> deleteFile(FileNode file) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这个文件吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await File(file.path).delete();
      loadFolder(currentPath.value);
    }
  }
}

// 文件夹节点
class FolderNode {
  final String path;
  final String name;
  final int level;
  bool hasChildren;
  bool isExpanded;

  FolderNode({
    required this.path,
    required this.name,
    required this.level,
    this.hasChildren = false,
    this.isExpanded = false,
  });
}

// 文件节点
class FileNode {
  final String path;
  final String name;
  final String modifiedTime;

  FileNode({
    required this.path,
    required this.name,
    required this.modifiedTime,
  });
}
