import 'package:example/res/app_image_config.dart';
import 'package:example/res/r.dart';
import 'package:example/res/tailwind_ext.dart';
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
  final String _link = "https://gd-hbimg.huaban.com/a24927d45ca73a5a6147bf3ffd4208a07cef4a15f6e87-72pNrh";

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
        child: Wrap(
          children: [
            h2,
            Container(
              color: Colors.red,
              height: 100,
              child: "我额发链接".text.start.dashed.lightGreen.f30.bold.lineThrough.mk,
            ),
            Icons.connected_tv_sharp.icon.redAccent.s100.mk,
            R.icAirPlay.svg.black.s100.mk,
            R.icDefPlaylist.asset.s100.mk,
            R.icDefPlaylist.asset.border2.borderLightGreen.s100.mk,
            R.icDefPlaylist.asset.border2.borderLightGreen.r16.s100.mk,
            R.icDefPlaylist.asset.border5.borderLightGreen.r16.s100.mk,
            R.icDefPlaylist.asset.s100.circle.mk,
            R.icDefPlaylist.asset.s100.circle.border2.borderLightGreen.mk,
            _link.image.s100.mk,
            _link.image.borderPink.border5.s100.mk,
            _link.image.r12.s100.mk,
            _link.image.borderLightGreen.border5.s100.mk,
            _link.image.borderLightGreen.border5.r12.s100.mk,
            _link.image.borderLightGreen.border5.r22.s100.mk,
            _link.image.circle.s100.mk,
            _link.image.border5.borderBrown.circle.s100.mk,
            _link.image.border2.borderBrown.circle.s100.mk,
            "https://gd-hbimg.huaban.com/".image.border5.borderBrown.s100.mk,
            "https://gd-hbimg.huaban.com/".image.border5.borderBrown.circle.s100.mk,
            "werwe".image.border5.borderBrown.circle.s100.mk,

            ///矩形
            Container(
              width: 100.h,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.brown, width: 5.r),
              ),
            ),
            Container(
              width: 100.h,
              height: 100.h,
              decoration: bd.appMain.borderBrown.r8.border5.mk,
            ),
            container.s100.greenAccent.borderBrown.r8.border5.mk,

            ///圆形
            container.s100.circle.redAccent.mk,
            Container(
              width: 100.h,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.brown, width: 5.r),
              ),
            ),
            Container(
              width: 100.h,
              height: 100.h,
              decoration: bd.purple.circle.borderBrown.border5.mk,
            ),
            container.s100.circle.orangeAccent.borderBrown.border5.mk,
            container.s100.circle.amberAccent.borderBrown.border5.child(_extractChild()).mk,
          ],
        ),
      ),
    );
  }

  Widget _extractChild() {
    return const Center(child: Text("I'm hero"));
  }
}
