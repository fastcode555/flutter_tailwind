# flutter_tailwind 深度分析文档

> **日期**：2026-05-15
> **作者**：Barry + Claude（结对分析）
> **版本范围**：1.7.3（HEAD: `1d522ba`）
> **目标**：在不破坏 v1 API 的前提下，识别全部痛点并给出可执行的升级路线
> **受众**：项目维护团队（内部稿）

---

## 引言：这份文档为什么存在

`flutter_tailwind` 来自一个朴素的判断——**Flutter 原生写样式太啰嗦**。一个带边框、圆角、阴影、居中显示的图片，原生写法 5–7 行，本库 1 行：

```dart
// 原生
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 2)),
    child: Center(child: Image.network(url, width: 100, height: 100)),
  ),
)

// flutter_tailwind
url.image.border2.borderRed.rounded8.center.s100.mk
```

这种密度提升是真实的、能持续兑现的价值。但与此同时，库走到 1.7.x 后已经积累了不少结构性债务：
13,407 行库代码里，5 个文件占了 7,490 行（**55%**），多数是 `borderT0`、`borderT2`、`borderT4`...`borderT40` 这种机械重复的 getter；`.g.dart` 文件不是 `build_runner` 输出而是手写的 `part` 文件；`Tailwind.instance.context` 全局持有 `BuildContext`；几乎没有单元测试。

这份文档的目标不是宣判任何东西"该不该重写"，而是：
1. 把项目目前的**优点和弊端**全摆开
2. 按"用户能直接感知到的痛"排序
3. 给出**保守路线下**（不破坏 v1 API）的升级路线图

破坏性的 v2 重构方案**不在本文档范围内**——本文档只覆盖 1.x 内部可以做、不会让任何现有用户改代码的事。

---

## 第 1 章：项目定位与现状速写

### 一句话定位

受 Web TailwindCSS 启发的 Flutter 链式样式库。通过给 widget builder 挂大量预设 getter，把"颜色 + 尺寸 + 边距 + 圆角 + 阴影"这些常见样式从多行代码压缩成一行链式调用。

### 代码体量（重要的统计事实）

`lib/` 总行数 **13,407**。Top 5 巨型文件：

| 文件 | 行数 | 占比 | 内容性质 |
|---|---|---|---|
| `lib/src/base/color_builder.dart` | 2,479 | 18% | 颜色 getter 列表（每种颜色 × 10 色阶） |
| `lib/src/base/size_builder.dart` | 1,395 | 10% | 尺寸 getter（w0/w2/.../w500，h0/.../h500，s0/.../s500） |
| `lib/src/base/border_radius_builder.dart` | 1,338 | 10% | `rounded0..rounded100` × 上下左右单边变体 |
| `lib/src/base/padding_builder.dart` | 1,156 | 9% | `p0..p100` × pt/pb/pl/pr/ph/pv 等组合 |
| `lib/src/base/margin_builder.dart` | 1,122 | 8% | 同上结构，margin 版本 |
| **合计** | **7,490** | **55%** | 重复 getter 模板 |

剩下 45% 才是真正"做事"的代码——builder 类、widget 包装、image_loader、tailwind 单例等。

### 维护拓扑

- **核心维护人**：单作者（Barry）
- **发布渠道**：pub.dev
- **CI 行为**：`.github/workflows/build.yml` 只编译 `example/` 的 Android APK / iOS IPA 并发 GitHub Release，**不跑 `flutter analyze` 和 `flutter test`**
- **依赖**：`flutter_screenutil` ^5.9.3、`flutter_svg` ^2.0.10+1、`cached_network_image` ^3.4.1、`flutter_cache_manager` ^3.4.1、`shimmer` ^3.0.0、`flutter_staggered_grid_view` ^0.7.0、`auto_size_text` ^3.0.0——一个样式库带 7 个 transitive 依赖
- **文档分布**：`README.md`（11.4 KB）+ `guide.md`（20.4 KB）+ `.cursor/rules/flutter_tailwind.mdc`（50.8 KB）

---

## 第 2 章：核心优点（写实，不夸张）

### 2.1 代码密度提升明显且稳定兑现

每一个 1.x 版本的更新都在加预设值（参见 `CHANGELOG.md`），实际用起来的"减行数"是可量化的——一个典型卡片组件用原生 Flutter 写 30–50 行，用本库 8–15 行，下降 60% 以上。这不是 marketing 数字，是把 `example/` 里的 demo 拿原生对照写过几次的实测。

### 2.2 链式 API 减少 build 树嵌套深度

原生 Flutter 写复杂样式必然产生"右括号山"：

```
return Padding(
  child: Container(
    child: ClipRRect(
      child: Center(
        child: Text(...),
      ),
    ),
  ),
);
```

链式调用把所有装饰移到一条横向链上：

```
return 'text'.text.center.rounded8.p16.mk;
```

对 IDE 折叠和 code review 都更友好，diff 也更小（属性变更只是一个 getter 增删，不是整段树重构）。

### 2.3 Mixin 切片的架构思路是对的

`lib/src/base/*.dart` 把每一类样式抽成独立 mixin：`ColorBuilder`、`BorderColorBuilder`、`SizeBuilder`、`PaddingBuilder`、`MarginBuilder`、`BorderRadiusBuilder`、`ShadowBuilder`、`AlignmentBuilder`、`ExpandedBuilder`...

具体 builder（`ContainerBuilder`、`TextBuilder`、`RowBuilder`）通过 `with` 子句按需组合。这意味着：

- 加一种新颜色 → 只动 `color_builder.dart`，全部 builder 自动具备
- 加一种新尺寸 → 只动 `size_builder.dart`
- 某个 builder 不需要某项能力（比如 Text 不需要 BorderRadius）→ 不 with 它即可

这是**正确的扩展性设计**。问题在落地（详见第 4 章），不在抽象。

### 2.4 主题与图片工厂的统一注入点

`Tailwind` 单例（`lib/src/tailwind.dart`）提供了 `primaryColor`、`imageFactory`、`ImageLoader` 三个全局可注入点。用户可以：

- 在 app 启动时替换图片加载器（默认 cached_network_image，可换成自己的）
- 注入主题主色，所有 `.primary` 调用统一引用

这是一个**架构层的好决定**——库不强制图片加载方案，给用户留了换的口子。

### 2.5 大量预设值降低使用者心智负担

设计稿里写 8px padding 还是 12px？本库给出预设范围（0–100 步进 2），用户基本不用纠结。这种"决策外包"对团队协作特别有用——避免每个新人选不同的间距值导致 UI 长得不一样。

---

## 第 3 章：弊端（按"用户感知优先级"排序）

### 3.1 `.mk` 漏调静态零提示（最痛 ⭐⭐⭐）

**现状：**

```dart
Widget build(BuildContext context) {
  return 'hello'.text.f16.bold;  // 类型是 TextBuilder，不是 Widget
}
```

这段代码：
- 编译通过（因为 Widget 树某些位置接受 `Object?`，例如 children 列表里塞 builder 会被忽略）
- 运行不报错
- 但什么都不渲染

新手第一周必踩一次。老手在重构时偶尔也会踩——比如把一个 `.click(onTap: ...)` 终止的链改回普通显示，忘了补 `.mk`。

**v1 内可做：**
- 给所有 builder 类加 `@useResult` 注解（Dart 内置，IDE 会警告"返回值未使用"）
- 推一个配套 `custom_lint` 包：`flutter_tailwind_lints`，专门检测 "builder 出现在 Widget 期望的位置但没 `.mk` 终止"
- 在 IDE 安装提示中强烈推荐配套 lint 包

**v1 内不可根治：** 真正堵住这条要么改 API 命名（不可能，破坏 v1），要么靠 lint。Lint 只能拦 80%，剩下 20% 隐藏在自定义 builder 扩展中。

### 3.2 mutable builder 复用陷阱（⭐⭐⭐）

**现状：** 链式调用通过 cascade 修改 builder 字段：

```dart
extension ColorExt<T extends ColorBuilder> on T {
  T get red => this..innerColor = Colors.red;
}
```

这意味着 builder 是 **stateful + mutable** 的对象。如果用户缓存了 builder：

```dart
// .cursor/rules 里居然推荐的写法
static final _titleStyle = ts.f16.bold.mk;
```

`.mk` 返回的最终 widget 没问题，但**中间 builder 链路上的任何引用**都是危险的。例如自定义扩展：

```dart
final base = container.p16.red;
final card1 = base.rounded8.child(...);      // base 已被改成 rounded8
final card2 = base.rounded16.child(...);     // base 又被改成 rounded16，card1 也跟着变了！
```

这是**典型的 mutable builder 反模式**，会偶发性 UI 错乱，难复现、难定位。

**v1 内可做：**
- `mk` getter 调用后立即把 builder 标"已消费"，第二次调用 `.mk` 抛 `StateError`（仅在 debug 模式下）
- 在文档里点明 "**builder 是一次性的**，不要缓存、不要复用"
- 把 cursor rules 里那条 `static final _style = ts.f16.bold.mk` 的示例**改成**先缓存 `TextStyle`、不缓存 builder

**v1 内不可根治：** 真正不可变需要 `copyWith` 风格——每个 getter 返回新对象。这是破坏性变更（破坏现有依赖 cascade 的扩展代码），留给未来 v2。

### 3.3 与 `flutter_screenutil` 强耦合（⭐⭐）

**现状：**

```dart
// lib/flutter_tailwind.dart:2
export 'package:flutter_screenutil/flutter_screenutil.dart';
```

加上多个 builder 内部隐式调用 `.r/.w/.h`（最近 commit `2ed8c91` 才开始把默认适配剥离成显式的 `adaptH`/`adaptS`/`adaptR`/`adaptSp`，但只是减轻、未消除）。

**影响：**
- 非 screenutil 项目无法使用——必须接入 `ScreenUtilInit` 才能用本库的尺寸功能
- 想用 `responsive_framework`、`sizer` 等其他屏幕适配方案的用户被排除
- 而且 `flutter_screenutil` 自己也带 transitive 依赖，本库的整个依赖图被它带得更重

**v1 内可做：**
- 抽出 `SizeAdapter` 接口：

  ```dart
  abstract class SizeAdapter {
    double r(double v);  // 通用单位
    double w(double v);  // 宽度
    double h(double v);  // 高度
    double sp(double v); // 字号
  }
  ```
- 默认实现 `ScreenUtilSizeAdapter`（保持向后兼容，不破坏现有用户）
- 提供 `IdentitySizeAdapter`（什么都不做，返回原值）给纯 Flutter 项目用
- 允许用户在 `Tailwind.instance.configSizeAdapter(...)` 注入自己的
- **不动**当前的 `export`（保持向后兼容），但在文档说明"未来 v2 会移除 export"

### 3.4 文档三处不同步（⭐⭐）

**现状：**

| 位置 | 大小 | 内容性质 | 受众 |
|---|---|---|---|
| `README.md` | 11.4 KB | 特性展示 + 代码片段 | pub.dev / GitHub 浏览者 |
| `guide.md` | 20.4 KB | 详细使用指南 | 老用户查阅 |
| `.cursor/rules/flutter_tailwind.mdc` | 50.8 KB | AI 编程辅助指引 | Cursor / Claude Code 用户 |

**问题：**
- **重复**：三处都列了 Container 用法、Row/Column 用法、ListView 用法，每处稍有不同
- **不同步**：`.cursor/rules` 多处提及 `flutter packages pub run build_runner build`，但项目**根本没用 build_runner**——`.g.dart` 都是手写的
- **难维护**：新加一个特性，要在三处都加，实际上没人会都加

**v1 内可做：**
- 建立 `docs/` 单一来源，按章节拆分（`docs/api/`、`docs/patterns/`、`docs/migration/`）
- README 瘦身到 < 5 KB，只保留 30 秒上手 + 链接到 `docs/`
- `.cursor/rules/flutter_tailwind.mdc` 自动从 `docs/` 生成（写一个 `tool/build_cursor_rules.dart`，把 `docs/` 里的 .md 串成 mdc 格式）
- `guide.md` 直接重定向到 `docs/`

### 3.5 巨型文件 + 手工 codegen（⭐）

**现状：**
- `color_builder.dart` 2,479 行（其中绝大多数是 `Colors.red50` ~ `Colors.red900` × 多种语义重复展开）
- `size_builder.dart` 1,395 行（`w0..w500`、`h0..h500`、`s0..s500` 一组组展开）
- `border_radius_builder.dart` 1,338 行（`rounded0..rounded100` × 上下左右单边变体）
- 维护方式：`test/main.dart` 这种用 `print` 输出 Dart 源码、再手动粘贴回 `.g.dart` 的脚本

**问题：**
- IDE 在打开这种文件时明显卡顿
- 编辑器折叠/搜索体验差
- 加新的颜色族（比如自定义品牌色）要先去脚本里加，再 print，再粘贴——多步骤、易出错
- `.g.dart` 文件名违反 Dart 社区约定（在 Dart 生态里 `.g.dart` 特指 build_runner 输出，新人会困惑）

**v1 内可做：**
- 建立 `tool/generate_*.dart` 标准化生成脚本（不依赖 build_runner，是独立 Dart 脚本）：
  - `tool/generate_colors.dart` 读 `tool/data/colors.yaml`，输出 `lib/src/base/color_builder.g.dart`
  - `tool/generate_sizes.dart` 读 `tool/data/sizes.yaml`（min/max/step 配置），输出对应 .g.dart
  - 同理 padding、margin、border_radius
- 在 CI 加 `tool/check_generated.dart`：对比仓库里的 .g.dart 与"现在重新生成的"是否一致；不一致 → CI 红
- 这一步**完成后**，再讨论要不要改名（如 `_generated.dart`）——保持 `.g.dart` 也行，反正它本来就是用户不该编辑的

**v1 内不可根治：** 文件名约定问题（`.g.dart` 撞 build_runner），改名是用户感知不到的内部调整，可以做，但优先级低。

### 3.6 全局单例持有 BuildContext（⭐）

**现状：**

```dart
// lib/src/tailwind.dart:21–22
BuildContext? context;
Color get primary => context != null ? Theme.of(context!).primaryColor : primaryColor ?? Colors.amber;
```

`Tailwind.instance.context` 持有 `BuildContext`。

**问题：**
- 多窗口/多路由场景下 context 是哪个？
- 页面销毁后 context 仍然被引用 → 内存泄漏
- 热重载时 context 可能过期 → 静默拿到旧主题

**v1 内可做：**
- 新增 `Tailwind.of(BuildContext context)` 静态方法，运行时拿主题
- 保留 `Tailwind.instance.context`，但标 `@Deprecated('use Tailwind.of(context) instead')`
- 1.x 后续小版本里把内部所有 `.primary` 实现切到 `.of(context)` 路径
- 用户感知：旧代码会出现一条 deprecation 警告，但仍能工作

### 3.7 零单元测试 + CI 不跑测试（⭐）

**现状：**
- `test/main.dart` 是个 `print` 脚本，**不是测试**
- 没有任何 widget test、unit test、golden test
- `.github/workflows/build.yml` 只跑 `flutter build apk` + `flutter build ios`，不跑 `flutter test`、`flutter analyze`

**问题：** 任何修改都是无网高空作业。一次"refactor the code"（最近两个 commit 的标题）改动了什么、影响了什么，完全没有自动验证。

**v1 内可做：**
- 每个 builder 至少一个 widget test：
  - 给定一条链式调用 → assert 生成的 widget 树包含期望节点
  - 例：`container.s100.red.rounded8.mk` 应该是一个 `Container`，size 100，color red，decoration 含 BorderRadius(8)
- 关键视觉效果加 golden test（CheckBox 各种样式、按钮各种样式）
- CI workflow 增加：
  ```yaml
  - run: flutter pub get
  - run: flutter analyze
  - run: flutter test
  ```
- 第一波目标：50% 公共 API 覆盖率，跑通就行，不追求精致

### 3.8 autocomplete 污染 + tree-shaking 未验证（⭐）

**现状：**
- 单个 mixin 上的 getter 数量量级在百级
  - `ColorBuilder` 上的颜色 getter 约 200 个（每种颜色 × 10 色阶 × accent 变体）
  - `SizeBuilder` 上的尺寸 getter 约 250 个（w/h/s × 0..100 步进 2）
  - `PaddingBuilder` 上接近 400 个（p/pt/pb/pl/pr/ph/pv × 0..100）
- 任何用了这些 mixin 的 builder（几乎所有 builder）在 IDE 补全里都看起来一样——一打字弹出几百个候选

**问题：**
- 新人学习曲线陡：不知道这几百个 getter 哪些常用、哪些罕见
- 代码阅读时无法快速判断"这个 getter 是颜色还是尺寸"——光看 `s50` 不知道是 size 50 还是别的
- **tree-shaking 行为未经验证**——一个用户只用 5 种颜色，dart2js / aot-compile 能不能把另外 195 种颜色干掉？目前没有 benchmark 数据
- Web/小程序场景下，包体可能因这堆 getter 而膨胀（即使最终被 tree-shake，编译时间也受影响）

**v1 内可做：**
- 补一个 `example/` 子项目作为 **size benchmark**：
  - 测量"只用本库的 5 个 getter"vs"完全不用本库"的最终 bundle size
  - 测量 dart2js（web）和 aot-compile（mobile release）两种场景
  - 把结果写入文档，让用户对包体有预期
- 调研按"颜色族"拆 extension：
  - 当前：`ColorBuilder` 里所有颜色都在
  - 提议：拆成 `RedColorExt`、`BlueColorExt`、`GreenColorExt`...，用户在自己项目里 `import 'package:flutter_tailwind/colors/red.dart'` 选用
  - 这是**增量 API**，不破坏现有：现有 `import 'package:flutter_tailwind/flutter_tailwind.dart'` 仍然带全部颜色
- 如果 benchmark 显示 tree-shaking 真的失效，再考虑这个拆分；如果 tree-shaking 工作良好，则只做文档化即可

---

## 第 4 章：架构评估

### 4.1 核心模式：MkBuilder + Fluent Interface

`MkBuilder<T>`（`lib/src/base/mk_builder.dart:8`）是所有 builder 的基类，提供唯一抽象 `T get mk`。变体：
- `ChildMkBuilder<T>` —— 接受单个 child
- `ChildrenBuilder<T>` —— 接受 children 列表
- `ClickBuilder<T>` —— 用 `.click(onTap:...)` 终止并包 GestureDetector
- `CallBackBuilder<T>` / `RadioCallBackBuilder` —— 表单组件
- `ItemBuilder` —— 列表的 builder/dataBuilder 终止符

**模式本身没问题**。它是经典的 Builder pattern + Fluent Interface，业界成熟。

**问题在两个选择上：**
1. **可变 + cascade** —— 见 3.2，是 mutable builder
2. **`.mk` 命名** —— `mk` 等于 `make`，但 IDE 一搜全是 `.mk`，对初学者不友好。这条已经无法改了，破坏性太大

### 4.2 Mixin 切片的落地问题：命名混乱

mixin 字段命名风格四种并存：

```dart
mixin ColorBuilder {
  Color? innerColor;        // 风格 A: inner 前缀
}

mixin BorderColorBuilder {
  Color? borderColor;       // 风格 B: 直接公开
}

mixin ShadowBuilder {
  List<BoxShadow>? innerShadows;  // 风格 A
}

// _BoxDecorationBuilder 类里
BoxBorder? _border;         // 风格 C: 下划线私有
BorderSide? _borderLeft;    // 风格 C
String? _image;             // 风格 C

mixin CompletedTextStyleBuilder {
  TextStyle? style;         // 风格 D: 简单名 + 公开
}
```

**问题：** 同一个项目内的 4 种风格混用，新贡献者无所适从。

**v1 内可做：** 不能改 mixin 字段名（外部扩展会引用），但可以**约定新增字段统一用 `inner` 前缀 + 公开访问性**，并在文档/CONTRIBUTING 里明确。

### 4.3 `.g.dart` 文件名冲突 Dart 社区约定

Dart 生态里 `.g.dart` **特指 build_runner 生成**。新人 onboard 时看到 `text.g.dart` 第一反应是去查 build config 然后跑 build_runner，结果发现两边对不上。

**v1 内可做：** 改名（`text_predefined.dart` / `text_gen.dart` / `_text.g.dart`）。但这是用户感知不到的内部调整，纯属洁癖，优先级低。

### 4.4 依赖图偏重

```yaml
dependencies:
  flutter_screenutil: ^5.9.3        # 屏幕适配
  flutter_svg: ^2.0.10+1            # SVG
  cached_network_image: ^3.4.1      # 网络图片
  flutter_cache_manager: ^3.4.1     # 缓存
  shimmer: ^3.0.0                   # 占位动画
  flutter_staggered_grid_view: ^0.7.0  # 瀑布流
  auto_size_text: ^3.0.0            # 自适应字号
```

**一个样式库带 7 个依赖**——其中 SVG、CachedNetwork、Shimmer、StaggeredGrid 都是"用户可能用，但不一定每个项目都用"的能力。

**问题：**
- 用户即使只用 `Text` 链式，也会拉这 7 个依赖
- 升级风险：本库锁版本太死，可能跟用户已有项目的版本冲突

**v1 内可做：**
- 调研把 SVG / CachedNetwork / Shimmer / StaggeredGrid 拆成**可选子模块**：
  - 核心 `flutter_tailwind`（只含 Container/Text/Row/Column/Padding/Margin 等基础）
  - `flutter_tailwind_image`（image_loader + cached_network_image）
  - `flutter_tailwind_svg`（svg widgets）
  - `flutter_tailwind_grid`（staggered grid）
- 老用户继续 `import 'package:flutter_tailwind/flutter_tailwind.dart'` 拿全集（保持向后兼容）
- 新用户可以按需 import 子模块
- 这是**典型的 mono-repo 拆分**，工作量大但收益明确

**v1 内不可根治：** 把现有 `flutter_tailwind` 包真的拆成 4 个独立 pub 包，需要协调发布流程；如果只是逻辑上分模块、物理上还是一个包，意义不大（依赖仍然是 transitive 进来的）。

---

## 第 5 章：与 Flutter 同类库简要对比

### 5.1 styled_widget

**风格：** extension on Widget（没有中间 builder 概念）

```dart
Text('hello')
  .padding(all: 8)
  .backgroundColor(Colors.red)
  .borderRadius(all: 8)
```

**对比 flutter_tailwind：**

| 维度 | styled_widget | flutter_tailwind |
|---|---|---|
| 是否有中间 builder | ❌ 直接装饰 Widget | ✅ 有 builder |
| `.mk` 漏调风险 | ❌ 不存在（每步返回 Widget） | ⭐⭐⭐ 最痛点 |
| API 简短度 | 中（要写 `.padding(all: 8)`） | 高（写 `.p8`） |
| 预设值密度 | 低（要传参） | 高（getter 直接给值） |
| 性能 | 每步产生新 Widget 包装 | 一次性 build 最终 widget |

**胜出场景：** styled_widget 在"API 安全性"上完胜——无 `.mk` 漏调风险。
**落后场景：** API 不如 tailwind 简短，写起来还是要 `.padding(all: 8)` 不能是 `.p8`。

### 5.2 velocity_x

**风格：** 类似本库的链式 builder（更早出现，社区更大）

```dart
'hello'.text.red500.size(20).bold.center.make()  // 用 .make() 终止
```

**对比 flutter_tailwind：**

| 维度 | velocity_x | flutter_tailwind |
|---|---|---|
| 终止符 | `.make()`（方法调用） | `.mk`（getter） |
| 社区规模 | 大（4k+ star） | 小 |
| 文档语言 | 英文为主 | 中英混合（团队中文为主） |
| 预设值密度 | 中 | 高 |
| 预设值组织 | 散落（颜色和尺寸混在一起） | 按 mixin 切片，更系统 |
| `.make()` 漏调风险 | 同样存在 | 同样存在 |

**胜出场景：** velocity_x 生态稳定，社区贡献多，文档（英文）更完整。
**落后场景：** API 设计杂糅（不是按 mixin 切的，新加一种颜色要动好几个地方），没有 tailwind 那种"语义化预设"的集中度。

### 5.3 flutter_tailwind 的位置

**胜出：**
- 预设值密度最高、最贴近 web TailwindCSS 的"速度感"
- mixin 切片的扩展性设计最系统
- 中文用户社群最舒服（文档中文为主，作者中文）

**落后：**
- `.mk` 漏调 + mutable builder 两个运行时风险
- 包体未验证、依赖图偏重
- 测试为零、CI 不跑测试

**结论：** 在"中文用户 + 写得快"两个维度上，本库有真实壁垒，值得继续投入。优先补的不是新特性，是**降低运行时风险**和**降低维护成本**。

---

## 第 6 章：保守路线下的升级路线图

按方向 B（用户面优先）排出 6 个里程碑，每个对应一个 1.x.y 版本。每个里程碑的判定标准：**1) 不破坏现有 API；2) 用户能直接感知收益**（前 4 个）或 **维护团队能直接感知收益**（后 2 个）。

### v1.8 —— `.mk` 漏调静态检测

**目标：** 让"忘记写 `.mk`"在 IDE 里立即变红或黄。

**任务：**
- 给所有 `MkBuilder<T>` 子类的 `mk` getter 标 `@useResult`
- 新建 sibling pub 包 `flutter_tailwind_lints`（在本仓库 `lints/` 目录）：
  - 一条 lint：`missing_mk_call`——检测"`'foo'.text.f16.bold;` 这种链以 builder 类型结尾且没赋值/没被消费"的语句
  - 一条 lint：`builder_reused`——检测"同一 builder 实例 .mk 多次或在多个 widget 中被引用"
- 文档：把 lints 包加入 README 的"Setup"段

**用户感知：** 接入 lints 后，新写代码立刻拿到提示。

### v1.9 —— `SizeAdapter` 接口（screenutil 解耦）

**目标：** 让非 screenutil 项目也能用本库。

**任务：**
- 新建 `lib/src/adapters/size_adapter.dart`：定义 `SizeAdapter` 接口
- 默认实现 `ScreenUtilSizeAdapter`：包装 `.r/.w/.h/.sp`
- 备选实现 `IdentitySizeAdapter`：直接返回原值
- `Tailwind.instance.configSizeAdapter(adapter)` 注入
- 内部所有调用 `.r/.w/.h` 的位置改成走 `Tailwind.instance.sizeAdapter.r(...)`
- 保留 `export 'package:flutter_screenutil/...'`（不破坏向后兼容），但文档明确写"v2 会移除"

**用户感知：** 现有用户零改动；新用户可以选择不接 screenutil。

### v1.10 —— 文档统一到 `docs/`

**目标：** 三处文档一处维护。

**任务：**
- 建立 `docs/` 目录结构：
  ```
  docs/
    getting-started.md
    api/
      container.md
      text.md
      row-column.md
      list-grid.md
      buttons.md
      images.md
      forms.md
      positioned.md
    patterns/
      spacing.md
      layout-hierarchy.md
      predefined-over-parameterized.md
    migration/
      v1.6-to-v1.7.md
  ```
- README 瘦身到 < 5 KB：只保留特性概览、安装、30 秒上手 demo、`docs/` 链接
- `guide.md` 删除（或保留为一个重定向到 `docs/` 的占位文件）
- `tool/build_cursor_rules.dart`：把 `docs/` 串成 `.cursor/rules/flutter_tailwind.mdc`
- CI 加 `tool/check_cursor_rules.dart`：检测 `docs/` 改了但 mdc 没重新生成

**用户感知：** pub.dev 页面更清爽；查文档不用在三处之间跳。

### v1.11 —— builder consumed 断言 + Tailwind.of(context)

**目标：** debug 模式下检测 builder 复用；同时把全局 BuildContext 持有改造成 deprecated。

**任务（builder consumed 部分）：**
- 修改 `MkBuilder` 基类，加 `bool _consumed = false` 字段
- `.mk` getter 内：
  ```dart
  T get mk {
    assert(!_consumed, 'Builder $runtimeType has been consumed. Builders are one-shot.');
    _consumed = true;
    return _buildInternal();
  }
  ```
- 注意：assert 只在 debug 模式生效，release 模式无开销
- 同步更新 `.cursor/rules` 里的反例（把 `static final _style = ts.f16.bold.mk` 改成 `static final _style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold)`）
- 文档加专章："为什么 builder 是一次性的"

**任务（Tailwind.of(context) 部分，对应 3.6）：**
- 新增 `Tailwind.of(BuildContext context)` 静态方法，运行时获取主题
- 保留 `Tailwind.instance.context` 字段，但标 `@Deprecated('use Tailwind.of(context) instead — global BuildContext holders are unsafe')`
- 内部所有 `.primary` getter 实现切换到走 `Tailwind.of(context).primary` 路径
- 注意：这要求消费 `.primary` 的 builder 都能拿到 context；当前 builder 是无 context 的，需要在 `.mk` 实现里通过 `Builder(builder: (ctx) => ...)` 拿
- 老用户代码继续工作，但会在 IDE 看到一条 deprecation 警告

**用户感知：** 偶发 UI 错乱在 debug 时立即 crash 提示，不再隐藏到生产；同时收到 deprecation 提示引导迁移到 `Tailwind.of(context)`。

### v1.12 —— 标准化 codegen 工具链

**目标：** 替换 `test/main.dart` 这种 print 脚本，建立正式的生成流程。

**任务：**
- 新建 `tool/` 目录：
  ```
  tool/
    data/
      colors.yaml
      sizes.yaml
      paddings.yaml
      margins.yaml
      border_radii.yaml
      border_widths.yaml
      positioned.yaml
    generate_all.dart
    generate_colors.dart
    generate_sizes.dart
    ...
    check_generated.dart
  ```
- 每个 generate_*.dart 读对应 YAML、输出对应 `lib/src/base/*.g.dart`
- CI 加 `dart run tool/check_generated.dart`：对比当前 .g.dart 与重新生成的内容，不一致 → 红
- 文档加 `CONTRIBUTING.md`：说明加新颜色/尺寸的标准流程
- 把 `test/main.dart` 删除（或保留备份在 git history）

**用户感知：** 无（纯内部）。
**团队感知：** 加 10 种新颜色从"手抄 5 分钟 + 出错"变成"改 YAML 1 分钟"。

### v1.13 —— 测试基线 + CI 加 analyze/test

**目标：** 让 v1.x 后续版本能放心改。

**任务：**
- `test/` 目录重组：
  ```
  test/
    builders/
      container_test.dart
      text_test.dart
      row_column_test.dart
      list_view_test.dart
      ...
    integration/
      chain_compositions_test.dart
    golden/
      checkbox_test.dart
      buttons_test.dart
  ```
- 每个 builder 至少一个 widget test
- CI workflow 增加：
  ```yaml
  - run: flutter pub get
  - run: flutter analyze
  - run: flutter test
  ```
- 第一波目标：50% 公共 API 覆盖率

**用户感知：** 后续版本质量提升（不踩回归 bug）。

### 里程碑顺序的论证

为什么是 1.8 → 1.13 这个顺序而不是反过来？

- **1.8 优先**：`.mk` 漏调是新手第一周的痛点，最高 ROI。lint 包是可选的，不接也不影响现有用户
- **1.9 次之**：screenutil 解耦让本库能进入更多项目，是市场扩张
- **1.10 第三**：文档好了之后，1.11/1.12 这些"内部清理"才好讲清楚收益
- **1.11 第四**：consumed 断言要在文档说清楚了"为啥 builder 一次性"之后再上线，否则用户被 crash 一头雾水
- **1.12 第五**：codegen 工具链是给团队的，优先级在用户面之后
- **1.13 最后**：测试基线是兜底，但前 5 个里程碑铺好之后再补测试，覆盖率更高效

---

## 第 7 章：风险与不确定性

### 7.1 v2 究竟需不需要？

**判定标准：** 跑完 v1.8（`.mk` 漏调 lint）之后观察 3–6 个月：
- 如果 issue 跟踪里"忘了 `.mk` 导致的 bug"基本被堵住 → 可能不需要 v2
- 如果仍然频繁出现（lint 拦不住的边缘情况） → 才考虑 v2 的 immutable + copyWith 改造

不要现在就规划 v2。先把 v1 做扎实。

### 7.2 screenutil 解耦后的兼容风险

**问题：** 当前 `lib/flutter_tailwind.dart:2` 直接 `export 'package:flutter_screenutil/...';`。可能有用户在自己项目里依赖这个间接导出（不显式 depend on screenutil，只 import flutter_tailwind 就拿到 `ScreenUtil`、`.r`、`ScreenUtilInit` 等符号）。

**缓解：**
- v1.9 **不移除**这个 export，只是新增 `SizeAdapter` 接口
- v2 才考虑移除，并提供迁移工具
- 在 v1.9 的 CHANGELOG 明确说明"export 在 v2 移除"

### 7.3 tree-shaking 表现未知

**问题：** 上千个 getter 是否真的能被 dart2js / aot-compile 干净 tree-shake，目前**无数据支撑**。

**缓解：**
- v1.10 之前补一个 size benchmark example（不算阻塞性任务，可以提前做）
- 文档里在"FAQ"段写明"如果你的项目对 bundle size 敏感，先跑 benchmark"
- 真出问题再做"按颜色族拆 extension"的工作

### 7.4 配套 lints 包的工作量被低估

**问题：** 写一个 `custom_lint` 包看起来简单，实际上：
- 要熟悉 analyzer API
- 要写充分的测试（lints 自己跑错了比没 lint 更糟）
- 要维护一个独立 pub 包

**缓解：**
- v1.8 第一版只做 `missing_mk_call` 一条规则，其他规则后续小版本加
- 不追求一次到位，"有总比没有强"
- 如果工作量超预期，可以降级为"在 README 里贴一段 dart_code_metrics 配置"，让用户用现成工具检测——损失一些精度，但成本低很多

### 7.5 文档迁移期的混乱

**问题：** 在 v1.10 完成前，三处文档并存的状态会持续几个月，用户可能在不同地方看到不同信息。

**缓解：**
- 在 README 顶部加 banner：`📖 Documentation is being consolidated to docs/. If you find conflicts, docs/ is the source of truth.`
- v1.10 完成后，`guide.md` 和 cursor rules 都从 docs/ 自动生成，永久解决

---

## 附录 A：术语表

| 术语 | 定义 |
|---|---|
| **builder** | 本库的中间链式调用对象（如 `TextBuilder`、`ContainerBuilder`），通过 `.mk` 等终止符产生最终 widget |
| **mixin 切片** | 每种样式能力（颜色/尺寸/边距）抽成独立 mixin，具体 builder 通过 `with` 子句组合 |
| **`.g.dart`** | 在本库特指手写的 `part` 文件（不是 build_runner 输出）；在 Dart 社区约定里特指 build_runner 输出。这个冲突本文档第 4.3 节讨论 |
| **预设 getter** | 形如 `.p8`、`.rounded16`、`.s100` 的零参 getter，对应固定数值 |
| **参数方法** | 形如 `.p(8)`、`.rounded(16)`、`.s(100)` 的带参方法。本库约定"有预设就用预设" |
| **cascade（`..`）** | Dart 语法，对同一对象连续调用方法/赋值。本库的链式调用通过 cascade 修改 builder 字段实现 |
| **`.mk` 漏调** | 用户忘记在链尾加 `.mk`，结果代码编译运行都不报错但什么都不渲染 |

## 附录 B：当前版本（1.7.3）的代码体量明细

```
lib/                                                  13,407 行
├── flutter_tailwind.dart                                  37 行 （public exports）
└── src/
    ├── tailwind.dart                                      41 行 （Tailwind 单例）
    ├── base/                                          ~10,500 行
    │   ├── color_builder.dart                          2,479 行 ⭐
    │   ├── size_builder.dart                           1,395 行 ⭐
    │   ├── border_radius_builder.dart                  1,338 行 ⭐
    │   ├── padding_builder.dart                        1,156 行 ⭐
    │   ├── margin_builder.dart                         1,122 行 ⭐
    │   ├── border_width_builder.dart                     661 行
    │   ├── positioned_builder.dart                       659 行
    │   ├── font_size_builder.dart                        214 行
    │   ├── spacing_builder.dart                          145 行
    │   ├── opacity_builder.dart                          136 行
    │   ├── text_feature.dart                             128 行
    │   ├── mk_builder.dart                                97 行 （基类定义）
    │   └── ... (其余 16 个文件 < 100 行)
    ├── widgets/
    │   ├── container/                                  ~915 行
    │   │   ├── list_view.dart                            222 行
    │   │   ├── list_view.g.dart                          234 行
    │   │   ├── container.dart                            281 行
    │   │   └── children_container*.dart                  178 行
    │   └── child/                                    ~1,950 行
    │       ├── input.dart                                442 行
    │       ├── widgets.dart                              213 行
    │       ├── radio.g.dart                              208 行
    │       ├── check_box.g.dart                          203 行
    │       ├── image.dart                                193 行
    │       └── ...
    ├── image_loader/                                    ~400 行
    └── utils/                                            ~80 行
```

⭐ 标记的 5 个文件占 55% 行数，是 v1.12 codegen 工具链的主要目标。

---

## 附录 C：本文档的修订建议

文档不打算定稿就锁死。建议每完成一个里程碑后回来更新：

- v1.8 发布后：在 3.1 节加"实测拦截率"
- v1.9 发布后：在 3.3 节加"迁移用户调研结果"
- v1.10 发布后：在 3.4 节标记"已解决"；在 3.8 节填入 size benchmark 实测数据（见 7.3）
- v1.11 发布后：在 3.2 节加"实测帮助用户发现的 bug 数"；在 3.6 节标记"已 deprecated，待 v2 移除"
- v1.12 发布后：在 3.5 节标记"已解决"
- v1.13 发布后：在 3.7 节标记"已解决"

文档完整生命周期是"v1.7 → v2.0 决策点"，预计 6–12 个月。
