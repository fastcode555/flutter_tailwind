import 'package:example/res/app_image_config.dart';
import 'package:example/res/r.dart';
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
  const MyHomePage({super.key, required this.title});

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
            sizedBox.h300.wFull50.child(
              container.roundedL50.red.wFull50.mk,
            ),
            SizedBox(
              child: container.roundedL50.red.wFull50.mk,
            ),
            h6,
            Row(
              children: [
                Expanded(
                  child: Input(
                    prefixIcon: Icon(Icons.ac_unit, size: 20),
                    hintText: "test",
                    lableText: "234234",
                  ),
                ),
                w16,
                Expanded(child: Input()),
              ],
            ),
            h6,
            SizedBox(
              height: 35,
              child: Input(
                prefixIcon: R.icAwesomePen.svg.blueAccent.p12.mk,
                hintText: "I'm wrong",
                lableText: "I'm wrong",
                fillColor: Colors.red,
              ),
            ),
            h6,
            Input.outline(
              prefixIcon: Icon(Icons.ac_unit, size: 20),
              hintText: "I'm wrong",
              lableText: "I'm wrong",
            ),
            h6,
            Input.outline(
              prefixIcon: Icons.access_alarm_outlined.icon.s20.mk,
            ),
            h6,
            Input.outline(
              prefixIcon: R.icAirPlay.svg.s14.p12.red.mk,
            ),
            h6,
            Input.outline(
              lableText: "wrong text",
              clearWidget: Icon(Icons.close, color: Colors.green),
            ),
            h6,
            Input.outline(
              lableText: "wrong text",
              fillColor: Colors.yellowAccent,
              unFocusColor: Colors.blue,
              suffixIcon: Icon(Icons.confirmation_num_sharp, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
