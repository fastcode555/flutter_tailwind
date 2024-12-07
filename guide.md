# Flutter Tailwind 使用指南

[Guide Document](guide.md)
## 1. 基础组件

### 1.1 Container
// 基本用法
container.white.p16.child(widget)

// 常用属性
- 颜色: white, red, grey100 等
- 内边距: p16, ph16(水平), pv16(垂直), pt16(顶部) 等
- 圆角: rounded16, roundedT16(顶部圆角)
- 阴影: cardShadow, shadowSm
- 尺寸: s50(宽高相同), w100(宽), h100(高)
- 布局: center, expanded

### 1.1.1 组件大小设置
// 1. 预设大小（推荐使用）
- 宽度: w50, w100, w150, w200 等
- 高度: h50, h100, h150, h200 等
- 宽高相同: s50, s100, s150, s200 等
- 占满屏幕: wFull, hFull

// 屏幕尺寸相关
1. 基础属性:
   - wFull: 100% 屏幕宽度
   - hFull: 100% 屏幕高度
   - wInfinity: 宽度无限
   - hInfinity: 高度无限

2. 屏幕宽度百分比:
   - wFull5: 屏幕宽度的 5%
   - wFull10: 屏幕宽度的 10%
   - wFull20: 屏幕宽度的 20%
   - wFull30: 屏幕宽度的 30%
   ... 以此类推到 wFull90

3. 屏幕高度百分比:
   - hFull5: 屏幕高度的 5%
   - hFull10: 屏幕高度的 10%
   - hFull20: 屏幕高度的 20%
   - hFull30: 屏幕高度的 30%
   ... 以此类推到 hFull90

注意: 百分比属性按5%递增，如需其他比例请使用自定义方法

// 2. 自定义大小（当预设大小不满足需求时使用）
container.w(123).h(89).mk
container.s(167).mk  // 宽高相同

// 3. 支持的组件
- Container: container.w100.h50.mk
- Image: "url".image.s100.mk
- SizedBox: sizedBox.w200.h150.mk
- Icon: Icons.add.icon.s24.mk
- Button: 
  * textButton.s80.mk
  * elevatedButton.w120.h40.mk
  * outlinedButton.s60.mk
  * iconButton.s48.mk

注意：
1. 优先使用预设大小，代码更简洁、统一
2. 特殊尺寸才使用自定义方法
3. 所有支持大小设置的组件都遵循相同的使用方式

### 1.1.2 Container 使用限制
对于复杂的 Container 属性，建议使用 Flutter 原生写法：

// ❌ 不要使用 flutter_tailwind 风格
```dart
// 不支持复杂变换和渐变等属性
container.transform(...).gradient(...).maxWidth(...).mk
```

// ✅ 直接使用 Flutter Container
```dart
Container(
  transform: Matrix4.rotationZ(0.1),
  constraints: BoxConstraints(maxWidth: 200),
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
  ),
  child: widget,
)
```

注意：以下复杂属性请使用 Flutter 原生 Container：
1. transform: 变换矩阵
2. maxWidth/maxHeight: 最大尺寸约束
3. gradient: 渐变色
4. constraints: 尺寸约束
5. clipBehavior: 裁剪行为
6. 其他需要精细控制的复杂属性

### 1.2 Text
// 基本用法
"文本内容".text.f16.bold.grey.mk

// 常用属性
- 字体大小: f14, f16, f18 等
- 字重: bold
- 颜色: grey, white, orange 等
- 文本溢出: maxLine1, ellipsis
- 对齐: center

### 1.2.1 Text 字体大小设置
// 预设字体大小（推荐使用）
- f12, f14, f16, f18, f20, f24, f30, f32 等

// 自定义字体大小（当预设大小不满足需求时使用）
"文本".text.f(23).mk

// 字重设置
- bold: FontWeight.bold
- w100 到 w900: 对应 FontWeight.w100 到 FontWeight.w900

### 1.2.2 富文本 (Text.rich)
// 基本用法
textRich.children([
  TextSpan(text: 'Hello ', style: ts.brown.f20.mk),
  TextSpan(text: 'World', style: ts.red.f20.mk),
  TextSpan(text: ',The world is big', style: ts.purple.f20.underline.mk),
  WidgetSpan(child: R.icDefAvatar.asset.border1.circle.s20.mk),
  const TextSpan(text: ',So Sad'),
])

// 常用属性
- 颜色设置: greenAccent, blue, red 等
- 字体样式: ts.brown.f20.mk
- 装饰: underline, lineThrough
- 支持嵌入 Widget

### 1.2.3 描边文本 (StrokeText)
// 基本用法
"测试文本".strokeText.greenAccent.blue.f20.bold.lineThrough.mk

// 常用属性
- 文本颜色: blue, red 等
- 描边颜色: greenAccent
- 字体大小: f20
- 字重: bold
- 装饰: lineThrough, underline

### 1.2.4 预定义文本样式
- styleMain: 红色强调样式（redAccent.f16.bold.underline）
- styleAccent: 绿色强调样式（greenAccent.f20.bold.underline）
- styleTest: 测试样式（dashed.lightGreen.f30.bold.lineThrough）

### 1.2.5 TextStyle 快捷方式 (ts)
// ts 是 TextStyle 的快捷方式，用于快速创建文本样式
```dart
// 1. 基本用法
ts.red.f16.bold.mk  // 创建红色、16号、粗体的文本样式

// 2. 常用组合
ts.grey500.f14.mk  // 次要文本样式
ts.black.f16.bold.mk  // 标题文本样式
ts.blue.f16.underline.mk  // 链接文本样式
ts.red.f12.lineThrough.mk  // 删除线文本样式

// 3. 在富文本中使用
TextSpan(text: 'Hello', style: ts.brown.f20.mk)
```

注意：
1. ts 后必须使用 .mk 结束链式调用
2. 可以组合使用颜色、字号、字重、装饰等属性
3. 主要用于创建 TextStyle 对象

### 1.3 Image
// 基本用法
"图片URL".image.circle.s50.mk

// 网络图片
"https://example.com/image.jpg".image.rounded16.s200.mk

// 本地资源图片
"assets/images/logo.png".asset.s100.mk

// SVG图片
R.icLogo.svg.s24.mk  // 需要先在R文件中定义SVG资源
R.icLogo.svg.black.s24.mk  // 可以改变SVG颜色

// 常用属性
- 形状: 
  * circle: 圆形
  * rounded8: 8dp圆角
  * rounded16: 16dp圆角
  * roundedT16: 顶部圆角
  * roundedB16: 底部圆角
  * roundedL16: 左圆角
  * roundedR16: 右侧圆角
- 加载状态:
  * 加载中显示占位图
  * 加载失败显示错误图
  * 支持渐变加载效果
- 尺寸: s50
- 填充模式: cover
- 边框: border2

### 1.4 Icon
// 基本用法
Icons.star.icon.s24.grey.mk

// 图标点击
Icons.settings.icon.s24.iconClick(onTap: () {})

注意：iconClick 不要设置 padding

### 1.5 Button
// 1. TextButton
// 基本用法
"确定".textButton.textWhite.blue.click()

// 带图标
"确定".textButton.yellow.icon(Icons.add).rounded8.click()
"确定".textButton.yellow.icon(Icons.add).end.rounded8.click() // 图标在右边

// 自定义文字颜色
"确定".textButton.textColor(Colors.redAccent).rounded8.click()

// 2. ElevatedButton
// 基本用法
"确定".elevatedButton.blue.textWhite.click()

// 带图标
"确定".elevatedButton.icon(Icons.add).blue.textWhite.click()
"确定".elevatedButton.icon(Icons.add).end.blue.textWhite.click() // 图标在右边

// 带边框
"确定".elevatedButton.blue.borderRedColor.textWhite.click()

// 3. OutlinedButton
// 基本用法
"确定".outlinedButton.borderRedColor.click()

// 带背景色和文字颜色
"确定".outlinedButton.borderRedColor.textWhite.blue.border2.click()

// 带图标
"确定".outlinedButton.icon(Icons.add).borderRedColor.click()
"确定".outlinedButton.icon(Icons.add).end.borderRedColor.click() // 图标在右边

// 4. IconButton
// 基本用法
Icons.add.iconButton.green.click()
Icons.add.iconButton.borderRed.click()

// 带背景色
Icons.add.iconButton.borderRed.black12.click()

// 5. 图标点击
Icons.add.icon.redAccent.iconClick()
R.icLogo.svg.black.s24.iconClick()

// 常用属性
- 文字颜色: textWhite, textColor()
- 背景色: blue, red 等
- 边框: borderRedColor, border2
- 圆角: rounded8
- 透明度: opacity50
- 图标位置: end (默认左边)

### 1.6 CheckBox
// 基本用法
checkBox.blue.onChanged(false, _onChanged)

// 带框
checkBox.blue.borderBlack.onChanged(false, _onChanged)

// 圆形
checkBox.circle.blue.borderBlack.onChanged(false, _onChanged)

// 自定义图标
checkBox.blue.icAirPlay.borderBlack.onChanged(true, _onChanged)
checkBox.blue.icon(Icons.close).borderBlack.onChanged(true, _onChanged)

// 常用属性
- 颜色: blue, red 等
- 形状: circle
- 边框: borderBlack, enableBorder
- 阴影: shadowMd
- 尺寸: s50
- 图标: icAirPlay, icon()
- justIcon: 仅显示图标

### 1.7 Radio
// 基本用法
radio.onChanged(0, groupValue, _onChanged)

// Material风格
radio.material.onChanged(0, groupValue, _onChanged)

// 自定义样式
radio.circle.green.material.onChanged(0, groupValue, _onChanged)
radio.enableBorder.orange.borderBlack.onChanged(0, groupValue, _onChanged)

// 常用属性
- 颜色: blue, orange 等
- 形状: circle
- 边框: borderBlack, enableBorder
- 样式: material
- justIcon: 仅显示图标

### 1.6 Container装饰
// 基本用法
container.s100.amberAccent.borderBrown.rounded8.border5.mk

// 使用预定义样式
container.s100.decorMain.mk
container.s100.decorTradition.mk

// BoxDecoration方式
Container(
  decoration: bd.greenAccent.borderBrown.rounded8.border5.mk,
)

// 常用性
- 预定义样式: decorMain, decorTradition
- 透明��: opacity50
- 圆形: circle
- 阴影: cardShadow
- 边框: border5, borderBrown

## 2. 布局组件

### 2.1 Row
// 基本用法
row.children([
  widget1,
  w16,  // 间距
  widget2.expanded.mk,  // expanded 自动占用剩余空间
])

// 带样式的Row
row.white.ph16.pv8.h50.children([
  widget1,
  w16,  // 间距
  widget2.expanded.mk,  // expanded 自动占用剩余空间
])

// 常用属性
- 颜色: white, red, grey100 等
- 内边距: 
  * ph16: 水平内边距
  * pv8: 垂直内边距
  * pt16: 顶部内边距
  * pb16: 底部内边距
  * pl16: 左侧内边距
  * pr16: 右侧内边距
- 尺寸: 
  * h50: 固定高度
  * w100: 固定宽度
  * wFull: 占满屏幕宽度
  * hFull: 占满屏幕高度
- 对齐: center, spaceBetween

### 2.2 Column
// 基本用法
column.children([
  widget1,
  h16,  // 垂直间距
  widget2,
])

// 带样式的Column
column.grey100.ph16.pv8.w200.children([
  widget1,
  h16,
  widget2,
])

// 常用属性
- 颜色: white, red, grey100 等
- 内边距: 
  * ph16: 水平内边距
  * pv8: 垂直内边距
  * pt16: 顶部内边距
  * pb16: 底部内边距
  * pl16: 左侧内边距
  * pr16: 右侧内边距
- 尺寸: 
  * h50: 固定高度
  * w100: 固定宽度
  * wFull: 占满屏幕宽度
  * hFull: 占满屏幕高度
- 对齐: center, crossStart
- 间距: spaceEvenly

### 2.3 ListView
// 本用法
listview.separated16.builder(
  itemCount,
  (context, index) => widget,
)

// 常用属性
- 滚动: neverScroll
- 分隔: separated16, divider
- 方向: horizontal
- 内边距: ph16
- 收缩: shrinkWrap
- 反向: reverse

### 2.4 GridView
// 基本用法
gridview.crossAxisCount2.p16.builder(
  itemCount,
  (context, index) => widget,
)

// 瀑布流布局 (Staggered Grid)
gridview.staggered.childWidth50.spacing8.p8.shrinkWrap.builder(
  itemCount,
  (_, __) => widget,
)

// 固定列数的网格
gridview.crossAxisCount4.p16.builder(
  itemCount,
  (_, __) => widget,
)

// 固定子项宽度的网格
gridview.childWidth100.p16.builder(
  itemCount,
  (_, __) => widget,
)

// 常用属性
- 布局类型:
  * staggered: 瀑布流布局
  * crossAxisCount2/3/4: 固定2/3/4列
  * childWidth50/100/200: 固定子项宽度
- 间距和内边距:
  * spacing8/16: 子项间距
  * p8/16: 整体内边距
- 滚动控制:
  * neverScroll: 禁用滚动
  * shrinkWrap: 内容自适应
- 其他:
  * ratio(0.9): 宽高比
  * reverse: 反向排列
  * horizontal: 水平方向

### 2.5 Stack
// 基本用法
stack.children([
  widget1,
  widget2,
])

// 带样式的Stack
stack.red.p16.h200.children([
  widget1.positioned(left: 0, top: 0).mk,
  widget2.positioned(right: 0, bottom: 0).mk,
])

// 常用属性
- 颜色: white, red, grey100 等
- 内边距: 
  * ph16: 水平内边距
  * pv8: 垂直内边距
  * pt16: 顶部内边距
  * pb16: 底部内边距
  * pl16: 左侧内边距
  * pr16: 右侧内边距
- 尺寸: 
  * h50: 固定高度
  * w100: 固定宽度
  * wFull: 占满屏幕宽度
  * hFull: 占满屏幕高度
- 对齐: center, topLeft, bottomRight 等

## 3. 间距使用

### 3.1 Padding
// ✅ 支持的写法
- p16: 所有方向
- ph16: 水平方向
- pv16: 垂直方向
- pt16: 顶部
- pb16: 底部
- pl16: 左侧
- pr16: 右侧

// ❌ 不支持的写法
1. 不支持 px, py:
   - px16  // ❌ 错误，使用 ph16 代替
   - py16  // ❌ 错误，使用 pv16 代替

2. 不支持 all:
   - all16  // ❌ 错误，使用 p16 代替
   - all8   // ❌ 错误，使用 p8 代替

// 示例
// ❌ 错误写法
container.px16.py8.child(widget)
container.all16.child(widget)

// ✅ 正确写法
container.ph16.pv8.child(widget)
container.p16.child(widget)

### 3.1.1 Padding组件
// 基本用法
padding.p16.child(widget)
padding.ph16.pv8.child(widget)

// 支持的属性
1. 所有方向:
   - p8, p12, p16, p20, p24 等

2. 水平和垂直方向:
   - ph8, ph16, ph20 等 (水平方向)
   - pv8, pv16, pv20 等 (垂直方向)

3. 单个方向:
   - pt8, pt16 等 (顶部)
   - pb8, pb16 等 (底部)
   - pl8, pl16 等 (左侧)
   - pr8, pr16 等 (右侧)

注意：
1. padding组件不支持设置大小(width/height)
2. 仅用于设置内边距，需要设置大小请使用container或sizedBox
3. 使用 p16 代替 all16，p8 代替 all8 等

### 3.2 间距组件
// 水平间距
w4, w8, w12, w16

// 垂直间距
h4, h8, h12, h16

## 4. 颜色使用说明

### 4.1 基础颜色
- 基础颜色: red, blue, green, yellow 等
- 度颜色: grey, black, white 等
- Material 颜色: redAccent, blueAccent 等

### 4.2 颜色色阶支持
- 基础色阶: red50, red100, red200 ... red900
- 灰度色阶: grey50, grey100, grey200 ... grey900
- Material色阶: redAccent100, redAccent200, redAccent400, redAccent700

### 4.3 支持的全部颜色系列
1. 基础颜色系列:
   - red: red50 ~ red900
   - pink: pink50 ~ pink900
   - purple: purple50 ~ purple900
   - deepPurple: deepPurple50 ~ deepPurple900
   - indigo: indigo50 ~ indigo900
   - blue: blue50 ~ blue900
   - lightBlue: lightBlue50 ~ lightBlue900
   - cyan: cyan50 ~ cyan900
   - teal: teal50 ~ teal900
   - green: green50 ~ green900
   - lightGreen: lightGreen50 ~ lightGreen900
   - lime: lime50 ~ lime900
   - yellow: yellow50 ~ yellow900
   - amber: amber50 ~ amber900
   - orange: orange50 ~ orange900
   - deepOrange: deepOrange50 ~ deepOrange900
   - brown: brown50 ~ brown900
   - grey: grey50 ~ grey900
   - blueGrey: blueGrey50 ~ blueGrey900

2. Material Accent 颜色:
   - redAccent: redAccent100, redAccent200, redAccent400, redAccent700
   - pinkAccent: pinkAccent100 ~ pinkAccent700
   - purpleAccent: purpleAccent100 ~ purpleAccent700
   - deepPurpleAccent: deepPurpleAccent100 ~ deepPurpleAccent700
   - indigoAccent: indigoAccent100 ~ indigoAccent700
   - blueAccent: blueAccent100 ~ blueAccent700
   - lightBlueAccent: lightBlueAccent100 ~ lightBlueAccent700
   - cyanAccent: cyanAccent100 ~ cyanAccent700
   - tealAccent: tealAccent100 ~ tealAccent700
   - greenAccent: greenAccent100 ~ greenAccent700
   - lightGreenAccent: lightGreenAccent100 ~ lightGreenAccent700
   - limeAccent: limeAccent100 ~ limeAccent700
   - yellowAccent: yellowAccent100 ~ yellowAccent700
   - amberAccent: amberAccent100 ~ amberAccent700
   - orangeAccent: orangeAccent100 ~ orangeAccent700
   - deepOrangeAccent: deepOrangeAccent100 ~ deepOrangeAccent700

### 4.4 透明度设置
- 可以和任何颜色组合: red.opacity50, blue200.opacity30 等
- 支持 10-90 的透明度值: opacity10, opacity20 ... opacity90

## 5. 重要注意事项

1. 链式调用顺序：
   - 颜色放最前面
   - 布局样式放中间
   - children/child ���在 click 前面
   - click 永远放最后

2. mk 的使用：
   - 单个组件样式链需要 mk
   - 以 children 结尾不需要 mk
   - 以 click 结尾不需要 mk

3. 避免多余嵌套：
   // ❌ 错误
   container.ph16.child(container.white.child())
   
   // ✅ 正确
   container.ph16.white.child()

4. 图片加载：
   - 直接使用 image 链式调用
   - 内部已封装 CacheNetworkImage

5. 宽高设置：
   - 使用 w100, h100 而不是 width100, height100
   - 相同宽高直接使用 s100
   - wFull 表示 100% 屏幕宽度
   - hFull 表示 100% 屏幕高度

6. 边框设置：
   container.border1.borderRed  // 边框宽度和颜色

## 6. 常见错误

1. padding 写法错误：
   // ❌ 错误
   container.px16.py8
   
   // ✅ 正确
   container.ph16.pv8

2. 颜色透明度写法错误：
   // ❌ 错误
   container.red50
   
   // ✅ 正确
   container.red.opacity50

3. click 位置错误：
   // ❌ 错误
   container.click(onTap: () {}).children([])
   
   // ✅ 正确
   container.children([]).click(onTap: () {})

4. mk 使用错误：
   // ❌ 错误
   container.white.children([widget1, widget2]).mk
   
   // ✅ 正确
   container.white.children([widget1, widget2])

5. 边框颜色写法错误：
   // ❌ 错误
   container.border1.red  // 错���：直接使用颜色名
   
   // ✅ 正确
   container.border1.borderRed  // 正确：使用 border 前缀

## 7. 性能优化建议

1. 使用 const 构造器
2. 合理拆组件
3. 避免不必要的重建
4. 使用 ListView.builder 而不是 ListView
5. 图片加载使用 CacheNetworkImage
6. 合理使用 expanded 避免布局溢出

## 8. 开发建议

1. 保持代码风格一致
2. 遵循链式调用顺序
3. 避免过度嵌套
4. 合理使用间距组件
5. 注意组件复用
6. 保持代码整洁 

## 5.1 组件扩展功能

### 5.1.1 通用扩展
- expanded: 支持在 text, container, column, row, listview, gridview 等组件上直接使用
- opacity: 所有组件都支持设置透明度，如 opacity50

### 5.1.2 按钮图标位置
- end: 图标显示在文字右边
- justIcon: 仅显示图标

### 5.1.3 Material风格
- material: 在 CheckBox 和 Radio 组件上使用，采用 Material 设计风格

### 5.1.4 预定义样式
- styleMain: 用于 text 组件
- styleTest: 用于 text 组件
- styleAccent: 用于 text 组件 

## 9. 自定义属性扩展

### 9.1 扩展方式
在 tailwind_ext.dart 文件中添加扩展，主要支持以下几种类型：

1. 尺寸扩展 (SizeBuilder)
```dart
extension SizeExt<T extends SizeBuilder> on T {
  // 添加自定义尺寸 s121
  T get s121 => this..size = 121.r;
}
```

2. 文本特性扩展 (TextFeature)
```dart
extension TextFeatureExt<T extends TextFeature> on T {
  // 添加自定义字
  T get conther => this..fontFamily = R.conther;
}
```

3. 字体大小扩展 (FontSizeBuilder)
```dart
extension FontSizeExt<T extends FontSizeBuilder> on T {
  // 添加自定义字号 f100
  T get f100 => this..font(100.sp);
}
```

4. 图标扩展 (IconBuilder)
```dart
extension IconExt<T extends IconBuilder> on T {
  // 添加自定义图标
  T get icDefAvatar => this..icon(R.icDefAvatar);
  T get icAirPlay => this..icon(R.icAirPlay);
}
```

5. 文本样式扩展 (CompletedTextStyleBuilder)
```dart
extension TextStyleExt<T extends CompletedTextStyleBuilder> on T {
  // 添加预定义文本样式
  T get styleMain => this..style = ts.redAccent.f16.bold.underline.mk;
}
```

注意：
1. tailwind_ext.g.dart 文件仅包含颜色相关的扩展，不要手动修改
2. 所有自定义扩展都应该添加到 tailwind_ext.dart 文件中
3. 扩展时注意使用正确的基类（SizeBuilder、TextFeature等）
4. 自定义属性应该遵循项目的命名规范 

### 9.2 装饰器扩展
```dart
/// 自定义装饰器样式 (CompleteDecoration)
extension DecorationExt<T extends CompleteDecoration> on T {
  // 预定义装饰器样式
  T get decorMain => this
    ..decoration = bd.greenAccent.circle.borderBrown.customShadow.border5.mk;

  // 使用传统方式���义装饰器
  T get decorTradition => this
    ..decoration = BoxDecoration(
      color: Colors.greenAccent,
      border: Border.all(color: Colors.brown, width: 5.r),
      borderRadius: BorderRadius.circular(8.r),
      boxShadow: const [
        BoxShadow(
          color: Color(0x78000000),
          offset: Offset(0, 4),
          blurRadius: 4,
        ),
      ],
    );
}
```

### 9.3 阴影扩展
```dart
/// 自定义阴影样式 (ShadowBuilder)
extension ShadowExt<T extends ShadowBuilder> on T {
  T get customShadow => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x78000000),
        offset: Offset(0, 4),
        blurRadius: 4,
      )
    ];
}
```

注意：
1. 装饰器扩展可以组合使用多个属性，如 circle、border、shadow 等
2. 阴影扩展支持自定义颜色、偏移和模糊程度
3. 可以使用 Flutter 原生写法或 Tailwind 链式写法
4. 所有尺寸相关的值都需要使用 .r 进行屏幕适配

### 1.3.1 BoxDecoration 快捷方式 (bd)
// bd 是 BoxDecoration 的快捷方式，用于快速创建装饰样式
```dart
// 1. 基本用法
bd.red.rounded8.mk  // 红色背景，8dp圆角

// 2. 常用组合
bd.white.rounded16.cardShadow.mk  // 白色卡片样式
bd.grey100.circle.mk  // 圆形灰色背景
bd.transparent.border1.borderGrey.mk  // ��明背景带边框
bd.greenAccent.borderBrown.rounded8.border5.mk  // 复杂装饰样式

// 3. 在容器中使用
Container(
  decoration: bd.white.rounded16.cardShadow.mk,
)

// 4. 支持自定义阴影
bd.white.rounded16.customShadow.mk
```

注意：
1. bd 后必须使用 .mk 结束链式调用
2. 可以组合使用颜色、圆角、边框、阴影等属性
3. 主要用于创建 BoxDecoration 对象
4. 支持与自定义装饰器样式组合使用 