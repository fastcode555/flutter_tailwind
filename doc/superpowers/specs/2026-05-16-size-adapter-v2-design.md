# SizeAdapter 抽象 — flutter_tailwind v2.0 设计文档

> **日期**：2026-05-16
> **作者**：Barry + Claude（结对设计）
> **目标版本**：v2.0.0（SemVer 破坏性升级）
> **关联文档**：`doc/superpowers/specs/2026-05-15-flutter-tailwind-analysis.md` 的 3.3 节
> **状态**：设计已批准，等待 spec self-review + 用户复核 + writing-plans

---

## 1. 引言

### 1.1 背景

v1.x 时代库通过 `flutter_screenutil` 做屏幕适配，演化路径：

- **≤ v1.6**：所有 builder 内部隐式调 `.r/.w/.h/.sp` —— 用户写 `container.w200.mk` 实际拿到 `Container(width: 200.w)`。"自动响应式"但行为出乎用户意料（200 在不同设备成 270 或 178）。
- **v1.7（commit 2ed8c91）**：剥离默认适配，新增显式 opt-in API `.adaptW/.adaptH/.adaptR/.adaptSp`。用户写 `container.w200.adaptW.mk` 才适配。
- **v1.8.0（2026-05-15）**：文档统一、`.primary` 加 try-catch、修 cursor rules 教错。`.adaptW/H/R/Sp` 文档化。

但 v1.7/v1.8 都有问题：
1. `flutter_screenutil` 仍是依赖 —— 不用响应式的项目被强制装一个库
2. 想换其他适配方案（responsive_framework、sizer、自研）的用户没出口
3. `.adaptW/H/R/Sp` 逐调用 opt-in —— 大量调用点都要显式带后缀

### 1.2 v2.0 的产品决策

**用一个全局可注入的 `SizeAdapter` 抽象统一处理**所有"数值 → 设备尺寸"转换。

- 库 zero dependency on `flutter_screenutil`（v1.8 已删依赖，v2.0 不恢复）
- 用户在 app 启动时**一处配置**：`Tailwind.instance.configSizeAdapter(...)`
- 默认 `IdentitySizeAdapter`（不缩放）—— 不配就拿原值，行为可预测

### 1.3 目标

- 删除 `.adaptW/.adaptH/.adaptR/.adaptSp` 4 个 opt-in getter
- 引入 `SizeAdapter` 抽象基类 + `IdentitySizeAdapter` 默认实现
- 库内部所有几何字段（width/height/padding/margin/radius/positioned/shadow/spacing）和字号字段在 `mk` 阶段过 adapter
- 保留 `hFull/wFull` 系列（62 个 getter）+ 在 `Tailwind.instance` 上缓存 `screenW/screenH`
- 用 `MediaQuery` 替换 `image_loader` 内的 `ScreenUtil().pixelRatio`
- 同步清理 v1.x 遗留：`Tailwind.instance.context` 字段移除（顺手解决分析文档 3.5 节）

### 1.4 非目标

- 不做 `tool/build_cursor_rules.dart` 半自动化（仍 backlog）
- 不做 `doc/api/` 完整 API 参考（仍 backlog）
- 不做 README 全面瘦身（依赖上一条）
- 不做 size benchmark / tree-shaking 验证（仍 backlog）
- 不为外部用户准备 deprecation 期 —— 用户已明确选择"直接删 `.adaptW/H/R/Sp`"

---

## 2. 架构概览

```
┌────────────────────────────────────────────────────────────┐
│                  Tailwind (singleton)                       │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  sizeAdapter: SizeAdapter = const IdentitySizeAdapter│  │
│  │  screenW: double = 0.0    (cached on init)           │  │
│  │  screenH: double = 0.0    (cached on init)           │  │
│  │  primaryColor: Color?                                │  │
│  │  imageFactory: BaseImageFactory?                     │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────┘
                            ▲
                            │ reads
        ┌───────────────────┼────────────────────────┐
        │                   │                         │
   builders' mk        size_builder's          image_loader's
   call adapter.w()    hFull/wFull read        build() reads
   /h()/r()/sp() to    screenW/screenH         pixelRatio from
   final values        from singleton          MediaQuery.of(ctx)
                                               (no global cache needed)
```

依赖方向：所有内部组件 → `Tailwind.instance`（单点配置）。`SizeAdapter` 是接口，**不**直接依赖任何具体适配库。

---

## 3. 核心接口设计

### 3.1 `SizeAdapter` 抽象基类

**新增文件 `lib/src/adapters/size_adapter.dart`：**

```dart
/// Pure value-scaling abstraction. Implementations decide how a raw
/// number from a builder chain should map to a device-adjusted number.
///
/// The library defaults to [IdentitySizeAdapter] (no scaling) so projects
/// that don't need responsive sizing get exactly the values they write.
///
/// To integrate flutter_screenutil, responsive_framework, sizer, or any
/// custom solution, implement this and inject via
/// [Tailwind.instance.configSizeAdapter].
abstract class SizeAdapter {
  /// Scale a width-direction value (Container width, etc.).
  double w(double value);

  /// Scale a height-direction value.
  double h(double value);

  /// Scale a responsive value (typically uses min(width, height) factor).
  /// Used for radii, square sizes, paddings, margins, positions, shadows.
  double r(double value);

  /// Scale a font size. Often differs from [r] because of platform
  /// text-scale settings.
  double sp(double value);
}

/// Default implementation. Returns every value unchanged.
class IdentitySizeAdapter implements SizeAdapter {
  const IdentitySizeAdapter();
  @override double w(double v) => v;
  @override double h(double v) => v;
  @override double r(double v) => v;
  @override double sp(double v) => v;
}

// Top-level shorthand helpers used inside builders. Reduce per-call
// boilerplate from `Tailwind.instance.sizeAdapter.r(v)` to `sr(v)`.
SizeAdapter get _adapter => Tailwind.instance.sizeAdapter;
double sw(double v) => _adapter.w(v);
double sh(double v) => _adapter.h(v);
double sr(double v) => _adapter.r(v);
double ssp(double v) => _adapter.sp(v);
```

**4 通道语义**：

| 方法 | 处理什么 | screenutil 对应 |
|---|---|---|
| `w(v)` | 宽度方向尺寸 | `v.w` |
| `h(v)` | 高度方向尺寸 | `v.h` |
| `r(v)` | 响应式尺寸（圆角/padding/shadow/positioned 等） | `v.r` |
| `sp(v)` | 字号 | `v.sp` |

通道独立保留是为了：
- 跟 screenutil 4 个 API 对齐，用户接入 4 行
- 字号缩放通常考虑系统 `textScaleFactor`，跟几何缩放公式不同
- 灵活性 —— 用户的 adapter 实现可以让 `r` 跟 `w` 取一样的值（如果他们不区分），但反之不行

### 3.2 用户接入示例

```dart
// 用户自己的代码
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ScreenUtilSizeAdapter implements SizeAdapter {
  const ScreenUtilSizeAdapter();
  @override double w(double v) => v.w;
  @override double h(double v) => v.h;
  @override double r(double v) => v.r;
  @override double sp(double v) => v.sp;
}

void main() {
  Tailwind.instance.configSizeAdapter(const ScreenUtilSizeAdapter());
  runApp(const MyApp());
}
```

4 行 adapter 类 + 1 行注入。其他第三方适配库（如 `responsive_framework`、`sizer`）接法同理。

---

## 4. Tailwind 单例改造

### 4.1 字段变化（v1.x → v2.0）

| 字段 | v1.x | v2.0 |
|---|---|---|
| `context` | `BuildContext?` | **删除** |
| `primaryColor` | `Color?` | 不变 |
| `imageFactory` | `BaseImageFactory?` | 不变 |
| `sizeAdapter` | — | **新增** `SizeAdapter` = `IdentitySizeAdapter()` |
| `screenW` | — | **新增** `double` = `0.0` |
| `screenH` | — | **新增** `double` = `0.0` |

### 4.2 `init` 行为变化

```dart
void init(BuildContext context, [Color? fallbackPrimary]) {
  final mq = MediaQuery.maybeOf(context);
  if (mq != null) {
    screenW = mq.size.width;
    screenH = mq.size.height;
  }
  primaryColor = fallbackPrimary ?? Theme.of(context).primaryColor;
  // context is intentionally NOT stored
}
```

调用签名兼容 v1.x，但行为不同：
- v1.x：`this.context = context` 持有引用，每次 `.primary` 重新 `Theme.of`
- v2.0：立即提取需要的值缓存到字段，**不持有 context**

这同时解决了分析文档 3.5 节的 BuildContext 持有问题。

### 4.3 `.primary` getter 简化

```dart
// v1.x（v1.8 加过 try-catch）
Color get primary {
  final ctx = context;
  if (ctx == null) return primaryColor ?? Colors.amber;
  try { return Theme.of(ctx).primaryColor; }
  catch (_) { return primaryColor ?? Colors.amber; }
}

// v2.0
Color get primary => primaryColor ?? Colors.amber;
```

不再 try-catch（因为不再持有 context），不再依赖 `Theme.of`。`init` 已经把 primaryColor 提取出来了，直接读字段。

### 4.4 `configSizeAdapter`

```dart
void configSizeAdapter(SizeAdapter adapter) {
  sizeAdapter = adapter;
}
```

跟 `configImageFactory` 风格一致。多次调用以最后一次为准 —— 后续 `mk` 读最新值。

### 4.5 init 调用位置约定

`init` **必须**在 `MaterialApp` 内部的 `BuildContext` 上调用：

```dart
// ✅ Correct
return MaterialApp(
  theme: ThemeData(primaryColor: Colors.blue),
  builder: (ctx, child) {
    Tailwind.instance.init(ctx);
    return child!;
  },
  home: const HomePage(),
);

// ❌ Wrong — context is above MaterialApp, MediaQuery.maybeOf returns null
return ScreenUtilInit(
  builder: (ctx, child) {
    Tailwind.instance.init(ctx);   // screenW/screenH 不会被设置
    return MaterialApp(...);
  },
);
```

如果在错位置调用：
- `screenW/screenH` 保持 0
- 用户调 `.hFull` 时（debug）assert 触发，提示重新检查 init 位置
- 用户调 `.hFull` 时（release）返回 0，UI 显式失效

---

## 5. 字段映射规则

每个 builder 字段在 `mk` 阶段调用 adapter 的哪个方法。

| Builder | 字段 | adapter 调用 | 备注 |
|---|---|---|---|
| **SizeBuilder** | `width` | `adapter.w(v)` | 宽度方向 |
|  | `height` | `adapter.h(v)` | 高度方向 |
|  | `size`（正方形） | `adapter.r(v)` | 单一数值代表 W=H |
|  | `hFull/wFull` 系列 | **不调** | 从 `Tailwind.instance.screenW/screenH` 读绝对像素 |
| **PaddingBuilder** | 4 边数值 | `adapter.r(v)` | 统一 `.r`（比 LR=w/TB=h 简单，差异肉眼不可见） |
| **MarginBuilder** | 4 边数值 | `adapter.r(v)` | 同上 |
| **BorderRadiusBuilder** | 圆角值 | `adapter.r(v)` |  |
| **PositionedBuilder** | `left/right/top/bottom` | `adapter.r(v)` | 统一 |
| **FontSizeBuilder** | `fontSize` | `adapter.sp(v)` | adapter 4 个方法中的 sp 通道 |
| **ShadowBuilder** | `blurRadius/spreadRadius/offset` | `adapter.r(v)` |  |
| **SpacingBuilder** | `spacing` | `adapter.r(v)` | Row 水平/Column 垂直但 SpacingBuilder 不知方向，统一 `.r` |
| **BorderWidthBuilder** | 边框宽度 | **不调** | hairline 哲学：1px 边框不应缩放 |
| 任意 | `expanded`/`opacity`/`key` | **不调** | 非尺寸语义 |

### 5.1 实现风格

每个 builder 的 `mk` 方法内直接用 top-level helper：

```dart
// Container 示例
@override
Widget get mk {
  if (_useContainer) {
    return createExpanded(Container(
      width: width != null ? sw(width!) : (size != null ? sr(size!) : null),
      height: height != null ? sh(height!) : (size != null ? sr(size!) : null),
      padding: finalPadding,    // 内部已过 sr(v)
      margin: finalMargin,      // 同上
      ...
    ));
  }
  ...
}
```

`PaddingBuilder.finalPadding` getter（构造 EdgeInsets 的中心位置）集中调 `sr(v)`：

```dart
EdgeInsetsGeometry? get finalPadding {
  if (!hasPadding) return null;
  return EdgeInsets.fromLTRB(
    sr(innerPaddingL ?? 0),
    sr(innerPaddingT ?? 0),
    sr(innerPaddingR ?? 0),
    sr(innerPaddingB ?? 0),
  );
}
```

---

## 6. screenutil 残留耦合替换

v1.8 删除了 pubspec 依赖，但 lib 里 3 处仍引用 screenutil 类型。每处的替换方案：

### 6.1 `lib/src/base/size_builder.dart:70-72`

```dart
// 改前
double get _screenH => ScreenUtil().screenHeight;
double get _screenW => ScreenUtil().screenWidth;

// 改后
double get _screenH {
  final h = Tailwind.instance.screenH;
  assert(h > 0,
      'Tailwind.instance.init(context) must be called before using '
      'hFull/wFull/sScreen/sFull-family getters. '
      'See doc/getting-started.md.');
  return h;
}

double get _screenW {
  final w = Tailwind.instance.screenW;
  assert(w > 0, /* same message */);
  return w;
}
```

支撑 62 个 hFull/wFull/sScreen/sFull-family getter，调用方代码不变。

### 6.2 `lib/src/image_loader/image_loader.dart:322`

```dart
// 改前
_devicePixelRatio = _devicePixelRatio ?? ScreenUtil().pixelRatio;

// 改后
_devicePixelRatio = _devicePixelRatio ?? MediaQuery.of(context).devicePixelRatio;
```

`build(BuildContext context)` 方法里有 context，**不需要**走 Tailwind 全局缓存。

### 6.3 `lib/src/widgets/child/widgets.dart:4-7`

```dart
// 改前
import 'package:flutter_screenutil/flutter_screenutil.dart';

EdgeInsetsGeometry p16 = REdgeInsets.all(16);   // top-level variable
EdgeInsetsGeometry p20 = REdgeInsets.all(20);

// 改后（删除 import）
EdgeInsetsGeometry get p16 {
  final r = Tailwind.instance.sizeAdapter.r(16);
  return EdgeInsets.all(r);
}

EdgeInsetsGeometry get p20 {
  final r = Tailwind.instance.sizeAdapter.r(20);
  return EdgeInsets.all(r);
}
```

用户调用语法不变（`Container(padding: p16)` 仍合法）—— Dart 的 top-level getter 跟 variable 在使用端无区别。每次访问都重新过 adapter，支持运行时切换 adapter。

### 6.4 验证

改完后 `grep -rn "package:flutter_screenutil\|ScreenUtil()\|REdgeInsets" lib/` 应返回 0 行。

---

## 7. 用户迁移影响（v1.x → v2.0）

### 7.1 破坏性变更清单（4 条）

| # | 变更 | 用户面影响 | 迁移动作 |
|---|---|---|---|
| 1 | 删除 `.adaptW/.adaptH/.adaptR/.adaptSp` getter | 用过这 4 个的代码**编译错误** | 全部移除调用；改用 `Tailwind.instance.configSizeAdapter` 替代 |
| 2 | 删除 `flutter_screenutil` transitive 依赖（v1.8 已删，v2.0 正式公告） | 间接 import `ScreenUtilInit`/`ScreenUtil` 符号的代码**编译错误** | 用户在自己 `pubspec.yaml` 显式加 `flutter_screenutil` 并 import |
| 3 | 删除 `Tailwind.instance.context` 字段；`.primary` getter 移除 try-catch | 直接读取 `Tailwind.instance.context` 的代码**编译错误**（example 里 0 例） | 不再持有 context；用户改用 `Tailwind.instance.primaryColor` 或自己 `Theme.of(context)` |
| 4 | `init` 行为变化：必须在 `MaterialApp` 内部调用 | 在 `MaterialApp` 之上调用（如 `ScreenUtilInit.builder` 里）会让 `screenW/screenH` 保持 0 → `hFull/wFull` 系列在 debug 模式 assert，release 模式 silent 失效 | 把 `init` 调用搬到 `MaterialApp.builder` 内部或 home 页面 build 内 |

### 7.2 未变更的 API（不破坏）

- `container/text/row/column/listview/gridview/checkBox/radio/...` 所有 builder 入口
- 所有预设 getter（`.p16/.s100/.red/.rounded8/.spacing16/.hFull50/...`）
- `Tailwind.instance.addImageConfig`/`configImageFactory`/`primaryColor` 字段的调用签名（行为不变）
- `Tailwind.instance.init(ctx, [color])` 的调用签名（行为变了但语法兼容）
- 顶级常量 `p16`/`p20` 的使用语法（变量变 getter，调用方无感）

### 7.3 迁移示例

**从 v1.7.x/v1.8.x 升 v2.0：**

```dart
// 旧代码
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: Container(
              width: 200,
              height: 100,
              padding: const EdgeInsets.all(16),
              child: 'hello'.text.f16.adaptSp.mk,   // ← .adaptSp 删除
            ).adaptW.adaptH.mk,                     // ← .adaptW/H 删除
          ),
        );
      },
    );
  }
}

// v2.0 代码
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ScreenUtilSizeAdapter implements SizeAdapter {
  const ScreenUtilSizeAdapter();
  @override double w(double v) => v.w;
  @override double h(double v) => v.h;
  @override double r(double v) => v.r;
  @override double sp(double v) => v.sp;
}

void main() {
  Tailwind.instance.configSizeAdapter(const ScreenUtilSizeAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          builder: (ctx, child) {
            Tailwind.instance.init(ctx);            // ← init 位置
            return child!;
          },
          home: Scaffold(
            body: Container(
              width: 200,
              height: 100,
              padding: const EdgeInsets.all(16),
              child: 'hello'.text.f16.bold.mk,      // ← 移除 .adaptSp
            ),                                       // ← 移除 .adaptW.adaptH
          ),
        );
      },
    );
  }
}
```

3 步：(1) 写 4 行 `ScreenUtilSizeAdapter`，(2) `main()` 里注入 + 把 `init` 搬到 `MaterialApp.builder`，(3) 全文搜索删除 `.adaptW/.adaptH/.adaptR/.adaptSp`。

---

## 8. 测试策略

### 8.1 新增测试文件

**`test/size_adapter_test.dart`**（v2.0 核心新功能必须覆盖）：

```
1. IdentitySizeAdapter 的 4 个方法都返回原值
2. configSizeAdapter 注入自定义 adapter 后，Container.width 走该 adapter
3. 切换 adapter — 多次 configSizeAdapter，后续 mk 读最新值
4. Mock2xAdapter — container.w200.mk 后 Container.width == 400（end-to-end）
5. fontSize — 'hello'.text.f16.mk 后 Text 的 fontSize == adapter.sp(16)
6. padding — container.p16.child(text).mk 后 padding == EdgeInsets.all(adapter.r(16))
```

### 8.2 扩展 / 改名 `test/tailwind_primary_test.dart` → `test/tailwind_init_test.dart`

保留 v1.8 的 5 个 `.primary` 测试，新增：

```
7. init 后 screenW == MediaQuery.size.width
8. init 后 screenH == MediaQuery.size.height
9. 未 init 时访问 hFull 在 debug 模式触发 assert
10. assert 文案包含 'init(context)' 字符串（让用户搜得到）
```

第 9-10 条对应 `_screenH/_screenW` 的 assert message。

### 8.3 非范围

完整的"每个 builder 一个 widget test"测试基线**不在本 spec 范围**——原 v1.9 测试基线里程碑在 v2.0 实施完后会被重新规划（spec 命名为 "v2.1 test baseline"）。

### 8.4 CI

CI 仍然只跑 `flutter build apk/ios`。本 spec 不动 `.github/workflows/build.yml`。`flutter analyze` + `flutter test` 加入 CI 留待下一里程碑（v2.1）。

---

## 9. 文档更新

| 文件 | 改动 |
|---|---|
| `doc/getting-started.md` | 重写 init 章节；新增"SizeAdapter 接入"章节；移除"opt-in adaptW/H/R/Sp"过时段落 |
| `doc/patterns/screen-adaptation.md` | **整段重写** —— 全部从 adaptW/H/R/Sp 改成 SizeAdapter；给 `ScreenUtilSizeAdapter` 完整复制-粘贴模板；附其他库（responsive_framework、sizer）接入示例（仅签名） |
| `doc/patterns/spacing.md` | 不变 |
| `README.md` | 顶部链接区加 "Screen scaling is opt-in via SizeAdapter"；feature gallery 不变 |
| `.cursor/rules/flutter_tailwind.mdc` | 重写"屏幕适配"段；删除所有 adaptW/H/R/Sp 引用；新增 SizeAdapter + ScreenUtilSizeAdapter 模板 |
| `CLAUDE.md` | "Responsive sizing" 段重写；"Singleton config" 段更新（删 context 字段引用、说明 init 不再持有 context） |
| `PAY_ATTENTION.md` | 不变（发布命令一致） |
| `CHANGELOG.md` | 新增 v2.0.0 段（见第 10 章草稿） |
| `pubspec.yaml` | version: 1.8.0 → 2.0.0 |

---

## 10. CHANGELOG 2.0.0（草稿）

```markdown
## 2.0.0

### Breaking changes

- Removed `adaptW`/`adaptH`/`adaptR`/`adaptSp` getters. Replaced by
  global configuration via `Tailwind.instance.configSizeAdapter(...)`.
  To preserve the old behavior, write a 4-line SizeAdapter that wraps
  screenutil — see `doc/patterns/screen-adaptation.md`.
- Removed `flutter_screenutil` dependency. The library no longer
  transitively pulls screenutil. If your project relied on the indirect
  export (e.g. `ScreenUtilInit` imported via flutter_tailwind), add
  `flutter_screenutil` to your own pubspec.yaml.
- Removed `Tailwind.instance.context` field. `init` now extracts needed
  values from the context immediately and does not retain it. `.primary`
  no longer needs a try-catch (the deactivated-context throw scenario
  cannot happen anymore).
- `p16` / `p20` are now top-level getters (were `final` variables).
  Calling syntax unchanged but each access now routes through SizeAdapter.

### New

- `SizeAdapter` abstract class — 4-method interface (`w/h/r/sp`) that
  decouples the library from any specific screen-adaptation package.
  Default `IdentitySizeAdapter` (no scaling).
- `Tailwind.instance.screenW` / `screenH` — cached screen dimensions
  populated by `init(context)`. Used internally by the hFull/wFull
  family; also exposed for user code.
- `Tailwind.instance.configSizeAdapter(adapter)` — install your
  scaling implementation, typically once at app startup.
- Top-level helpers `sw/sh/sr/ssp` in `lib/src/adapters/size_adapter.dart`
  — shorthand for `Tailwind.instance.sizeAdapter.{w/h/r/sp}(v)`.
  Internal use only (not exported from the public surface).

### Migration (1.x → 2.0)

1. Remove every `.adaptW/.adaptH/.adaptR/.adaptSp` call from your code.
2. If you used screen scaling, write a SizeAdapter subclass:
   ```dart
   class ScreenUtilSizeAdapter implements SizeAdapter {
     const ScreenUtilSizeAdapter();
     @override double w(double v) => v.w;
     @override double h(double v) => v.h;
     @override double r(double v) => v.r;
     @override double sp(double v) => v.sp;
   }
   void main() {
     Tailwind.instance.configSizeAdapter(const ScreenUtilSizeAdapter());
     runApp(...);
   }
   ```
3. If you used `hFull/wFull`-family getters, call
   `Tailwind.instance.init(context)` from inside `MaterialApp.builder`
   (or any context inside MaterialApp).
```

---

## 11. 风险与备注

### 11.1 init 调用位置错误的 silent failure

最常见的用户错误：在 `ScreenUtilInit.builder` 里调 init（v1.x 时代 cursor rules 教错过）。在 v2.0：
- debug 模式 → `_screenH/_screenW` 触发 assert，明确提示
- release 模式 → `screenW/screenH` 是 0，hFull 等返回 0 height container，UI 显式失效

缓解：cursor rules 重写 + doc/getting-started.md 显式 ❌ 反例 + assert message 指向文档。

### 11.2 用户依赖 v1.8 的过渡 API

v1.8 推荐了 `.adaptW/H/R/Sp` 作为显式 opt-in，距 v2.0 仅 1 天发版间隔，pub.dev 上 v1.8 下载量极低，但仍可能存在外部用户。v2.0 直接删除 4 个 getter 是破坏性变更——SemVer 升 v2.0 已经处理了语义，但需要 CHANGELOG 明确写迁移路径（见第 10 章）。

### 11.3 hFull/wFull 系列在 init 前的行为

`Tailwind.instance.screenW = 0.0` 是默认值。如果用户根本没调 init 就用 `.hFull`：
- debug：assert 触发，提示需要 init
- release：返回 0 → 该 widget 高度 0 → 用户能从 UI 上立刻看到"hFull 失效"

这是有意设计 —— 不用 fallback 到设计稿尺寸（如 812）。fallback 默认值会让 bug 隐藏到生产。

### 11.4 顶级 `p16`/`p20` 从 variable 改 getter 的次要影响

Dart top-level getter 跟 variable 在使用端无区别。但 getter 每次访问都重新计算：
- 优点：支持运行时切换 adapter
- 缺点：极小的性能开销（一次方法调用 + 一次 `EdgeInsets.all` 构造）—— 可忽略

如果未来发现这是热点，可以加缓存（按当前 sizeAdapter 实例 hash 缓存）。当前不优化。

### 11.5 没规划 v2 之后的路线

本 spec 是 v2.0 单一里程碑的设计。v2.1+ 的事（测试基线扩展、`doc/api/`、tool/build_cursor_rules.dart、size benchmark 等）不在范围内，留待 v2.0 发布后基于真实用户反馈重新规划。

---

## 12. 实施依赖与顺序提示

文件改动顺序建议（writing-plans 会做更细的拆解）：

1. 新增 `lib/src/adapters/size_adapter.dart`（SizeAdapter + IdentitySizeAdapter + top-level helpers）
2. 改 `lib/src/tailwind.dart`：加 `sizeAdapter`/`screenW`/`screenH` 字段、改 `init`、删 `context` 字段、简化 `.primary`
3. 改 `lib/flutter_tailwind.dart`：export 新文件 `src/adapters/size_adapter.dart`
4. 改 `lib/src/widgets/child/widgets.dart`：删 screenutil import + 改 p16/p20 为 getter
5. 改 `lib/src/base/size_builder.dart`：`_screenH/_screenW` 改读 Tailwind 缓存 + assert
6. 改 `lib/src/image_loader/image_loader.dart`：`ScreenUtil().pixelRatio` 改 `MediaQuery.of(context).devicePixelRatio`
7. 逐个 builder mk 改造（PaddingBuilder/MarginBuilder/SizeBuilder/PositionedBuilder/...）调用 sr/sw/sh/ssp helper
8. 写 `test/size_adapter_test.dart`
9. 改名/扩展 `test/tailwind_init_test.dart`
10. 文档：重写 doc/getting-started.md + doc/patterns/screen-adaptation.md；更新 CLAUDE.md、cursor rules、README
11. `pubspec.yaml` version 2.0.0；CHANGELOG 写 2.0.0 段
12. 跑 `flutter analyze`/`flutter test`/`flutter pub publish --dry-run` 验证

---

## 附录 A：实施前的关键不确定性

- **PaddingBuilder/MarginBuilder 的具体 finalPadding/finalMargin getter 实现** —— 当前代码没读过细节，可能不止单一 `EdgeInsets.fromLTRB`，需要在 writing-plans 阶段先 Read。
- **每个 builder 内部对 `width`/`height`/`size` 字段访问的具体语法** —— 类似 `width ?? size` 这种模式可能在多处出现，需要确认改造覆盖率。
- **是否有其它 builder（非 Size/Padding/Margin/BorderRadius/Positioned/FontSize/Shadow/Spacing）也需要调 adapter** —— 写 plan 时再 grep 一遍 lib/src/base/ 确保不漏。
