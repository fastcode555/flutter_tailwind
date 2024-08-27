import 'package:example/post_item.dart';
import 'package:example/res/app_image_config.dart';
import 'package:example/res/colours.dart';
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
            "Hello world".text.dashed.lightGreen.f30.bold.lineThrough.mk,
            "Hello world".text.styleMain.mk,
            "Hello world".text.styleTest.mk,
            "Hello world".text.styleAccent.mk,

            Icons.connected_tv_sharp.icon.redAccent.s100.mk,
            R.icAirPlay.svg.black.s100.mk,
            R.icDefPlaylist.asset.s100.mk,
            R.icDefPlaylist.asset.border2.borderLightGreen.s100.mk,
            R.icDefPlaylist.asset.border2.borderLightGreen.rounded16.s100.mk,
            R.icDefPlaylist.asset.border5.borderLightGreen.rounded16.s100.mk,
            R.icDefPlaylist.asset.s100.circle.mk,
            R.icDefPlaylist.asset.s100.circle.border2.borderLightGreen.mk,
            _link.image.s100.mk,
            _link.image.borderPink.border5.s100.mk,
            _link.image.rounded12.s100.mk,
            _link.image.borderLightGreen.border5.s100.mk,
            _link.image.borderLightGreen.border5.rounded12.s100.mk,
            _link.image.borderLightGreen.border5.rounded22.s100.mk,
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
              decoration: bd.greenAccent.borderBrown.rounded8.border5.mk,
            ),
            Container(
              width: 100.h,
              height: 100.h,
              decoration: bd.decorMain.mk,
            ),
            container.s100.greenAccent.borderBrown.rounded8.border5.mk,
            container.s100.decorMain.mk,
            container.s100.decorTradition.mk,

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
            container.s100.circle.orangeAccent.borderBrown.cardShadow.border5.mk,
            container.s100.circle.amberAccent.borderBrown.cardShadow.center.border5.child(const Text("I'm hero")),
            TextButton(
              onPressed: () {},
              child: const Text("Text Button"),
            ),
            "Text Button".textButton.click(onTap: () {}),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue), // 背景颜色
                foregroundColor: WidgetStateProperty.all(Colors.white), // 文本颜色
                side: WidgetStateProperty.all(const BorderSide(color: Colors.black, width: 2.0)),
              ),
              child: const Text("Text Button"),
            ),
            "Text Button".textButton.textWhite.redAccent.borderGreen.click(),
            "Text Button".textButton.yellow.rounded8.borderGreen.click(),
            "Text Button".textButton.yellow.icon(Icons.ac_unit).rounded8.borderGreen.click(onTap: () {}),
            "Text Button".textButton.yellow.icon(Icons.ac_unit).end.rounded8.borderGreen.click(onTap: () {}),
            "Text Button".textButton.textColor(Colours.redAccent).rounded8.borderGreen.click(onTap: () {}),
            ElevatedButton(onPressed: () {}, child: const Text('Elevated Button')),
            'Elevated Button'.elevatedButton.click(onTap: () {}),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue), // 背景颜色
                foregroundColor: WidgetStateProperty.all(Colors.white), // 文本颜色
              ),
              child: const Text('Elevated Button'),
            ),
            'Elevated Button'.elevatedButton.blue.textWhite.click(),
            'Elevated Button'.elevatedButton.icon(Icons.ac_unit).blue.borderRedColor.textWhite.click(),
            'Elevated Button'.elevatedButton.icon(Icons.ac_unit).end.blue.borderRedColor.textWhite.click(),

            OutlinedButton(
              onPressed: () {},
              child: const Text('Outline Button'),
            ),
            "Outline Button".outlinedButton.click(onTap: () {}),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue), // 背景颜色
                foregroundColor: WidgetStateProperty.all(Colors.white), // 文本颜色
                side: WidgetStateProperty.all(
                  const BorderSide(color: Colors.red, width: 2),
                ),
              ),
              child: const Text('Outline Button'),
            ),
            "Outline Button".outlinedButton.borderRedColor.textWhite.blue.border2.click(onTap: () {}),
            "Outline Button".outlinedButton.borderRedColor.border2.click(onTap: () {}),
            "Outline Button".outlinedButton.icon(Icons.ac_unit).borderRedColor.border2.click(onTap: () {}),
            "Outline Button".outlinedButton.icon(Icons.ac_unit).end.borderRedColor.border2.click(onTap: () {}),
            listview(3, _itemBuilder).neverScroll.shrinkWrap.reverse.mk,
            listview(3, _itemBuilder).neverScroll.shrinkWrap.separated(const Divider(color: Colors.red)).mk,
            gridview(5, const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), _itemBuilder)
                .neverScroll
                .shrinkWrap
                .reverse
                .mk,
            listview(10, (_, __) => const PostItem()).separated(h16).p16.neverScroll.shrinkWrap.mk,
          ],
        ),
      ),
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    return Text("$index", style: ts.f30.bold.redAccent.mk);
  }
}
