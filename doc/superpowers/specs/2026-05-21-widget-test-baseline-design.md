# Widget 测试基线 — flutter_tailwind v2.1 质量投入设计文档

> **日期**：2026-05-21
> **作者**：Barry + Claude（结对设计）
> **目标版本**：v2.1（feature work，非破坏性）
> **关联文档**：`doc/superpowers/specs/2026-05-16-size-adapter-v2-design.md`
> **状态**：设计已批准，等待 spec self-review + 用户复核 + writing-plans

---

## 1. 引言

### 1.1 背景

v2.0.1 已经发布到 pub.dev，把屏幕适配重构为可插拔的 `SizeAdapter`、清理了全部 lib/ 下的 analyze 警告、补齐了 CI 的 analyze + test job。当前测试覆盖：

- `test/size_adapter_test.dart`（17 个 case）—— SizeAdapter 路由、`Mock2xAdapter` 端到端
- `test/tailwind_init_test.dart`（8 个 case）—— `init()` 行为、`primaryColor` fallback、hFull/wFull assert

但 **builder/widget 层面的覆盖几乎为零**。lib/src/widgets/ 下 18 个 builder 变体的默认行为、链式 setter 应用、终止器路径都没有钉子测试。CLAUDE.md 里写明「Broader builder/widget/golden coverage is still pending — planned for a follow-up after v2.0」，本 spec 就是落地这件事。

### 1.2 这轮投入的产品决策

**主线**：全量 widget 的 widget test + golden test 双重覆盖。

- widget test：进 CI，验证链式 setter 是否正确落到底层 widget 属性
- golden test：本地跑，验视觉回归（CI 通过 `@Tags(['golden'])` 跳过）

**配套**：抽出 `test/_shared/` 共享辅助层，把现有两个测试文件里散开的 `Mock2xAdapter` setUp/tearDown 模板收敛，并提供参数化的 axis matcher（`verifyColorAxis`、`verifySizeAxis` 等）减少跨 widget 的样板。

### 1.3 不在范围

- **input widget** — 现状链式 API 不好用，不在测试盘点；将来如重做或淘汰另起 spec
- **image_loader 私有 widget**（`_Image`、`_CircleImage`）— 通过 `ImageLoader` 外层间接测
- **文档** — 下一轮 spec
- **新增 widget 或 axis** — v2.1 feature 工作不在这轮

---

## 2. 架构

### 2.1 测试目录布局

```
test/
├── _shared/                                ← 新增：共享测试辅助
│   ├── axis_matchers.dart                  ← 参数化 axis 验证函数
│   ├── adapter_helpers.dart                ← Mock2xAdapter + setUp/tearDown 模板
│   └── golden_helpers.dart                 ← goldenTest() 包装 + 字体加载
│
├── widgets/                                ← 新增：widget 行为测试（CI 跑）
│   ├── child/
│   │   ├── text_test.dart
│   │   ├── buttons_test.dart
│   │   ├── check_box_test.dart
│   │   ├── radio_test.dart
│   │   ├── image_test.dart
│   │   ├── icon_test.dart
│   │   ├── svg_test.dart
│   │   ├── padding_test.dart
│   │   ├── sized_box_test.dart
│   │   ├── positioned_test.dart
│   │   ├── wrap_test.dart
│   │   └── shader_mask_test.dart
│   └── container/
│       ├── container_test.dart
│       ├── children_container_test.dart    ← row / column / stack
│       └── list_view_test.dart             ← list / grid + builder/dataBuilder
│
├── widgets_golden/                         ← 新增：golden 测试（本地跑）
│   ├── child/...                           ← 镜像 widgets/ 结构
│   ├── container/...
│   └── goldens/                            ← .png 快照存放点
│       ├── text/
│       ├── container/
│       └── ...
│
├── size_adapter_test.dart                  ← 既有，保留
└── tailwind_init_test.dart                 ← 既有，保留
```

**关键约束**：
- 行为测试和 golden 测试**分目录** —— CI 跑 `flutter test test/`（递归含 `widgets/`，但 `widgets_golden/` 因 `@Tags` 被跳过）
- `_shared/` 下划线前缀，避免被当成测试目标
- 镜像 `lib/src/widgets/` 的目录结构（child/ 和 container/ 分开），方便路径联想

### 2.2 共享辅助层（`_shared/`）

#### `adapter_helpers.dart`

```dart
class Mock2xAdapter implements SizeAdapter {
  // 从 size_adapter_test.dart 抽出来，作为共享 fixture
  @override double w(num v) => v.toDouble() * 2;
  @override double h(num v) => v.toDouble() * 2;
  @override double r(num v) => v.toDouble() * 2;
  @override double sp(num v) => v.toDouble() * 2;
}

void setUpMockAdapter({double factor = 2.0}) {
  Tailwind.instance.configSizeAdapter(Mock2xAdapter());
  // 同时重置 screenW/screenH/primaryColor，避免上个 test 污染
}

void tearDownAdapter() {
  Tailwind.instance.configSizeAdapter(IdentitySizeAdapter());
  // 完整 reset
}

Future<void> pumpBuilder(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
}
```

#### `axis_matchers.dart`

参数化函数，让 widget 测试文件按 axis 一行测一项：

```dart
// 颜色 axis
Future<void> verifyColorAxis(
  WidgetTester tester,
  Widget Function() build,         // e.g. () => container.red.s100.mk
  {required Color expectedColor},
) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  final decoration = container.decoration as BoxDecoration;
  expect(decoration.color, expectedColor);
}
```

**首批提供的 matcher**（覆盖 lib/src/base/ 下最常用的 axis）：
- `verifyColorAxis` / `verifyBorderColorAxis`
- `verifySizeAxis` / `verifyWidthAxis` / `verifyHeightAxis`
- `verifyPaddingAxis` / `verifyMarginAxis`
- `verifyBorderRadiusAxis` / `verifyBorderWidthAxis`
- `verifyShadowAxis`
- `verifySpacingAxis`（Row/Column 专用）
- `verifyFontSizeAxis`
- `verifyAlignmentAxis`
- `verifyOpacityAxis`

每个 matcher 内部 `pumpBuilder` 一次、从 widget tree 拿底层 widget、断言属性。这层避免「同一个 .red 在 15 个 widget 文件里重复测 15 遍」。

#### `golden_helpers.dart`

```dart
Future<void> loadAppFonts() async {
  // 显式加载 Roboto，避免 macOS 上 fallback 到 Helvetica
  final fontLoader = FontLoader('Roboto');
  // ... 从 packages 资源加载 ttf
  await fontLoader.load();
}

Future<void> goldenTest(WidgetTester tester, Widget widget, String name) async {
  await pumpBuilder(tester, widget);
  await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/$name.png'));
}
```

Golden 文件命名约定：`goldens/<widget>/<scenario>.png`，如 `goldens/text/red_f16_bold.png`。

### 2.3 单 widget 测试文件的标准结构

每个 widget 测试文件按**四段式**组织：

```dart
void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('text — 默认行为', () {
    testWidgets('.mk 渲染裸 Text', ...);
    testWidgets('空字符串也能 .mk', ...);
  });

  group('text — axis 路由', () {
    testWidgets('color 系列', (t) =>
        verifyColorAxis(t, () => 'hi'.text.red, expectedColor: Colors.red));
    testWidgets('fontSize 走 adapter.sp', (t) =>
        verifyFontSizeAxis(t, () => 'hi'.text.f16, expectedFontSize: 32));
  });

  group('text — 终止器', () {
    testWidgets('.mk 返回 Widget', ...);
    testWidgets('.click(onTap:) 包 GestureDetector + debounce', ...);
  });

  group('text — 回归', () {
    testWidgets('AutoSizeText 在分数 adapter 下不 assert', ...);  // 历史 bug 钉子
  });
}
```

| 段 | 测什么 | 必须有吗 |
|---|---|---|
| 默认行为 | 不调任何链式方法的 baseline + 极端入参（空、null） | ✅ |
| axis 路由 | 调用 `_shared/axis_matchers.dart` 验链式 setter | ✅（只测它支持的 axis） |
| 终止器 | `.mk / .child / .children / .click / .onChanged / .builder` | ✅ |
| 回归 | 历史 bug 的钉子测试 | 按需 |

### 2.4 Golden 测试的范围与组织

**范围（少而典）**：

| 场景类别 | 张数 | 例子 |
|---|---|---|
| 默认外观 | 1 | `text/default.png` |
| 代表性链式组合 | 2-3 | `text/red_f16_bold.png` |
| 边界视觉 | 1-2 | `text/empty.png`、`text/very_long_no_overflow.png` |

每个 widget 上限约 5 张，13 个 widget 共 ≤75 张 PNG。

**模板**：

```dart
@Tags(['golden'])
library;

void main() {
  setUpAll(loadAppFonts);
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('default', (t) => goldenTest(t, 'hi'.text.mk, 'text/default'));
  testWidgets('red f16 bold', (t) => goldenTest(t, 'hi'.text.red.f16.bold.mk, 'text/red_f16_bold'));
}
```

**字体处理**：用 `FontLoader` 显式注册 Roboto，避免 macOS 上跑出 Helvetica fallback。Zero-dependency（不引 `golden_toolkit`/`alchemist`）。

**运行方式**：

```bash
# 本地拍 baseline
flutter test test/widgets_golden/ --tags golden --update-goldens

# 本地验证
flutter test test/widgets_golden/ --tags golden

# CI（默认跳过 golden）
flutter test test/
```

---

## 3. Widget 盘点 + axis 矩阵

| Widget | 文件 | size | color | padding | margin | radius | border | shadow | spacing | font | 终止器 | 备注 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **text** | child/text.dart | – | ✓ | – | – | – | – | – | – | ✓ | `.mk` | AutoSizeText 回归 |
| **buttons**（text/outlined/elevated/icon） | child/buttons.dart | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | – | – | ✓ | `.click(onTap:)` | 4 个变体 + Debouncer |
| **check_box** | child/check_box.dart | ✓ | ✓ | ✓ | – | ✓ | ✓ | ✓ | – | – | `.onChanged(...)` | enableBorder/justIcon/material 三态 |
| **radio** | child/radio.dart | ✓ | ✓ | – | – | – | – | – | – | – | `.onChanged(...)` | – |
| **image** | child/image.dart | ✓ | – | – | – | ✓ | ✓ | ✓ | – | – | `.mk` | ImageLoader 已重构，验回归 |
| **icon** | child/icon.dart | ✓ | ✓ | – | – | – | – | – | – | – | `.mk` | – |
| **svg** | child/svg.dart | ✓ | ✓ | – | – | – | – | – | – | – | `.mk` | – |
| **padding** | child/padding.dart | – | – | ✓ | – | – | – | – | – | – | `.child(...)` | 极简 |
| **sized_box** | child/sized_box.dart | ✓ | – | ✓ | – | – | – | – | – | – | `.mk / .child(...)` | – |
| **positioned** | child/positioned.dart | – | – | – | – | – | – | – | – | – | `.child(...)` | 仅 l/t/r/b |
| **wrap** | child/wrap.dart | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | – | `.children([...])` | – |
| **shader_mask** | child/shader_mask.dart | ✓ | – | – | – | – | – | – | – | – | `.child(...)` | linearGradient 子链 |
| **container** | container/container.dart | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | – | – | `.mk / .child(...)` | 最复杂，最高优先 |
| **row / column / stack** | container/children_container.dart | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | – | `.children([...])` | 三个 widget 共一份文件 |
| **list_view / grid_view** | container/list_view.dart | ✓ | – | ✓ | – | – | – | – | ✓ | – | `.builder(...)` / `.dataBuilder<T>(...)` | 双 widget 共一份文件 |

**总计**：15 个测试文件，覆盖 ~20 个 builder 变体（含 buttons 的 4 个变体、children_container 的 row/column/stack、list_view 的 list/grid）。

**优先级分组**：

- **P0**：container、text、buttons、image、children_container（row/column/stack）— 5 个文件，最高频
- **P1 表单**：check_box、radio — 2 个文件
- **P2 媒体/布局**：icon、svg、wrap、sized_box、positioned、padding、shader_mask — 7 个文件
- **P3 列表**：list_view — 1 个文件

---

## 4. CI 集成

`.github/workflows/build.yml` 的 `test` job 已经在跑 `flutter analyze lib/ test/` + `flutter test test/`，只要新增一处配置：

**新增 `dart_test.yaml`（项目根）**：

```yaml
tags:
  golden:
    skip: "Golden tests are local-only; run with --tags golden"
```

`flutter test` 默认会跳过 `@Tags(['golden'])` 标记的文件。本地要跑就 `flutter test --tags golden`。

**Analyze 范围**：`flutter analyze lib/ test/` 自动包括新的 `test/widgets/**` 和 `test/widgets_golden/**`，不用改。

**对 CI 的影响估算**：
- 新增 15 个测试文件 × ~10 个 case ≈ 150 个 widget test
- 单个 widget test 用 `tester.pumpWidget` ~50ms，全跑 ≈ 7-10 秒
- 当前 CI test job ~1 分钟，加 10 秒可接受

---

## 5. 落地阶段

| 阶段 | 范围 | 测试增量 | 工作量估算 |
|---|---|---|---|
| **Phase 0 — 基础设施** | `_shared/` 三个辅助文件 + `dart_test.yaml` + 1 个 reference 实现（container_test.dart 作为模板） | ~25 个 case | 2-3 小时 |
| **Phase 1 — P0 widgets** | text、buttons、image、children_container 的 widget test | ~40 个 case | 3-4 小时 |
| **Phase 2 — P1 表单** | check_box、radio 的 widget test | ~15 个 case | 1-2 小时 |
| **Phase 3 — P2 媒体/布局** | icon、svg、wrap、sized_box、positioned、padding、shader_mask 的 widget test | ~30 个 case | 2-3 小时 |
| **Phase 4 — P3 列表** | list_view（含 grid_view 和 builder/dataBuilder 终止器） | ~10 个 case | 1-2 小时 |
| **Phase 5 — Golden baseline** | 13 个 widget 的 golden 测试 + 拍第一批 baseline（≤75 张 PNG）+ commit | ~50 个 golden case | 2-3 小时 |

**总计**：~170 个 widget test case + ~50 个 golden case，**~13-17 小时**，分 6 个 PR/commit。

**关键判定点**：
- 每个 Phase 结束都跑 `flutter analyze lib/ test/` + `flutter test test/`，全绿才进下一阶段
- Phase 0 的模板（container_test.dart）走通后再大批量复制，避免改了 30 个文件才发现模板有问题
- Phase 5 的 golden baseline 放**最后** —— 若 Phase 1-4 期间发现 widget 有 bug 要改 builder 内部，golden 就要重拍，放最后避免无效重拍

---

## 6. 风险与开放问题

| 风险 | 缓解 |
|---|---|
| Phase 0 模板设计不当，Phase 1-4 写到一半才发现 axis_matchers 缺函数 | Phase 0 一次写完所有 13 个 matcher，container_test.dart 跑 12+ axis 验证模板覆盖度 |
| Golden test 在 macOS 上拍、其他人在 Linux 上跑会失败 | 文件头 `@Tags(['golden'])` + `dart_test.yaml` 默认跳过；约定 golden 只在 macOS 本地维护，CI 永不跑 |
| axis_matchers 参数化过度，单 widget 的特殊行为塞不下 | 模板四段式中「默认行为」和「终止器」段允许 `testWidgets` 直接断言，不强求经过 matcher |
| Phase 5 拍出来的 PNG 太大撑爆 git 仓库 | 控制 ≤75 张、单张 ≤50KB（widget 渲染区域小）；总量预估 ≤3MB，可接受 |
| ImageLoader 重构后还有未知 bug | image_test.dart 的「回归」段专门加 `_type=typeNormal/typeCircle/typeRoundCorner/typeBlur` 四个构造的 baseline 测试 |

---

## 7. 验收标准

本 spec 落地完成的判定（按 Phase 累积）：

- ✅ Phase 0：`test/_shared/` 三文件 + `dart_test.yaml` 入 git，container_test.dart 跑通且 12+ axis matcher 都被调用过一次
- ✅ Phase 1-4：13 个 widget test 文件全绿，`flutter test test/` 在 CI ubuntu-latest 上 ≤90 秒
- ✅ Phase 5：13 个 golden test 文件 + ≤75 张 PNG baseline 入 git，本地 `flutter test test/widgets_golden/ --tags golden` 全绿
- ✅ `flutter analyze lib/ test/` 仍是 `No issues found`
- ✅ CI workflow 修改通过（`test` job 单一脚本不变，仅依赖 `dart_test.yaml`）

---

## 8. 后续 spec 路线

本 spec 只覆盖**测试**这条线。`先测试后文档` 路线下的下一轮 spec 包括：

- **doc/patterns/ 补全**：常用场景的 cheat sheet（响应式布局、表单、列表、动画前置等）
- **README 重写**：v2.0 后的 SizeAdapter 接入示例 + v1.x → v2.x 迁移指南
- **input widget 重设计或淘汰决策**：根据用户反馈决定方向
- **Plugin 升级方向**：v2.1+ 新增哪些 widget/preset、API 痛点收集（这是上一轮 brainstorm 抛出来但用户选「先质量后扩展」的那条线）

---

*End of spec.*
