import 'package:example/res/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            h2,
            Container(
              color: Colors.red,
              height: 100,
              child: "我额发链接".text.start.dashed.lightGreen.f30.bold.underline.mk,
            ),
            Icons.connected_tv_sharp.icon.redAccent.s40.mk,
            R.icAirPlay.svg.amberAccent.s50.mk,
            R.icDefPlaylist1.asset.s100.mk,
            "https://cdn.wujiebantu.com/ai/C4FE18ABFD5630F59B3739B0774FEE0A-01.jpg".network.s100.mk,
            Container(
              width: 100,
              height: 100,
              decoration: bd.amberAccent.borderBrown.r8.border5.mk,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: bd.amberAccent.circle.borderBrown.border5.mk,
            ),
          ],
        ),
      ),
    );
  }
}
