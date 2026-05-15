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

### 3.1 ~~`.mk` 漏调静态零提示~~ —— **撤回，非问题**

**修订记录（2026-05-15 实测后）：** 本节原断言"`.mk` 漏调是最痛点 ⭐⭐⭐"是错的。在真实 widget 树语境里，Dart 类型系统已经把所有典型漏调场景全部堵住。下面是实测证据：

| 漏调场景 | 类型系统反应 |
|---|---|
| `Widget build() => 'hello'.text.f16.bold;` | ❌ **编译错误** `return_of_invalid_type` |
| `Center(child: 'hello'.text.f16.bold)` | ❌ **编译错误** `argument_type_not_assignable` |
| `Column(children: ['hello'.text.f16.bold])` | ❌ **编译错误** `list_element_type_not_assignable` |
| `column.children(['hello'.text.f16.bold])` | ❌ **编译错误**（同上）|
| `'hello'.text.f16.bold;`（独立语句）| ⚠️ 无警告，但现实代码里几乎不存在 |
| `var x = 'hello'.text.f16.bold;`（弃用变量）| ⚠️ 现有 `unused_local_variable` lint 已抓 |

**结论：** `.mk` 漏调在 typed Dart 中**几乎不可能静默不报错**。原断言"编译通过 + 运行时什么都不渲染"是错误的——`Widget.children` 是 `List<Widget>`，塞 `TextBuilder` 会编译错误，不会"被忽略"。仅剩的边角场景（独立语句、`dynamic` 上下文）要么无意义、要么是用户主动 opt-out 类型安全。

**原计划的 v1.8 里程碑（`@useResult` + `custom_lint` 包）整体取消。** 理由：解决的是几乎不存在的问题，投入不匹配收益。

**何时该重新考虑：** 如果团队在实际项目中遇到 `.mk` 漏调案例，记录下来。如果半年内案例数 ≥ 5 且类型系统确实抓不住，再回来评估 custom_lint 路径。

### 3.2 mutable builder 复用陷阱（⭐⭐）

> **修订记录（2026-05-15 实测后）：** 本节原列为 ⭐⭐⭐ 新头号痛点。实测后降级为 ⭐⭐。两件事被修正：
>
> 1. 原示例 B 注释"`card1 也跟着变了`"是错的——Container/BoxDecoration 在 `child(Widget)` 方法里就被立即构造、freeze，base 后续怎么改不影响已构造出的 Widget
> 2. 原批评 cursor rules 推荐 `static final _titleStyle = ts.f16.bold.mk` 是反例——撤回。`.mk` 已经调用，缓存的是 immutable TextStyle，**完全安全**
>
> 真问题仍在，但触发条件比原描述窄得多。

**现状：** 链式调用通过 cascade 修改 builder 字段：

```dart
extension ColorExt<T extends ColorBuilder> on T {
  T get red => this..innerColor = Colors.red;
}
```

builder 是 **stateful + mutable** 的对象。这本身在典型链式用法里无害——`container.p16.red.rounded8.child(text)` 这种"用完即弃"的表达式里，中间 builder 状态修改完即被 `.child(...)` 固化进 immutable Widget，链结束后 builder 实例没人引用、被 GC。

**真问题：** 当用户**主动持有 builder 跨多次终止符调用**时，cascade 写入的字段会**残留**：

```dart
// 实测可复现的真 bug
final factory = container.p16.red;
final shaped = factory.rounded8.child(text1);  // shaped 内嵌 borderRadius:8 — OK
final plain = factory.child(text2);            // 用户期望"无圆角"，
                                               // 实际拿到 borderRadius:8（残留）
```

`.rounded8` 这一步把 8 写入了 `factory.innerBorderRadius`。下一次直接 `factory.child(...)` 时，构造 Widget 读的是当前 factory 状态——8 还在。

**触发条件（窄）：**
- 用户必须**违反"用完即弃"习惯**，把 builder 赋给变量并跨多次终止符调用复用
- 现实代码里常见的是 `return container.p16.red.child(...)` 这种用完即弃的链式表达式——这种**绝对安全**
- 出现这个 bug 的典型场景是用户把 builder 当成"配置工厂"：
  ```dart
  class CardFactory {
    static final _base = container.p16.red;
    Widget shaped() => _base.rounded8.child(...);
    Widget plain()  => _base.child(...);  // 期望初始状态，实际拿到上次残留
  }
  ```

**严重性评估：** 现实代码出现频率应该不高，但**一旦出现就是难复现的 UI 错乱**（取决于函数调用顺序）。给团队带来的痛主要是"偶发但难定位"，而不是"频繁"。

**安全的写法 vs. 危险的写法：**

```dart
// ✅ 安全：缓存 .mk 返回的 immutable 值
static final _titleStyle = ts.blue.f16.bold.mk;  // TextStyle，免疫
static final _padding = p16.mk;                  // EdgeInsetsGeometry，免疫

// ✅ 安全：每次重新构造 builder
Widget build() => container.p16.red.child(...);  // 用完即弃

// ⚠️ 危险：缓存中间 builder 跨多次终止符使用
class Factory {
  static final _base = container.p16.red;  // <-- 这是 builder，不是 Widget
  Widget makeShaped() => _base.rounded8.child(...);
  Widget makePlain() => _base.child(...);  // 拿到上次残留
}
```

**v1 内可做（对应 v1.9 里程碑）：**
- 在所有终止符（`.mk` / `.child` / `.children` / `.click` / `.builder` / `.dataBuilder` / `.onChanged` 等）调用后，立即把 builder 标"已消费"
- 第二次再调任何终止符 → debug 模式抛 `StateError('Builder has been consumed, builders are one-shot')`
- 这样能精准抓到"持有 builder 跨多次终止符"的反模式，给用户明确报错指向真凶
- 配套文档专章："为什么 builder 是一次性的——别把它当配置工厂"

**v1 内不可根治：** 真正不可变需要 `copyWith` 风格——每个 getter 返回新对象。这是破坏性变更（破坏现有依赖 cascade 的扩展代码），留给未来 v2。

**实测脚本：** 本节修订后的论断已通过 `flutter test` 验证过——实测代码见 git commit `[本次提交]` 的说明，验证文件本身已删除。

### 3.3 与 `flutter_screenutil` 的耦合是依赖洁癖，**不是功能阻塞**（⭐）

> **修订记录（2026-05-15 实测后）：** 本节原列 ⭐⭐ 并断言"非 screenutil 项目无法使用——必须接入 `ScreenUtilInit` 才能用本库的尺寸功能"——**实测后撤回**。降级为 ⭐。

**实测结果：** 在不 wrap `ScreenUtilInit` 的 widget tree 里直接使用本库：

```
container.s100.red.mk WITHOUT ScreenUtilInit:
  width = 100.0 ✓
"hello".text.f16.bold.mk WITHOUT ScreenUtilInit:
  fontSize = 16.0 ✓
container.p16.s100.red.mk WITHOUT ScreenUtilInit:
  padding = EdgeInsets.all(16.0) ✓
```

`flutter_screenutil` 的 `.r/.w/.h/.sp` 在没调 `ScreenUtilInit` 时**直接返回原值**（这是 screenutil 自己的设计）。所以本库的尺寸功能**在纯 Flutter 项目里照样能用**，只是不做屏幕缩放。

**那真问题在哪里？**

```dart
// lib/flutter_tailwind.dart:2
export 'package:flutter_screenutil/flutter_screenutil.dart';
```

加上 `pubspec.yaml` 把 `flutter_screenutil` 列为依赖——意味着用户即使不调 ScreenUtilInit，也会**装上 `flutter_screenutil` 这个 transitive 依赖**。这是**包大小 + 依赖图洁癖**问题，不是"功能阻塞"。

**严重性：** 现实 Flutter 项目里 screenutil 几乎是事实标准，绝大多数项目本来就装它。所以"被强制装一个依赖"对 95% 用户没痛感。

**v1 内可做（如果做的话——优先级很低）：**
- 抽 `SizeAdapter` 接口、提供 `IdentitySizeAdapter` 给纯 Flutter 项目用——**仅为依赖洁癖**
- 这条已经从 v1.8 里程碑降级到 backlog（见第 6 章）

### 3.4 文档三处不同步（**新头号痛点** ⭐⭐⭐）

> **修订记录（2026-05-15 实测后）：** 本节原列 ⭐⭐。实测发现问题比描述还要严重——升为 ⭐⭐⭐ 新头号痛点。

**现状：**

| 位置 | 大小 | 内容性质 | 受众 |
|---|---|---|---|
| `README.md` | 11.4 KB | 特性展示 + 代码片段 | pub.dev / GitHub 浏览者 |
| `guide.md` | 20.4 KB | 详细使用指南 | 老用户查阅 |
| `.cursor/rules/flutter_tailwind.mdc` | 50.8 KB | AI 编程辅助指引 | Cursor / Claude Code 用户 |

**实测发现的具体问题（不仅仅"不同步"）：**

| 问题 | 实测证据 |
|---|---|
| **cursor rules 教用户跑不存在的 `build_runner`** | line 688 + line 1330 提到 `flutter packages pub run build_runner build`——本库根本没用 build_runner |
| **cursor rules 教错初始化位置（让 `.primary` 拿到错误主题色）** | line 1262 教用户在 `ScreenUtilInit.builder` 里调 `Tailwind.instance.init(ctx, ...)`，但那个 ctx 在 MaterialApp **之上**，Theme.of 拿到 fallback 主题（深紫色，不是用户配置的）。详见 3.5 节实测 |
| **新 API 三处文档都没有** | `spacing16` 在 cursor rules 提了 28 次、README/guide.md **完全没提**；`adaptH`/`adaptS`/`adaptR`/`adaptSp`（commit `2ed8c91` 引入）三处文档**全部 0 提及**——用户无处可学 |

**严重性升级原因：**
- "教错初始化位置"是用户**主题色全废**的直接 bug，不是抽象的"不同步"
- "新 API 没文档"意味着用户**根本不知道新 API 存在**——库的实际能力打折
- "教 build_runner"会让认真的新人花时间去配 build_runner 然后困惑

**v1 内可做（v1.8 新头号里程碑）：**
- **立即修 cursor rules 的两处具体错误**：
  - 删除 line 688、1330 的 `build_runner` 引用
  - 重写 line 1262 的初始化示例（init 必须在 MaterialApp 内部）
- 建立 `docs/` 单一来源，按章节拆分（`docs/api/`、`docs/patterns/`、`docs/migration/`）
- README 瘦身到 < 5 KB，只保留 30 秒上手 + 链接到 `docs/`
- 把 `adaptH`/`adaptS`/`adaptR`/`adaptSp` 写进 `docs/patterns/screen-adaptation.md`
- `.cursor/rules/flutter_tailwind.mdc` 后续从 `docs/` 半自动生成（脚本化但不上 CI gate）
- `guide.md` 直接重定向到 `docs/`

### 3.5 全局单例持有 BuildContext（⭐⭐）

> **修订记录（2026-05-15 实测后）：** 本节原列 ⭐，断言里有"内存泄漏"和"多窗口问题"。实测后：
> - **撤回**"内存泄漏"——没证据，是凭印象的推断
> - **撤回**"多窗口/多路由"——没测过，也是推断
> - **确认**"deactivated context 访问 .primary 会抛异常"——实测会抛 `Looking up a deactivated widget's ancestor is unsafe`
> - **新发现**：cursor rules 教用户在 `ScreenUtilInit.builder` 里调 `init(ctx, ...)`，但那个 ctx 在 MaterialApp **之上**，拿到的是 `ThemeData.fallback()` 的深紫色而不是用户配置的主题——**这才是 .primary 失灵的真原因**
> - 升级为 ⭐⭐——因为如果用户照 cursor rules 写，他的 `.primary` / `.textPrimary` / `.borderPrimary` 全是错色

**现状：**

```dart
// lib/src/tailwind.dart:21–22
BuildContext? context;
Color get primary => context != null ? Theme.of(context!).primaryColor : primaryColor ?? Colors.amber;
```

`Tailwind.instance.context` 是个公开字段。但 example/ 里**没有任何代码调用 `init(context, ...)`**——所以 `.primary` 在所有 demo 里都走 `Colors.amber` fallback。

**实测确认的真问题：**

| 场景 | 实测结果 |
|---|---|
| 不调 `init()`（example 默认状态）| `.primary` = `Colors.amber`（fallback，符合设计）|
| 按 cursor rules 在 `ScreenUtilInit.builder` 里 init | **`.primary` 拿到 `Color(0.40, 0.31, 0.64)` 深紫色**——既不是 MaterialApp 的主题、也不是 init 传入的 fallback。`Theme.of(ctx)` 在 MaterialApp 之上找不到 Theme 祖先，fallback 到 `ThemeData.fallback().primaryColor` |
| 在 MaterialApp 内部 Builder 里 init | `.primary` 正确返回 MaterialApp 的 `primaryColor` |
| widget tree 重建后再访问 `.primary` | **抛异常**：`Looking up a deactivated widget's ancestor is unsafe` |

**严重性：** 最痛的是"教错初始化位置"——这不是抽象的"全局状态不好"，而是**照文档写代码主题色就全废**。

**v1 内可做（分两层）：**

**层 1 — 立即修（属于 v1.8 文档统一里程碑）：**
- 修 `.cursor/rules/flutter_tailwind.mdc:1262` 的初始化示例，从 `ScreenUtilInit.builder` 改成 `MaterialApp.home: Builder(builder: (ctx) { Tailwind.instance.init(ctx); ... })`
- 在 `.primary` getter 加 try-catch，`Theme.of` 抛异常时 fallback 到 `primaryColor ?? Colors.amber`，避免页面销毁后崩溃

**层 2 — 根治（属于 v1.9 里程碑——consumed assert + Tailwind.of(context)）：**
- 新增 `Tailwind.of(BuildContext context)` 静态方法，运行时拿主题
- 保留 `Tailwind.instance.context`，但标 `@Deprecated('use Tailwind.of(context) instead — global BuildContext is unsafe')`
- 1.x 后续小版本里把内部所有 `.primary` 实现切到 `Tailwind.of(context)` 路径
- 用户感知：旧代码继续工作但会看到 deprecation 警告

### 3.6 零单元测试 + CI 不跑测试（⭐）

**现状：**
- `test/` 目录历史上只有 `test/main.dart`（已随本轮清理删除——曾经是个 `print` 脚本，不是测试）
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

### 3.7 autocomplete 污染（已实证）+ tree-shaking 未验证（⭐⭐）

> **修订记录（2026-05-15 实测后）：** 本节原列 ⭐ 且 getter 数量是估算。实测后 getter 数量比原估翻了 3 倍——升级为 ⭐⭐。

**实测的 getter 数量（grep 全库 mixin 文件 `T get xxx =>` 模式）：**

| Mixin 文件 | Getter 数 | 原估 |
|---|---|---|
| `ColorBuilder` (color_builder.dart) | **810** | 200 |
| `SizeBuilder` (size_builder.dart) | 443 | 250 |
| `BorderRadiusBuilder` | 431 | — |
| `PaddingBuilder` | 357 | 400 |
| `MarginBuilder` | 350 | — |
| `PositionedBuilder` | 208 | — |
| `BorderWidthBuilder` | 199 | — |
| `FontSizeBuilder` | 54 | — |
| **全库 base/ mixin 总计** | **3,064** | 估 2,000+ |

**已实证的 autocomplete 污染：** 任何 `with ColorBuilder` 的 builder（几乎所有 builder）在 IDE 上按 `.` 触发补全时，会弹出 800+ 项颜色 getter。混上 SizeBuilder/PaddingBuilder/MarginBuilder 等其它常用 mixin 后，补全列表轻松超过 2,000 项。

**问题：**
- 新人学习曲线陡：不知道这几千个 getter 哪些常用、哪些罕见
- 代码阅读时无法快速判断"这个 getter 是颜色还是尺寸"——光看 `s50` 不知道是 size 50 还是别的
- **tree-shaking 行为未经验证**——一个用户只用 5 种颜色，dart2js / aot-compile 能不能把另外 805 种颜色干掉？目前没有 benchmark 数据。如果 tree-shaking 失效，3,000+ getter 全部进 bundle
- Web/小程序场景下，包体可能因这堆 getter 而膨胀；即使最终被 tree-shake，编译时间也受影响

**v1 内可做：**
- 补一个 `example/` 子项目作为 **size benchmark**：
  - 测量"只用本库的 5 个 getter"vs"完全不用本库"的最终 bundle size
  - 测量 dart2js（web）和 aot-compile（mobile release）两种场景
  - 把结果写入文档，让用户对包体有预期
  - **这部分仍是 tree-shaking 实测的待补工作**
- autocomplete 污染本身无法在不破坏 API 的前提下解决——预设值就是按这种密度设计的，是本库价值的一部分。但可以做：
  - 在 README 显眼处加常用 getter cheat sheet（30-50 个高频）
  - 调研按"颜色族"拆 extension 作为**可选**导入（非破坏性增量 API）：`import 'package:flutter_tailwind/colors/red.dart'`

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

### 4.3 `.g.dart` 文件名是约定俗成的手写 part 文件

Dart 生态里 `.g.dart` 通常特指 build_runner 输出。本库的 `.g.dart` 是**手写的 part 文件**，与 build_runner 无关——这是历史遗留的命名选择。

**决策：** 不改名。理由：
- 预设值已稳定，未来不会大批量追加；之前依赖 `test/main.dart` 的 print + 粘贴维护方式将被弃用（脚本本身也删除）
- 文件结构上是 `part of '<sibling>.dart';`，外部 import 的是 sibling，`.g.dart` 是纯内部文件名
- 改名是用户零感知的工作，但需要改多处 `part` 指令、CHANGELOG 也得交代，性价比不高

**v1 内可做：** 在 README 顶部加一行明示——"本库的 `.g.dart` 是手写 part 文件，不是 build_runner 输出"。新贡献者一次看到、永远不再困惑。

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
| API 简短度 | 中（要写 `.padding(all: 8)`） | 高（写 `.p8`） |
| 预设值密度 | 低（要传参） | 高（getter 直接给值） |
| 性能 | 每步产生新 Widget 包装 | 一次性 build 最终 widget |
| mutable builder 复用风险 | ❌ 不存在（每步返回新 Widget，无可变状态） | ⚠️ 存在（见 3.2 节）|

**胜出场景：** styled_widget 没有 mutable builder 复用风险（因为它的"链"就是 Widget 包装链，每步产生新 Widget）。
**落后场景：** API 不如 tailwind 简短；每步产生新 Widget 包装在性能上不如一次性 build。

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
| `.make()` / `.mk` 漏调 | 类型系统已堵住 | 类型系统已堵住（见 3.1） |

**胜出场景：** velocity_x 生态稳定，社区贡献多，文档（英文）更完整。
**落后场景：** API 设计杂糅（不是按 mixin 切的，新加一种颜色要动好几个地方），没有 tailwind 那种"语义化预设"的集中度。

### 5.3 flutter_tailwind 的位置

**胜出：**
- 预设值密度最高、最贴近 web TailwindCSS 的"速度感"
- mixin 切片的扩展性设计最系统
- 中文用户社群最舒服（文档中文为主，作者中文）

**落后：**
- mutable builder 复用风险（3.2，**当前头号真痛点**）
- 包体未验证、依赖图偏重
- 测试为零、CI 不跑测试

**结论：** 在"中文用户 + 写得快"两个维度上，本库有真实壁垒，值得继续投入。优先补的不是新特性，是**降低运行时风险**和**降低维护成本**。

---

## 第 6 章：保守路线下的升级路线图

按方向 B（用户面优先）排出 **3 个里程碑**，每个对应一个 1.x.y 版本。每个里程碑的判定标准：**1) 不破坏现有 API；2) 用户能直接感知收益**（前 2 个）或 **维护团队能直接感知收益**（最后 1 个）。

> **路线图修订记录：**
> - **2026-05-15 第 1 轮**：原 v1.8（`.mk` 漏调 lint）取消（见 3.1）；原 v1.9-v1.12 前移一档变 v1.8-v1.11
> - **2026-05-15 第 2 轮（本次）**：基于 3.3/3.4/3.5/3.7 节实测：
>   - **原 v1.8（SizeAdapter）→ 降级到 backlog**——实测证明非 screenutil 项目已经能用本库（见 3.3）。SizeAdapter 仅有依赖洁癖价值，不阻塞功能，优先级降到最低
>   - **新头号 v1.8 = 文档统一 + 修 cursor rules**——3.4 升为 ⭐⭐⭐，包含修 cursor rules 教用户跑不存在的 build_runner + 教错 init 位置（这是用户主题色失灵的根因，见 3.5）
>   - **v1.9 = consumed assert + Tailwind.of(context) + .primary try-catch**——原 v1.10 内容
>   - **v1.10 = 测试基线 + CI**——原 v1.11 内容
>   - 路线图从 4 个里程碑缩到 **3 个**，预计 3–6 个月

### v1.8 —— 文档统一到 `docs/` + 修 cursor rules 错误

**目标：** 把 cursor rules 里教错用户的几处具体 bug 立刻堵住，同时建立单一文档源。

**任务（立即必做——cursor rules 实测发现的具体错误）：**
- 删除 `.cursor/rules/flutter_tailwind.mdc` line 688、line 1330 的 `flutter packages pub run build_runner build` 引用（本库无 build_runner）
- 重写 line 1262 的初始化示例——`Tailwind.instance.init(context, ...)` 必须在 **MaterialApp 内部**调用，不能在 `ScreenUtilInit.builder` 里（那个 context 在 MaterialApp 之上，`Theme.of` 拿不到主题）。改成：
  ```dart
  return ScreenUtilInit(
    builder: (context, child) {
      return MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        builder: (ctx, child) {
          Tailwind.instance.init(ctx, Colors.blue);  // ✅ ctx 在 MaterialApp 内
          return child!;
        },
        home: ...,
      );
    },
  );
  ```
- 给 `lib/src/tailwind.dart` 的 `.primary` getter 加 try-catch，`Theme.of` 抛 `Looking up a deactivated widget's ancestor is unsafe` 时 fallback 到 `primaryColor ?? Colors.amber`（避免页面销毁后访问崩溃）

**任务（文档统一）：**
- 建立 `docs/` 目录结构：
  ```
  docs/
    getting-started.md
    api/
      container.md / text.md / row-column.md / list-grid.md / buttons.md / images.md / forms.md / positioned.md
    patterns/
      spacing.md / layout-hierarchy.md / predefined-over-parameterized.md / screen-adaptation.md
    migration/
      v1.6-to-v1.7.md
  ```
- 把现有 `spacing16`/`spacing20`/`spacing24` 等只在 cursor rules 里有的 API 补到 `docs/patterns/spacing.md`
- 把 commit `2ed8c91` 引入的 `adaptH`/`adaptS`/`adaptR`/`adaptSp`（三处文档目前都没提）写进 `docs/patterns/screen-adaptation.md`
- README 瘦身到 < 5 KB：特性概览 + 30 秒上手 + `docs/` 链接
- `guide.md` 删除（或保留为占位重定向到 `docs/`）
- `.cursor/rules/flutter_tailwind.mdc` 后续从 `docs/` 半自动生成（写个 `tool/build_cursor_rules.dart`，但**不上 CI gate**——半自动够用）

**用户感知：**
- 按 cursor rules 写代码的用户立刻拿到正确主题色（之前是深紫色 fallback）
- 新文档发布后，`docs/` 有所有 API 包括新加的（之前只在 cursor rules 里有）

### v1.9 —— builder consumed 断言 + Tailwind.of(context)

**目标：** debug 模式下检测 builder 复用；同时把全局 BuildContext 持有改造成 deprecated。

**任务（builder consumed 部分）：**
- 修改 `MkBuilder` 基类，加 `bool _consumed = false` 字段
- **所有终止符都要检查**——不只是 `.mk`。这一点跟最初设想不同：3.2 节实测发现 `ContainerBuilder.child(Widget)` 等具体终止符直接构造 Widget、不走 `.mk` 路径，所以单靠 `.mk` 上的 assert 抓不到 `factory.rounded8.child(...)` + `factory.child(...)` 这种复用模式。需要在每个终止符（`.mk` getter、`.child(Widget)` 方法、`.children(...)` 方法、`.click(...)` 方法、`.builder(...)`、`.dataBuilder(...)`、`.onChanged(...)` 等）的实现里都加 consumed 检查：
  ```dart
  // 抽出共享辅助方法
  void _markConsumed() {
    assert(!_consumed, 'Builder $runtimeType has been consumed. Builders are one-shot.');
    _consumed = true;
  }

  // 在 mk getter / child(Widget) / 等终止符的实现开头调用
  @override
  Widget get mk {
    _markConsumed();
    // ...原构造逻辑
  }

  @override
  Widget child(Widget child) {
    _markConsumed();
    // ...原构造逻辑
  }
  ```
- 工作量评估：约 30 处终止符具体实现要改（分布在 `mk_builder.dart` + `container.dart` + `text.dart` + `widgets/container/list_view.dart` + `child/buttons.dart` + `child/check_box.dart` + `child/radio.dart` + `child/wrap.dart` 等）
- 注意：assert 只在 debug 模式生效，release 模式无开销
- ~~同步更新 `.cursor/rules` 里的反例（把 `static final _style = ts.f16.bold.mk` 改成 ...）~~ **撤回**——`ts.f16.bold.mk` 缓存的是 TextStyle，安全，不是反例。但需要在 cursor rules 加一段新约定：**不要缓存中间 builder 跨多次终止符使用**（见 3.2 节的"安全的写法 vs. 危险的写法"）
- 文档加专章："为什么 builder 是一次性的——别把它当配置工厂"

**任务（Tailwind.of(context) 部分，对应 3.5）：**
- 新增 `Tailwind.of(BuildContext context)` 静态方法，运行时获取主题
- 保留 `Tailwind.instance.context` 字段，但标 `@Deprecated('use Tailwind.of(context) instead — global BuildContext holders are unsafe')`
- 内部所有 `.primary` getter 实现切换到走 `Tailwind.of(context).primary` 路径
- 注意：这要求消费 `.primary` 的 builder 都能拿到 context；当前 builder 是无 context 的，需要在 `.mk` 实现里通过 `Builder(builder: (ctx) => ...)` 拿
- 老用户代码继续工作，但会在 IDE 看到一条 deprecation 警告

**用户感知：** 偶发 UI 错乱在 debug 时立即 crash 提示，不再隐藏到生产；同时收到 deprecation 提示引导迁移到 `Tailwind.of(context)`。

### v1.10 —— 测试基线 + CI 加 analyze/test

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

为什么是 1.8 → 1.10 这个顺序？

- **1.8 优先（最便宜也最痛）**：3.4 文档不同步是新头号 ⭐⭐⭐——cursor rules 教用户跑不存在的 `build_runner`、教错初始化位置（用户主题色全废）、新 API 三处文档全没。这些都是改 markdown 就能修的事，但每多一天 cursor rules 没改，就多有用户照着写出错代码
- **1.9 次之**：consumed assert 解 3.2，Tailwind.of(context) 解 3.5 根治部分。这两件都需要文档先把"为啥 builder 一次性"和"不要在 MaterialApp 之上 init"讲清楚——所以放在 v1.8 之后
- **1.10 最后**：测试基线是兜底，前 2 个里程碑铺好之后再补测试，覆盖率更高效

**已取消的里程碑（按时间顺序）：**

**注 1：** 原 v1.8 "`.mk` 漏调 lint"，第 1 轮修订时取消。理由：实测 Dart 类型系统已自动堵住该问题（见 3.1 节修订记录）。

**注 2：** 原"标准化 codegen 工具链"里程碑，被取消。理由：项目预设值已稳定，维护生成工具的成本高于偶尔手编辑的成本。`test/main.dart` 作为废弃脚本一并删除。

**注 3：** 原 v1.8 "SizeAdapter（screenutil 解耦）"，第 2 轮修订时**降级到 backlog**。理由：实测发现非 screenutil 项目已经能用本库——screenutil 没初始化时 `.r/.w/.h/.sp` 直接返回原值，本库尺寸功能仍可用（见 3.3 节）。SizeAdapter 只剩"消除 transitive 依赖洁癖"价值，优先级低。如未来真要做，作为可选项接入 v1.x 后续小版本。

---

## 第 7 章：风险与不确定性

### 7.1 v2 究竟需不需要？

**判定标准：** 跑完 v1.9（consumed 断言 + Tailwind.of）之后观察 3–6 个月：
- 如果 debug 模式下 `Builder has been consumed` 这条断言**很少**触发 → 说明 mutable builder 复用不是真问题，可能不需要 v2
- 如果断言**频繁**触发，团队反复因为 builder 复用浪费时间 → 才考虑 v2 的 immutable + copyWith 改造

不要现在就规划 v2。先把 v1 做扎实。

> **修订记录（2026-05-15，三次修订）：**
> - 第 1 次：原判定基于"v1.8 `.mk` 漏调 lint 拦截率"。v1.8 lint 已取消（见 3.1）
> - 第 2 次：判定切换到 consumed assert 触发频率
> - 第 3 次（本次）：里程碑重排后 consumed assert 现在归属 **v1.9**，不是原 v1.10
> - 3.2 节实测降级为 ⭐⭐（只在"持有 builder 跨多次终止符复用"时出现）——意味着 consumed assert 触发率本身预期就不会高。判定 v2 必要性不能只看绝对触发数，要看"假设 consumed assert 不存在，这些触发对应的 bug 代价"，靠团队主观判断

### 7.2 ~~screenutil 解耦后的兼容风险~~ —— **风险解除**

> **修订记录（2026-05-15，第 2 轮）：** 本节原讨论 v1.8 SizeAdapter 的兼容风险。SizeAdapter 已降级到 backlog（见 3.3 实测+ 第 6 章里程碑注 3），所以本节风险**自动解除**。
> 
> 如果未来真要做 SizeAdapter，再回来填这节——届时核心兼容风险是 `lib/flutter_tailwind.dart:2` 的 `export 'package:flutter_screenutil/...'` 不能在 v1.x 移除，必须 v2 才能动。

### 7.3 tree-shaking 表现未知

**问题：** 上千个 getter 是否真的能被 dart2js / aot-compile 干净 tree-shake，目前**无数据支撑**。

**缓解：**
- v1.8 之前或之中补一个 size benchmark example（不算阻塞性任务，可以提前做）
- 文档里在"FAQ"段写明"如果你的项目对 bundle size 敏感，先跑 benchmark"
- 真出问题再做"按颜色族拆 extension"的工作

### 7.4 文档迁移期的混乱

**问题：** 在 v1.8 完成前，三处文档并存的状态会持续几个月，用户可能在不同地方看到不同信息。

**缓解：**
- 在 README 顶部加 banner：`📖 Documentation is being consolidated to docs/. If you find conflicts, docs/ is the source of truth.`
- v1.8 完成后，`guide.md` 和 cursor rules 都从 docs/ 自动生成，永久解决

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
| **`.mk` 漏调** | 用户忘记在链尾加 `.mk`。在 typed Dart 中通常立即编译错误，仅 `dynamic` / 独立语句这种极少数边角场景才会静默——见 3.1 节的修订记录 |

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

⭐ 标记的 5 个文件占 55% 行数，是项目的稳定核心——采用聚合大文件 + append-only 维护策略，工程上已经稳定，不在本路线图的改动范围内（见 4.3 节决策记录）。

---

## 附录 C：本文档的修订建议

文档不打算定稿就锁死。建议每完成一个里程碑后回来更新：

- v1.8 发布后：在 3.4 节标记"已解决"；在 3.5 节标记"cursor rules 教错已修正、.primary throw 已加 try-catch"；在 3.7 节填入 size benchmark 实测数据（见 7.3）
- v1.9 发布后：在 3.2 节加"实测帮助用户发现的 bug 数"；在 3.5 节标记"已 deprecated context，待 v2 移除"
- v1.10 发布后：在 3.6 节标记"已解决"
- SizeAdapter（backlog）：如未来真做，标记 3.3 节相关方案为"已落地"

文档完整生命周期是"v1.7 → v2.0 决策点"，3 个里程碑预计 3–6 个月。
