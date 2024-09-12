import 'package:example/res/app_image_config.dart';
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
                Expanded(child: InputField(prefixIcon: Icon(Icons.ac_unit, size: 20))),
                w16,
                Expanded(child: InputField()),
              ],
            ),
            // h6,
            // const InputField.outline(prefixIcon: Icon(Icons.ac_unit, size: 20)),
            // h6,
            // const InputField.outline(prefixIcon: Icon(Icons.access_alarm_outlined, size: 20)),
            // h6,
            // InputField.outline(),
          ],
        ),
      ),
    );
  }
}
