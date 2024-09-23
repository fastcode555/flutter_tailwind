import 'package:example/res/app_image_config.dart';
import 'package:example/res/r.dart';
import 'package:example/res/tailwind_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

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
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            R.icAirPlay.svg.red.pt50.pb70.mk,
            'https://gd-hbimg.huaban.com/'.image.border5.borderBrown.s100.mk,
            'https://gd-hbimg.huaban.com/'.image.border5.borderBrown.circle.s100.mk,
            'https://gd-hbimg.huaban.com/a24927d45ca73a5a6147bf3ffd4208a07cef4a15f6e87-72pNrh'
                .image
                .border5
                .borderBrown
                .rounded16
                .s100
                .mk,
            Image.network(
              'https://gd-hbimg.huaban.com/a24927d45ca73a5a6147bf3ffd4208a07cef4a15f6e87-72pNrh',
            ),
            'werwe'.image.border5.borderBrown.circle.s100.mk,
          ],
        ),
      ),
    );
  }
}
