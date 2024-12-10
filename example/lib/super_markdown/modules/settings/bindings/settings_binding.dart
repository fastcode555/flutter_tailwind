import 'package:example/super_markdown/modules/settings/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(SettingsController.new);
  }
}
