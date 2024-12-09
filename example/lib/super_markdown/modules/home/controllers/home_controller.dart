import 'package:example/super_markdown/core/services/dialog_service.dart';
import 'package:example/super_markdown/core/services/file_service.dart';
import 'package:example/super_markdown/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FileService _fileService = Get.find();
  final DialogService _dialogService = Get.find();

  // 最近文件列表
  final RxList<String> recentFiles = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadRecentFiles();
  }

  // 加载最近文件列表
  void _loadRecentFiles() {
    recentFiles.value = _fileService.recentFiles;
  }

  // 创建新文件
  Future<void> createNewFile() async {
    await _fileService.createNew();
    Get.toNamed(Routes.EDITOR);
  }

  // 打开文件
  Future<void> openFile() async {
    final filePath = await _dialogService.pickFile();
    if (filePath != null) {
      await _fileService.openFile(filePath);
      Get.toNamed(Routes.EDITOR);
    }
  }

  // 打开文件夹
  Future<void> openFolder() async {
    final dirPath = await _dialogService.pickDirectory();
    if (dirPath != null) {
      // TODO: 实现文件夹浏览功能
    }
  }

  // 打开最近文件
  Future<void> openRecentFile(String filePath) async {
    await _fileService.openFile(filePath);
    Get.toNamed(Routes.EDITOR);
  }
}
