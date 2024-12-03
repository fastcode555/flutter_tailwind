# flutter_tailwind

I hope to make something like tailwind that can simplify the description of style and improve efficiency.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/) which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## ScreenShot
![Alt](images/check_box_image.png)

### CheckBox
```
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
```

![Alt](images/radio_image.png)

### Radio
```dart
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
radio.circle.justIcon.red.icAwesomePen.onChanged(2, groupValue, _OnRadioChanged)
```

![Alt](images/text_image.png)

### Text
> create a text like below
```dart
"Hello world".text.dashed.lightGreen.f30.bold.lineThrough.mk
"Hello world".text.styleMain.mk
"Hello world".text.styleTest.mk
"Hello world".text.styleAccent.mk
```

![Alt](images/image_and_icon_image.png)

### IconDatas
```dart
Icons.connected_tv_sharp.icon.redAccent.s100.mk
```
### Svg
```dart
 R.icAirPlay.svg.black.s100.mk
```
### Image
> create image,asset image use flutter native widget like Image.asset,and file use Image.file,and network image use CacheNetworkImage
```dart 
R.icDefPlaylist.asset.s100.mk
R.icDefPlaylist.asset.border2.borderLightGreen.s100.mk
R.icDefPlaylist.asset.border2.borderLightGreen.rounded16.s100.mk
R.icDefPlaylist.asset.border5.borderLightGreen.rounded16.s100.mk
R.icDefPlaylist.asset.s100.circle.mk
R.icDefPlaylist.asset.s100.circle.border2.borderLightGreen.mk
```
![Alt](images/url_image.png)

### Image from URL
```dart
_link.image.s100.mk
_link.image.borderPink.border5.s100.mk
_link.image.rounded12.s100.mk
_link.image.borderLightGreen.border5.s100.mk
_link.image.borderLightGreen.border5.rounded12.s100.mk
_link.image.borderLightGreen.border5.rounded22.s100.mk
_link.image.circle.s100.mk
_link.image.border5.borderBrown.circle.s100.mk
_link.image.border2.borderBrown.circle.s100.mk
"https://gd-hbimg.huaban.com/".image.border5.borderBrown.s100.mk
"https://gd-hbimg.huaban.com/".image.border5.borderBrown.circle.s100.mk
"werwe".image.border5.borderBrown.circle.s100.mk
```
![Alt](images/container_image.png)

### Container
```dart 
container.s100.circle.orangeAccent.borderBrown.cardShadow.border5.mk
container.s100.circle.amberAccent.borderBrown.cardShadow.center.border5.child(const Text("I'm hero")) 
```

![Alt](images/button_image.png)

### Button
```dart
"Text Button".textButton.textWhite.redAccent.borderGreen.click()
"Text Button".textButton.yellow.rounded8.borderGreen.click()
"Text Button".textButton.yellow.icon(Icons.ac_unit).rounded8.borderGreen.click(onTap: () {})
"Text Button".textButton.yellow.icon(Icons.ac_unit).end.rounded8.borderGreen.click(onTap: () {})
"Text Button".textButton.textColor(Colours.redAccent).rounded8.borderGreen.click(onTap: () {})
'Elevated Button'.elevatedButton.blue.textWhite.click()
'Elevated Button'.elevatedButton.icon(Icons.ac_unit).blue.borderRedColor.textWhite.click()
'Elevated Button'.elevatedButton.icon(Icons.ac_unit).end.blue.borderRedColor.textWhite.click()
"Outline Button".outlinedButton.borderRedColor.textWhite.blue.border2.click(onTap: () {})
"Outline Button".outlinedButton.borderRedColor.border2.click(onTap: () {})
"Outline Button".outlinedButton.icon(Icons.ac_unit).borderRedColor.border2.click(onTap: () {})
"Outline Button".outlinedButton.icon(Icons.ac_unit).end.borderRedColor.border2.click(onTap: () {})
Icons.ac_unit.iconButton.green.click(onTap: () {})
Icons.ac_unit.iconButton.red.click(onTap: () {})
Icons.ac_unit.iconButton.borderRed.click(onTap: () {})
Icons.ac_unit.iconButton.borderRed.black12.click(onTap: () {})
Icons.ac_unit.icon.redAccent.iconClick(onTap: () {})
R.icAirPlay.svg.black.s24.iconClick(onTap: () {})
```

![Alt](images/image_2.png)
![Alt](images/image_3.png)
![Alt](images/image_4.png)

### ListView
```dart 
listview.neverScroll.shrinkWrap.horizontal.h50.builder(10, _itemBuilder)
listview.neverScroll.shrinkWrap.horizontal.h50.reverse.builder(10, _itemBuilder)
listview.neverScroll.shrinkWrap.horizontal.divider.h50.builder(10, _itemBuilder)
listview.neverScroll.shrinkWrap.horizontal.divider.h50.reverse.builder(10, _itemBuilder)
listview.neverScroll.shrinkWrap.reverse.builder(3, _itemBuilder)
listview.neverScroll.shrinkWrap.divider.builder(3, _itemBuilder)
listview.neverScroll.shrinkWrap.separated(const Divider(color: Colors.red)).builder(3, _itemBuilder)

///set the step widget,every 3 step ,will show a text
listview.neverScroll.shrinkWrap.divider.step3.builder(
  10,
  (_, index) => Text("child: $index", style: ts.f30.bold.redAccent.mk)
  stepBuilder: (_, index) => container.red.centerLeft.p8.pl16.child("banner:$index".text.bold.f20.white.mk)
)

listview.separated16.pl16.pr16.horizontal.h365.builder(
  10,
  (_, __) => const SizedBox(width: 250, child: PostItem())
)
listview.separated(h16).p16.neverScroll.shrinkWrap.builder(2, (_, __) => const PostItem())
listview.separated16.pl16.pr16.neverScroll.shrinkWrap.builder(2, (_, __) => const PostItem())
listview.divider.pl16.pr16.pt16.neverScroll.shrinkWrap.builder(2, (_, __) => const PostItem())
listview.pl16.pr16.pt16.neverScroll.shrinkWrap
.separated(Divider(color: Colors.red, height: 16.h, thickness: 16.h))
     .dataBuilder<int>(
   [1, 2, 3],
   (_, __, item) => const PostItem()
)
```

![Alt](images/image_5.png)

### GridView
```dart
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
stepBuilder: (_, __) => container.rounded8.red.center.child("Ads".text.white.mk),
), 
```

# Demo
> using flutter_tailwind to write the ui code

## main_wechat
![Alt](images/wechat.jpg)

## main_food
![Alt](images/main_food.jpg)

## main_movie
![Alt](images/main_movie.jpg)