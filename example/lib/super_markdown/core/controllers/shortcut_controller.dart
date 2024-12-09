import 'package:example/super_markdown/modules/editor/controllers/editor_controller.dart';
import 'package:get/get.dart';

class ShortcutController extends GetxController {
  // 处理快捷键动作
  void handleShortcut(String key) {
    switch (key) {
      case 'save':
        _handleSave();
      case 'undo':
        _handleUndo();
      case 'redo':
        _handleRedo();
      case 'bold':
        _handleBold();
      case 'italic':
        _handleItalic();
      case 'find':
        _handleFind();
      case 'replace':
        _handleReplace();
      case 'preview':
        _handlePreview();
      case 'fullscreen':
        _handleFullscreen();
    }
  }

  void _handleSave() {
    Get.find<EditorController>().saveFile();
  }

  void _handleUndo() {
    Get.find<EditorController>().undo();
  }

  void _handleRedo() {
    Get.find<EditorController>().redo();
  }

  void _handleBold() {
    Get.find<EditorController>().toggleBold();
  }

  void _handleItalic() {
    Get.find<EditorController>().toggleItalic();
  }

  void _handleFind() {
    Get.find<EditorController>().showFindDialog();
  }

  void _handleReplace() {
    Get.find<EditorController>().showReplaceDialog();
  }

  void _handlePreview() {
    Get.find<EditorController>().togglePreview();
  }

  void _handleFullscreen() {
    Get.find<EditorController>().toggleFullscreen();
  }
}
