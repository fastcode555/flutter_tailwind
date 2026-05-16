import 'package:example/super_markdown/core/di/dependency_injection.dart';
import 'package:example/super_markdown/core/theme/app_theme.dart';
import 'package:example/super_markdown/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

void main() {
  // 初始化依赖注入
  DependencyInjection.init();

  runApp(const SuperMarkdownApp());
}

class SuperMarkdownApp extends StatelessWidget {
  const SuperMarkdownApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Super Markdown',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(960, 540),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (ctx, child) {
            // v2.0: init Tailwind from inside MaterialApp so MediaQuery
            // populates Tailwind.instance.screenW/screenH (used by
            // .hFull/.wFull/.sScreen/.sFull family getters).
            Tailwind.instance.init(ctx);
            return child!;
          },
          child: child,
        );
      },
    );
  }
}
