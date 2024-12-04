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
- 图标位置: end (默认在左边)

### 1.6 CheckBox
// 基本用法
checkBox.blue.onChanged(false, _onChanged)

// 带边框
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

// 常用属性
- 预定义样式: decorMain, decorTradition
- 透明度: opacity50
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
// 基本用法
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
gridview.crossAxisCount2.spacing16.builder(
  itemCount,
  (context, index) => widget,
)

// 瀑布流布局 (Staggered Grid)
gridview.staggered.childWidth50.spacing8.p8.shrinkWrap.builder(
  itemCount,
  (_, __) => widget,
)

// 固定列数的网格
gridview.crossAxisCount4.spacing16.builder(
  itemCount,
  (_, __) => widget,
)

// 固定子项宽度的网格
gridview.childWidth100.spacing16.builder(
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
// 支持的方向
- p16: 所有方向
- ph16: 水平方向
- pv16: 垂直方向
- pt16: 顶部
- pb16: 底部
- pl16: 左侧
- pr16: 右侧

注意：不支持 px, py, all 等写法

### 3.2 间距组件
// 水平间距
w4, w8, w12, w16

// 垂直间距
h4, h8, h12, h16

## 4. 颜色使用说明

### 4.1 基础颜色
- 基础颜色: red, blue, green, yellow 等
- 灰度颜色: grey, black, white 等
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
   - children/child 放在 click 前面
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
   container.border1.red  // 错误：直接使用颜色名
   
   // ✅ 正确
   container.border1.borderRed  // 正确：使用 border 前缀

## 7. 性能优化建议

1. 使用 const 构造器
2. 合理拆分组件
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