import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FileService extends GetxService {
  final _storage = GetStorage();
  static const String kRecentFiles = 'recent_files';
  static const String kAutoSaveFile = 'auto_save_file';
  static const String kAutoSaveContent = 'auto_save_content';

  // 当前文件
  final Rx<File?> _currentFile = Rx<File?>(null);
  File? get currentFile => _currentFile.value;

  // 最近文件列表
  final RxList<String> _recentFiles = <String>[].obs;
  List<String> get recentFiles => _recentFiles;

  @override
  void onInit() {
    super.onInit();
    _loadRecentFiles();
    _loadAutoSave();
  }

  // 加载最近文件列表
  void _loadRecentFiles() {
    final files = _storage.read<List<String>>(kRecentFiles) ?? [];
    _recentFiles.value = files;
  }

  // 加载自动保存
  void _loadAutoSave() {
    final filePath = _storage.read<String>(kAutoSaveFile);
    if (filePath != null) {
      _currentFile.value = File(filePath);
    }
  }

  // 打开文件
  Future<String> openFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('文件不存在');
      }

      _currentFile.value = file;
      _addToRecentFiles(filePath);
      return await file.readAsString();
    } catch (e) {
      rethrow;
    }
  }

  // 选择并打开文件
  Future<String?> pickAndOpenFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['md', 'markdown'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          return await openFile(file.path!);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // 保存文件
  Future<void> saveFile(String content) async {
    try {
      if (_currentFile.value == null) {
        // 如果没有当前文件，则打开保存对话框
        final filePath = await _showSaveDialog();
        if (filePath != null) {
          _currentFile.value = File(filePath);
        } else {
          return;
        }
      }

      await _currentFile.value!.writeAsString(content);
      _addToRecentFiles(_currentFile.value!.path);
      
      // 清除自动保存
      await _storage.remove(kAutoSaveContent);
    } catch (e) {
      rethrow;
    }
  }

  // 自动保存
  Future<void> autoSave(String content) async {
    if (_currentFile.value != null) {
      await _storage.write(kAutoSaveFile, _currentFile.value!.path);
    }
    await _storage.write(kAutoSaveContent, content);
  }

  // 获取自动保存的内容
  String? getAutoSavedContent() {
    return _storage.read<String>(kAutoSaveContent);
  }

  // 显示保存对话框
  Future<String?> _showSaveDialog() async {
    try {
      return await FilePicker.platform.saveFile(
        dialogTitle: '保存文件',
        fileName: 'untitled.md',
        type: FileType.custom,
        allowedExtensions: ['md', 'markdown'],
      );
    } catch (e) {
      rethrow;
    }
  }

  // 添加到最近文件列表
  void _addToRecentFiles(String filePath) {
    _recentFiles.remove(filePath);
    _recentFiles.insert(0, filePath);
    if (_recentFiles.length > 10) {
      _recentFiles.removeLast();
    }
    // 持久化最近文件列表
    _storage.write(kRecentFiles, _recentFiles);
  }

  // 创建新文件
  Future<void> createNew() async {
    _currentFile.value = null;
  }
} 