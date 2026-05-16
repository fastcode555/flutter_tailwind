import 'package:example/config/extend_image_factory.dart';
import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Tailwind.instance.configImageFactory(ExtendImageFactory());
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Facebook Clone',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          builder: (ctx, child) {
            // v2.0: init Tailwind from inside MaterialApp so MediaQuery
            // populates Tailwind.instance.screenW/screenH (used by
            // .hFull/.wFull/.sScreen/.sFull family getters).
            Tailwind.instance.init(ctx);
            return child!;
          },
          initialRoute: AppRoutes.login,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
