import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class StorageService extends GetxService {
  late final Directory _appDir;
  final Map<String, Directory> _directories = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initDirectories();
  }

  // 初始化目录
  Future<void> _initDirectories() async {
    _appDir = await getApplicationDocumentsDirectory();
  }

  // 获取或创建目录
  Future<Directory> _getDirectory(String name) async {
    if (!_directories.containsKey(name)) {
      final dir = Directory('${_appDir.path}/$name');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      _directories[name] = dir;
    }
    return _directories[name]!;
  }

  // 保存图片
  Future<String> saveImage(String sourcePath, String directory) async {
    final file = File(sourcePath);
    if (!await file.exists()) throw Exception('Source file not found');

    // 读取��片
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) throw Exception('Invalid image file');

    // 生成文件名
    final hash = md5.convert(bytes).toString();
    final ext = path.extension(sourcePath);
    final fileName = '$hash$ext';

    // 保存图片
    final dir = await _getDirectory(directory);
    final targetPath = '${dir.path}/$fileName';
    final targetFile = File(targetPath);

    // 如果文件已存在，直接返回路径
    if (await targetFile.exists()) {
      return targetPath;
    }

    // 压缩和保存
    final compressedImage = img.copyResize(
      image,
      width: 1920,
      height: 1080,
      maintainAspect: true,
    );
    final compressedBytes = img.encodeJpg(compressedImage, quality: 85);
    await targetFile.writeAsBytes(compressedBytes);

    return targetPath;
  }

  // 复制文件
  Future<String> copyFile(String sourcePath, String directory) async {
    final file = File(sourcePath);
    if (!await file.exists()) throw Exception('Source file not found');

    // 生成文件名
    final bytes = await file.readAsBytes();
    final hash = md5.convert(bytes).toString();
    final ext = path.extension(sourcePath);
    final fileName = '$hash$ext';

    // 复制文件
    final dir = await _getDirectory(directory);
    final targetPath = '${dir.path}/$fileName';
    final targetFile = File(targetPath);

    // 如果文件已存在，直接返回路径
    if (await targetFile.exists()) {
      return targetPath;
    }

    await file.copy(targetPath);
    return targetPath;
  }

  // 删除文件
  Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  // 清理目录
  Future<void> clearDirectory(String directory) async {
    final dir = await _getDirectory(directory);
    await for (final entity in dir.list()) {
      await entity.delete(recursive: true);
    }
  }

  // 获取文件大小
  Future<int> getFileSize(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception('File not found');
    return file.length();
  }

  // 检查文件是否存在
  Future<bool> exists(String filePath) async {
    final file = File(filePath);
    return file.exists();
  }

  // 读取文件内容
  Future<String> readAsString(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception('File not found');
    return file.readAsString();
  }

  // 写入文件内容
  Future<void> writeAsString(String filePath, String content) async {
    final file = File(filePath);
    await file.writeAsString(content);
  }

  // 获取目录大小
  Future<int> getDirectorySize(String directory) async {
    final dir = await _getDirectory(directory);
    var size = 0;
    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) {
        size += await entity.length();
      }
    }
    return size;
  }

  // 清理过期文件
  Future<void> cleanExpiredFiles(String directory, {Duration maxAge = const Duration(days: 7)}) async {
    final dir = await _getDirectory(directory);
    final now = DateTime.now();
    await for (final entity in dir.list()) {
      if (entity is File) {
        final stat = await entity.stat();
        if (now.difference(stat.modified) > maxAge) {
          await entity.delete();
        }
      }
    }
  }
} 