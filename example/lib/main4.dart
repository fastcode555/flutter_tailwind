import 'package:example/consts.dart';
import 'package:example/res/app_image_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/9/28
/// describe:
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // 设计稿的尺寸
      minTextAdapt: true, // 自动适配文字大小
      splitScreenMode: true, // 支持分屏模式
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _link = 'https://gd-hbimg.huaban.com/a24927d45ca73a5a6147bf3ffd4208a07cef4a15f6e87-72pNrh';

  @override
  void initState() {
    super.initState();
    Tailwind.instance.addImageConfig(AppImageConfig());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: p16,
        child: Column(
          children: [
            container.borderT10.white.borderRed.border1.borderB0.maxH(400).maxW(200).child(
                  text('werwer' * 100).bold.mk,
                ),
            container.borderB10.white.borderGreen.border1.borderT0.s200.mk,
            container.borderLeft(1, Colors.green).borderRight(2, Colors.amberAccent).white.s200.mk,
            base64Pic.image.s100.rounded16.borderBlack.border2.mk,
            fishes.image.circle.borderOrange.s100.border2.mk,
            _link.image.s100.mk,
            image('').s200.rounded8.mk,
            _link.image.border5.rounded8.s100.mk,
            _link.image.rounded12.s100.mk,
            _link.image.rounded12.opacity50.s100.mk,
            _link.image.borderLightGreen.border5.s100.mk,
            _link.image.borderLightGreen.border5.rounded12.s100.mk,
            _link.image.borderLightGreen.border5.rounded22.s100.mk,
            _link.image.borderLightGreen.border5.opacity50.rounded22.s100.mk,
          ],
        ),
      ),
    );
  }
}
