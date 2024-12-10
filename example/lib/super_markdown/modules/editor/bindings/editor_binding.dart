import 'package:example/super_markdown/modules/editor/controllers/editor_controller.dart';
import 'package:get/get.dart';

class EditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditorController>(EditorController.new);
  }
}
