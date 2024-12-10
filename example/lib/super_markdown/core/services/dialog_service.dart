import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class DialogService extends GetxService {
  // 选择文件
  Future<String?> pickFile({
    List<String>? allowedExtensions = const ['md', 'markdown'],
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result != null) {
        return result.files.single.path;
      }
      return null;
    } catch (e) {
      Get.snackbar(
        '错误',
        '选择文件失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // 选择文件夹
  Future<String?> pickDirectory() async {
    try {
      final result = await FilePicker.platform.getDirectoryPath();
      return result;
    } catch (e) {
      Get.snackbar(
        '错误',
        '选择文件夹失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // 保存文件对话框
  Future<String?> saveFileDialog({
    String? initialDirectory,
    String? fileName,
  }) async {
    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: '保存文件',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['md', 'markdown'],
      );
      return result;
    } catch (e) {
      Get.snackbar(
        '错误',
        '保存文件失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }
}
