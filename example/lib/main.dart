import 'package:example/post_item.dart';
import 'package:example/res/colours.dart';
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
          title: 'Flutter TailWind',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Flutter TailWind'),
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

  final _notifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 2.r),
        child: Wrap(
          runSpacing: 2.r,
          spacing: 2.r,
          children: [
            Switch(value: false, onChanged: _onChanged),
            sizedBox.wFull.child('ShaderMask'.text.red.f30.mk),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: <Color>[Colors.blue, Colors.red, Colors.orange],
                    ).createShader(bounds);
                  },
                  child: const Text('It is LinearGradient', style: TextStyle(color: Colors.white)),
                ),
                shaderMask.blue.red.orange.child(
                  const Text('It is LinearGradient', style: TextStyle(color: Colors.white)),
                ),
                shaderMask.blue.red.orange.centerRight.centerLeft.child('It is LinearGradient'.text.white.mk),
              ],
            ),
            sizedBox.wFull.child('Check Box'.text.red.f30.mk),
            shaderMask.blue.red.child(
              checkBox.blue.justIcon.white.borderBlack.onChanged(false, (value) {}),
            ),
            shaderMask.blue.red.child(
              checkBox.circle.justIcon.white.borderBlack.onChanged(false, (value) {}),
            ),
            shaderMask.blue.red.child(
              checkBox.blue.material.white.borderBlack.onChanged(false, (value) {}),
            ),
            shaderMask.blue.red.child(
              checkBox.circle.material.white.borderBlack.onChanged(false, (value) {}),
            ),
            checkBox.blue.borderBlack.shadowMd.material.s50.onChanged(false, _onChanged),
            checkBox.blue.borderBlack.material.onChanged(false, _onChanged),
            checkBox.blue.circle.borderBlack.material.onChanged(false, _onChanged),
            checkBox.blue.borderBlack.shadowMd.s50.onChanged(false, _onChanged),
            checkBox.blue.borderBlack.shadowMd.onChanged(false, _onChanged),
            checkBox.blue.borderBlack.justIcon.shadowMd.onChanged(false, _onChanged),
            checkBox.blue.icAirPlay.s50.shadowMd.borderBlack.onChanged(true, _onChanged),
            checkBox.blue.icAirPlay.s50.rounded16.shadowMd.borderBlack.onChanged(true, _onChanged),
            checkBox.blue.icAirPlay.borderBlack.onChanged(true, _onChanged),
            checkBox.blue.icAirPlay.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.blue.icAirPlay.s50.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.blue.icShareHome.ratio50.borderBlack.onChanged(true, _onChanged),
            checkBox.blue.icShareHome.ratio50.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.orange.icAwesomePen.borderBlack.onChanged(true, _onChanged),
            checkBox.orange.icAwesomePen.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.orange.acUnit.borderBlack.onChanged(true, _onChanged),
            checkBox.orange.acUnit.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.orange.acUnit.borderBlack.s50.justIcon.onChanged(true, _onChanged),
            shaderMask.orange.green.red.topLeft.bottomRight.child(
              checkBox.white.acUnit.borderBlack.s50.justIcon.onChanged(true, _onChanged),
            ),
            checkBox.orange.icon(Icons.close).s50.borderBlack.onChanged(true, _onChanged),
            checkBox.orange.icon(Icons.close).borderBlack.onChanged(true, _onChanged),
            checkBox.orange.icon(Icons.close).borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.blue.borderBlack.onChanged(true, _onChanged),
            checkBox.red.onChanged(false, _onChanged),
            checkBox.red.borderOrange.onChanged(false, _onChanged),
            checkBox.red.borderOrange.onChanged(true, _onChanged),
            checkBox.red.borderOrange.justIcon.onChanged(true, _onChanged),
            checkBox.onChanged(false, _onChanged),
            checkBox.onChanged(true, _onChanged),
            checkBox.green.borderRed.enableBorder.onChanged(false, _onChanged),
            checkBox.green.borderRed.enableBorder.onChanged(true, _onChanged),
            checkBox.green.borderRed.enableBorder.justIcon.onChanged(true, _onChanged),
            checkBox.enableBorder.onChanged(false, _onChanged),
            checkBox.enableBorder.onChanged(true, _onChanged),

            checkBox.circle.blue.borderBlack.onChanged(false, _onChanged),
            checkBox.circle.blue.borderBlack.justIcon.onChanged(false, _onChanged),
            checkBox.circle.blue.icAirPlay.borderBlack.onChanged(true, _onChanged),
            checkBox.circle.blue.icAirPlay.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.circle.blue.icShareHome.ratio50.borderBlack.onChanged(true, _onChanged),
            checkBox.circle.blue.icShareHome.ratio50.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.circle.orange.icAwesomePen.borderBlack.onChanged(true, _onChanged),
            checkBox.circle.orange.icAwesomePen.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.circle.orange.acUnit.borderBlack.onChanged(true, _onChanged),
            checkBox.circle.orange.acUnit.borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.circle.orange.icon(Icons.close).borderBlack.onChanged(true, _onChanged),
            checkBox.circle.orange.icon(Icons.close).borderBlack.justIcon.onChanged(true, _onChanged),
            checkBox.circle.blue.borderBlack.onChanged(true, _onChanged),
            checkBox.circle.red.onChanged(false, _onChanged),
            checkBox.circle.red.borderOrange.onChanged(false, _onChanged),
            checkBox.circle.red.borderOrange.onChanged(true, _onChanged),
            checkBox.circle.red.borderOrange.justIcon.onChanged(true, _onChanged),
            checkBox.circle.onChanged(false, _onChanged),
            checkBox.circle.onChanged(true, _onChanged),
            checkBox.circle.green.borderRed.enableBorder.onChanged(false, _onChanged),
            checkBox.circle.green.borderRed.enableBorder.onChanged(true, _onChanged),
            checkBox.circle.green.borderRed.enableBorder.justIcon.onChanged(true, _onChanged),
            checkBox.circle.enableBorder.onChanged(false, _onChanged),
            checkBox.circle.enableBorder.onChanged(true, _onChanged),
            h2,
            sizedBox.wFull.child('Radio'.text.red.f30.mk),
            ValueListenableBuilder<int>(
              valueListenable: _notifier,
              builder: (_, groupValue, __) {
                return Wrap(
                  children: [
                    radio.onChanged(0, groupValue, _OnRadioChanged),
                    radio.onChanged(1, groupValue, _OnRadioChanged),
                    radio.onChanged(2, groupValue, _OnRadioChanged),
                    radio.circle.material.onChanged(0, groupValue, _OnRadioChanged),
                    radio.circle.material.onChanged(1, groupValue, _OnRadioChanged),
                    radio.circle.material.onChanged(2, groupValue, _OnRadioChanged),
                    radio.material.amberAccent.onChanged(0, groupValue, _OnRadioChanged),
                    radio.material.amberAccent.onChanged(1, groupValue, _OnRadioChanged),
                    radio.material.amberAccent.onChanged(2, groupValue, _OnRadioChanged),
                    radio.circle.green.material.onChanged(0, groupValue, _OnRadioChanged),
                    radio.circle.green.material.onChanged(1, groupValue, _OnRadioChanged),
                    radio.circle.green.material.onChanged(2, groupValue, _OnRadioChanged),
                    radio.enableBorder.orange.borderBlack.onChanged(0, groupValue, _OnRadioChanged),
                    radio.enableBorder.orange.borderBlack.onChanged(1, groupValue, _OnRadioChanged),
                    radio.enableBorder.orange.borderBlack.onChanged(2, groupValue, _OnRadioChanged),
                    radio.circle.onChanged(0, groupValue, _OnRadioChanged),
                    radio.circle.onChanged(1, groupValue, _OnRadioChanged),
                    radio.circle.onChanged(2, groupValue, _OnRadioChanged),
                    radio.circle.enableBorder.orange.borderBlack.onChanged(0, groupValue, _OnRadioChanged),
                    radio.circle.enableBorder.orange.borderBlack.onChanged(1, groupValue, _OnRadioChanged),
                    radio.circle.enableBorder.orange.borderBlack.onChanged(2, groupValue, _OnRadioChanged),
                    radio.circle.justIcon.onChanged(0, groupValue, _OnRadioChanged),
                    radio.circle.justIcon.onChanged(1, groupValue, _OnRadioChanged),
                    radio.circle.justIcon.onChanged(2, groupValue, _OnRadioChanged),
                    radio.circle.justIcon.red.icAwesomePen.onChanged(0, groupValue, _OnRadioChanged),
                    radio.circle.justIcon.red.icAwesomePen.onChanged(1, groupValue, _OnRadioChanged),
                    radio.circle.justIcon.red.icAwesomePen.onChanged(2, groupValue, _OnRadioChanged),
                  ],
                );
              },
            ),

            sizedBox.wFull.child('Text'.text.red.f30.mk),
            'Hello world'.text.dashed.lightGreen.f30.bold.lineThrough.mk,
            'Hello world'.text.dashed.lightGreen.f30.opacity50.bold.lineThrough.mk,
            text('Hello').styleMain.mk,
            'Hello world'.text.styleTest.mk,
            'Hello world'.text.styleAccent.mk,
            textRich.greenAccent.children([
              TextSpan(text: 'Hello ', style: ts.brown.f20.mk),
              TextSpan(text: 'World', style: ts.red.f20.mk),
              TextSpan(text: ',The world is big', style: ts.purple.f20.underline.mk),
              WidgetSpan(child: R.icDefAvatar.asset.border1.circle.s20.mk),
              const TextSpan(text: ',So Sad'),
            ]),
            sizedBox.wFull.child('Image'.text.red.f30.mk),
            Icons.connected_tv_sharp.icon.redAccent.s100.mk,
            Icons.connected_tv_sharp.icon.redAccent.opacity50.s100.mk,
            R.icAirPlay.svg.black.s100.mk,
            R.icAirPlay.svg.black.opacity50.s100.mk,
            R.icDefPlaylist.asset.s100.mk,
            R.icDefPlaylist.asset.border2.borderLightGreen.s100.mk,
            R.icDefPlaylist.asset.border2.borderLightGreen.opacity50.s100.mk,
            R.icDefPlaylist.asset.border2.borderLightGreen.rounded16.s100.mk,
            R.icDefPlaylist.asset.border5.borderLightGreen.rounded16.s100.mk,
            R.icDefPlaylist.asset.s100.circle.mk,
            R.icDefPlaylist.asset.s100.circle.border2.borderLightGreen.mk,
            _link.image.s100.mk,
            _link.image.borderPink.border5.s100.mk,
            _link.image.rounded12.s100.mk,
            _link.image.rounded12.opacity50.s100.mk,
            _link.image.borderLightGreen.border5.s100.mk,
            _link.image.borderLightGreen.border5.rounded12.s100.mk,
            _link.image.borderLightGreen.border5.rounded22.s100.mk,
            _link.image.borderLightGreen.border5.opacity50.rounded22.s100.mk,
            _link.image.circle.s100.mk,
            _link.image.border5.borderBrown.circle.s100.mk,
            _link.image.border2.borderBrown.circle.s100.mk,
            _link.image.border2.borderBrown.opacity50.circle.s100.mk,
            'https://gd-hbimg.huaban.com/'.image.border5.borderBrown.s100.mk,
            'https://gd-hbimg.huaban.com/'.image.border5.borderBrown.circle.s100.mk,
            'https://gd-hbimg.huaban.com/'.image.border5.borderBrown.rounded16.s100.mk,
            'werwe'.image.border5.borderBrown.circle.s100.mk,

            sizedBox.wFull.child('Input'.text.red.f30.mk),
            const Row(
              children: [
                Expanded(
                  child: Input(
                    prefixIcon: Icon(Icons.ac_unit, size: 20),
                    hintText: 'test',
                    lableText: '234234',
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
            const Input.outline(
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
            const Input.outline(
              lableText: 'wrong text',
              clearWidget: Icon(Icons.close, color: Colors.green),
            ),
            h6,
            const Input.outline(
              lableText: 'wrong text',
              fillColor: Colors.yellowAccent,
              unFocusColor: Colors.blue,
              suffixIcon: Icon(Icons.confirmation_num_sharp, color: Colors.red),
            ),

            Input(
              lableText: 'Please input password',
              fillColor: Colors.yellowAccent,
              unFocusColor: Colors.blue,
              suffixIcon: const Icon(Icons.confirmation_num_sharp, color: Colors.red),
              invisibleWidget: R.icEyeSlashFill.svg.s20.red.mk,
              visibleWidget: R.icEyeFill.svg.red.s20.mk,
            ),

            Input.outline(
              lableText: 'Please input password',
              fillColor: Colors.yellowAccent,
              unFocusColor: Colors.blue,
              suffixIcon: const Icon(Icons.confirmation_num_sharp, color: Colors.red),
              invisibleWidget: R.icEyeSlashFill.svg.s20.red.mk,
              visibleWidget: R.icEyeFill.svg.s20.red.mk,
            ),
            Input.outline(
              lableText: 'Please input password',
              prefixIconBuilder: (focus) => Icons.ac_unit.icon.s20.color(focus ? Colors.red : Colors.grey).mk,
              suffixIconBuilder: (focus) =>
                  Icons.confirmation_num_sharp.icon.color(focus ? Colors.red : Colors.grey).mk,
              invisibleWidgetBuilder: (focus) => R.icEyeSlashFill.svg.s20.color(focus ? Colors.red : Colors.grey).mk,
              visibleWidgetBuilder: (focus) => R.icEyeFill.svg.s20.color(focus ? Colors.red : Colors.grey).mk,
            ),

            sizedBox.wFull.child('Container'.text.red.f30.mk),
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
            container.s100.greenAccent.borderBrown.opacity50.rounded8.border5.mk,
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
            container.s100.circle.orangeAccent.borderBrown.cardShadow.opacity50.border5.mk,
            container.s100.circle.amberAccent.borderBrown.cardShadow.center.border5.child(
              const Text("I'm hero"),
            ),
            container.s100.circle.amberAccent.borderBrown.cardShadow.center.opacity50.border5.child(
              const Text("I'm hero"),
            ),
            sizedBox.wFull.child('Button'.text.red.f30.mk),
            TextButton(
              onPressed: () {
                debugPrint('print something at console');
              },
              child: const Text('Text Button'),
            ),
            'Text Button'.textButton.click(onTap: () {
              debugPrint('print something at console');
            }),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue), // 背景颜色
                foregroundColor: WidgetStateProperty.all(Colors.white), // 文本颜色
                side: WidgetStateProperty.all(const BorderSide(width: 2)),
              ),
              child: const Text('Text Button'),
            ),
            textButton('Text Button').textWhite.redAccent.borderGreen.click(),
            textButton('Text Button').textWhite.redAccent.opacity50.borderGreen.click(),
            textButton('Text Button').yellow.rounded8.borderGreen.click(),
            textButton('Text Button').yellow.rounded8.opacity50.borderGreen.click(),
            'Text Button'.textButton.yellow.icon(Icons.ac_unit).rounded8.borderGreen.click(onTap: () {}),
            'Text Button'.textButton.yellow.icon(Icons.ac_unit).end.rounded8.borderGreen.click(onTap: () {}),
            'Text Button'.textButton.yellow.icon(R.icAirPlay).end.rounded8.borderGreen.click(onTap: () {}),
            'Text Button'.textButton.yellow.icon(R.icDefAvatar).s18.end.rounded8.borderGreen.click(onTap: () {}),
            'Text Button'.textButton.yellow.icon(R.icDefPlaylist).s18.end.rounded8.borderGreen.click(onTap: () {}),
            'Text Button'.textButton.yellow.icon(_link).s18.end.rounded8.borderGreen.click(onTap: () {}),
            'Text Button'.textButton.textColor(Colours.redAccent).rounded8.borderGreen.click(onTap: () {}),
            'Text Button'.textButton.textColor(Colours.redAccent).opacity50.rounded8.borderGreen.click(onTap: () {}),
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
            'Elevated Button'.elevatedButton.icon(R.icAirPlay).s20.end.blue.borderRedColor.textWhite.click(),
            'Elevated Button'.elevatedButton.icon(R.icDefAvatar).s18.end.blue.borderRedColor.textWhite.click(),
            'Elevated Button'.elevatedButton.icon(R.icDefPlaylist).s20.end.blue.borderRedColor.textWhite.click(),
            'Elevated Button'.elevatedButton.icDefPlaylist.s20.end.blue.borderRedColor.textWhite.click(),
            'Elevated Button'.elevatedButton.icon(_link).s20.end.blue.borderRedColor.textWhite.click(),
            'Elevated Button'.elevatedButton.icon(_link).s20.end.blue.borderRedColor.opacity50.textWhite.click(),

            OutlinedButton(
              onPressed: () {},
              child: const Text('Outline Button'),
            ),
            'Outline Button'.outlinedButton.click(onTap: () {}),
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
            'Outline Button'.outlinedButton.borderRedColor.textWhite.blue.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.borderRedColor.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.icon(Icons.ac_unit).borderRedColor.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.acUnit.borderRedColor.border2.opacity50.click(onTap: () {}),
            'Outline Button'.outlinedButton.acUnit.end.borderRedColor.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.icAirPlay.s18.end.borderRedColor.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.icDefAvatar.s18.end.borderRedColor.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.icDefPlaylist.s18.end.borderRedColor.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.icon(_link).s18.end.borderRedColor.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.icon('${_link}2342').s18.end.borderRedColor.border2.click(onTap: () {}),
            'Outline Button'.outlinedButton.icon('${_link}2342').s18.end.borderRedColor.opacity50.border2.click(
                  onTap: () {},
                ),
            iconButton.icon(Icons.ac_unit).green.click(onTap: () {}),
            iconButton.icon(Icons.ac_unit).red.click(onTap: () {}),
            iconButton.icon(Icons.ac_unit).borderRed.click(onTap: () {}),
            iconButton.icon(Icons.ac_unit).borderRed.black12.click(onTap: () {}),
            iconButton.icon(R.icAirPlay).s18.borderRed.black12.click(onTap: () {}),
            iconButton.icon(R.icDefAvatar).s20.borderRed.black12.click(onTap: () {}),
            iconButton.icon(R.icDefPlaylist).s20.borderRed.black12.click(onTap: () {}),
            iconButton.icDefPlaylist.s20.borderRed.black12.click(onTap: () {}),
            iconButton.icon(_link).s20.borderRed.black12.click(onTap: () {}),
            Icons.ac_unit.icon.redAccent.iconClick(onTap: () {}),
            R.icAirPlay.svg.black.s24.iconClick(onTap: () {}),
            R.icAirPlay.svg.black.s24.opacity50.iconClick(onTap: () {}),

            sizedBox.wFull.child('ListView'.text.red.f30.mk),

            ///listview 部分
            listview.neverScroll.shrinkWrap.horizontal.h50.builder(10, _itemBuilder),
            listview.neverScroll.shrinkWrap.horizontal.h50.reverse.builder(10, _itemBuilder),
            listview.neverScroll.shrinkWrap.horizontal.divider.h50.builder(10, _itemBuilder),
            listview.neverScroll.shrinkWrap.horizontal.divider.h50.reverse.builder(10, _itemBuilder),
            listview.neverScroll.shrinkWrap.reverse.builder(3, _itemBuilder),
            listview.neverScroll.shrinkWrap.divider.builder(3, _itemBuilder),
            listview.neverScroll.shrinkWrap.separated(const Divider(color: Colors.red)).builder(3, _itemBuilder),

            ///set the step widget,every 3 step ,will show a text
            listview.neverScroll.shrinkWrap.divider.step3.builder(
              10,
              (_, index) => Text('child: $index', style: ts.f30.bold.redAccent.mk),
              stepBuilder: (_, index) => container.red.centerLeft.p8.pl16.child(
                text('banner:$index').bold.f20.white.mk,
              ),
            ),

            listview.separated16.pl16.pr16.horizontal.h365.builder(
              10,
              (_, __) => const SizedBox(width: 250, child: PostItem()),
            ),
            listview.separated(h16).p16.neverScroll.shrinkWrap.builder(2, (_, __) => const PostItem()),
            listview.separated16.pl16.pr16.neverScroll.shrinkWrap.builder(2, (_, __) => const PostItem()),
            listview.divider.pl16.pr16.pt16.neverScroll.shrinkWrap.builder(2, (_, __) => const PostItem()),
            listview.pl16.pr16.pt16.neverScroll.shrinkWrap
                .separated(Divider(color: Colors.red, height: 16.h, thickness: 16.h))
                .dataBuilder<int>(
              [1, 2, 3],
              (_, __, item) => const PostItem(),
            ),

            sizedBox.wFull.child('GridView'.text.red.f30.mk),
            gridview.neverScroll.crossAxisCount3.spacing8.p8.shrinkWrap.builder(
              5,
              (_, __) => _link.image.border2.borderRed.circle.s50.mk,
            ),
            gridview.neverScroll.crossAxisCount4.spacing8.p8.shrinkWrap.reverse.builder(
              8,
              (_, __) => _link.image.border2.rounded8.s50.mk,
            ),

            ///set the step widget,every 3 step ,will show a red container,if don't setting the stepBuilder ,even you set the step is useless
            gridview.neverScroll.childWidth50.step4.spacing8.p8.shrinkWrap.builder(
              16,
              (_, __) => _link.image.border2.rounded8.s50.mk,
              stepBuilder: (_, __) => container.rounded8.red.center.child('Ads'.text.white.mk),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    return Text('$index', style: ts.f30.bold.redAccent.mk);
  }

  void _onChanged(bool value) {
    debugPrint('current value is $value');
  }

  void _OnRadioChanged(int value) => _notifier.value = value;
}
