import 'package:example/super_markdown/modules/editor/bindings/editor_binding.dart';
import 'package:example/super_markdown/modules/editor/views/editor_view.dart';
import 'package:example/super_markdown/modules/feedback/controllers/feedback_controller.dart';
import 'package:example/super_markdown/modules/feedback/views/feedback_view.dart';
import 'package:example/super_markdown/modules/home/bindings/home_binding.dart';
import 'package:example/super_markdown/modules/home/views/home_view.dart';
import 'package:example/super_markdown/modules/settings/bindings/settings_binding.dart';
import 'package:example/super_markdown/modules/settings/views/settings_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.EDITOR,
      page: () => const EditorView(),
      binding: EditorBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.feedback,
      page: () => const FeedbackView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(FeedbackController.new);
      }),
    ),
  ];
}
