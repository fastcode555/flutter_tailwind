# Flutter Tailwind 开发指南

## 1. 基本概念
Flutter Tailwind 是一个类似 Tailwind CSS 的 Flutter UI 框架，使用链式调用来构建 UI。

## 2. 核心语法规则

### 2.1 链式调用顺序（重要）
1. 颜色样式放最前面（如 white、primary、grey）
2. 布局样式放中间（如 p16、mt12、expanded）
3. children/child 放在 click 前面
4. click 永远放在最后面 

```dart
// ✅ 正确示例
row.white.p16.children([]).click(onTap: () {});
// ❌ 错误示例
row.p16.white.children([]).click(onTap: () {});
row.white.click(onTap: () {}).children([]);
```

```dart
// ✅ 正确示例
text('标题').f16.grey.mk; // 单个组件样式链，需要 mk
row.white.p16.children([]); // 以 children 结尾，不需要 mk
row.white.p16.children([]).click(onTap: () {}); // 以 click 结尾，不需要 mk
// ❌ 错误示例
row.white.p16.children([]).mk;
row.white.p16.children([]).click(onTap: () {}).mk;
```

## 3. 常用组件示例

### 3.1 列表项
```dart
row.white.p16.children([
text('标题').f16.expanded.mk,
icon(Icons.chevron_right).s24.grey.mk,
]).click(onTap: () {});
```
### 3.2 带开关的设置项
```dart
row.white.p16.children([
text('设置项').f16.expanded.mk,
Obx(() => Switch(
value: controller.value,
onChanged: controller.onChange,
)),
]);
```
### 3.3 带副标题的列表项
```dart
row.white.p16.children([
column.crossStart.expanded.children([
text('标题').f16.mk,
h4,
text('副标题').f14.grey.mk,
]),
icon(Icons.chevron_right).s24.grey.mk,
]).click(onTap: () {});
```
### 3.4 图片加载
```dart
// 头像加载
avatar.isEmpty
? container.s40.circle.grey200.center.child(
icon(Icons.person).s24.grey.mk,
)
: avatar.image.circle.s40.mk;
```
### 3.5 分隔线和间距
```dart
// 分隔线
const Divider(),
// 或使用间距
h12,
```
## 4. 布局最佳实践

### 4.1 列表布局

```dart
// 使用 separated12 替代手动添加分隔线
listview.separated12.builder(
itemCount,
(context, index) => ListItem(),
);
```

### 4.2 滚动视图
```dart
SingleChildScrollView(
child: column.children([
// 内容
]),
);
```

## 5. 常见错误和解决方案

### 5.2 click 位置错误
```dart
// ❌ 错误
row.white.p16.click(onTap: () {}).children([])
// ✅ 正确
row.white.p16.children([]).click(onTap: () {})
```

## 6. 性能优化建议
1. 使用 const 构造器
2. 合理拆分组件
3. 避免不必要的重建
4. 使用 indexed 构造器处理列表

## 7. 代码审查清单
1. 检查颜色样式是否在最前面
2. 检查 click 是否在最后面
3. 检查是否有多余的 mk
4. 检查布局样式的顺序
5. 检查组件嵌套的合理性

## 8. 快速开发技巧
1. 使用 VSCode 代码片段
2. 创建常用组件模板
3. 遵循一致的代码风格
4. 合理使用组件复用

这个指南涵盖了使用 flutter_tailwind 开发时的主要注意点和最佳实践。建议在项目开始前仔细阅读，并在开发过程中经常参考，以确保代码质量和开发效率。

## 9.icon的使用
```dart
icon(Icons.person).s24.grey.mk//这样编写没有问题，但更偏向于下面这种方式
Icons.person.icon.s24.grey.mk//✅，更推荐
```

## 10.注意
- 项目图片加载直接使用image的链式条用，不再需要CacheNetWorkImage，因为内部已经封装好了CacheNetWorkImage