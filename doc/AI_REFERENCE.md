# flutter_tailwind — AI Reference (单一权威 API 速查)

> **本文件是给 AI / LLM 看的唯一权威 API 速查。** 它由 `lib/` 源码提取，规则可判定、词表精确、示例可跑。
> 写业务代码时只看本文件。`README.md` / `guide.md` / `.cursor/rules/*` 仅供人类阅读，可能过时——**它们与本文件冲突时，以本文件为准。**
>
> **The #1 rule for an AI using this library:** every styling token is a *predefined getter*. You may ONLY use tokens that this file lists or that match a stated numeric rule. **Never invent a token by pattern** (e.g. `.w73`, `.p13`, `.rounded5` may or may not exist — check the rule). When a value isn't in the predefined set, use the **parameterized fallback** method (`.w(73)`, `.p(13)`, `.rounded(5)`).

---

## 1. The shape of every call

```
<entry> .<style tokens…> .<terminator>
```

- **entry** — how a chain starts (a top-level getter like `container`, or a String/extension getter like `'Hello'.text`, `'url'.image`).
- **style tokens** — zero or more chained getters/methods that mutate the builder (`.red`, `.f16`, `.p16`, `.rounded8` …). Order does not matter.
- **terminator** — the call that materializes the `Widget`. **Choosing the wrong terminator is the most common AI error.** See §3.

Verified examples (copied from `example/lib`, these compile):

```dart
'Hello'.text.red.f16.bold.mk
'订单详情'.text.grey600.f12.mk
container.black54.p16.rounded8.child(someWidget)
row.center.spacing16.children([a, b, c])
column.center.expanded.children([a, b])
'https://x/y.png'.image.border2.borderBrown.circle.s100.mk
Icons.add.icon.amber.s24.mk
'提交'.elevatedButton.blue.textWhite.click(onTap: () {})
listview.divider.builder(count, (ctx, i) => row.children([...]))
gridview.crossAxisCount2.ratio80.p16.builder(count, (ctx, i) => card)
wrap.spacing16.runSpacing16.children([chipA, chipB])
```

---

## 2. Entry points (how a chain starts)

| Entry | Type | Produces |
|---|---|---|
| `container` | top-level getter | box / decoration |
| `row` `column` | top-level getter | Flex (mixes in the full container axis set) |
| `stack` | top-level getter | Stack |
| `wrap` | top-level getter | Wrap |
| `listview` | top-level getter | ListView (**lowercase**, not `listView`) |
| `gridview` | top-level getter | GridView (**lowercase**, not `gridView`) |
| `positioned` | top-level getter | Positioned (use inside a `stack`) |
| `sizedBox` | top-level getter | SizedBox |
| `padding` | top-level getter | Padding |
| `checkBox` | top-level getter | Checkbox |
| `radio` | top-level getter | Radio |
| `shaderMask` | top-level getter | ShaderMask |
| `linearGradient` | top-level getter | a `LinearGradient` value |
| `ts` | top-level getter | a `TextStyle` value (via `TextStyleBuilder`) |
| `bd` | top-level getter | a `BoxDecoration` value |
| `'str'.text` | String getter | Text |
| `textRich` | **top-level getter** (NOT `'str'.textRich`) | RichText — text comes from the spans |
| `'str'.strokeText` | String getter | stroked Text |
| `'url'.image` | String getter | network/file Image |
| `'assetPath'.asset` | String getter | asset Image |
| `IconData.icon` | extension getter | Icon |
| `'str'.elevatedButton` | String getter | ElevatedButton |
| `'str'.textButton` | String getter | TextButton |
| `'str'.outlinedButton` | String getter | OutlinedButton |
| `iconButton` | top-level getter | IconButton |
| `'assetPath'.svg` | String getter | SVG |
| `'hint'.input` / see `input.dart` | — | TextField |

---

## 3. Terminators (pick by entry — getting this wrong fails to compile)

| Entry / builder | Valid terminator(s) | Notes |
|---|---|---|
| `container`, `sizedBox` | `.mk` **or** `.child(w)` | `.mk` if no child; `.child(w)` to wrap one widget |
| `'s'.text`, `'url'.image`, `.asset`, `.icon`, `.svg`, `.strokeText` | `.mk` | no child |
| `ts`, `bd`, `linearGradient` | `.mk` | returns a *value* (TextStyle/BoxDecoration/Gradient), not a Widget |
| `row`, `column`, `stack`, `wrap` | `.children([...])` | **never `.mk`** — these take a list |
| `'s'.textRich` | `.children([span, …])` | takes `InlineSpan`s |
| `positioned`, `shaderMask`, `padding` | `.child(w)` | single child, **no `.mk`** |
| `'s'.elevatedButton` / `textButton` / `outlinedButton`, `iconButton` | `.click(onTap: ...)` | terminator IS the tap handler |
| `checkBox` | `.onChanged(initial, (v) {})` | |
| `radio` | `.onChanged(initial, group, (v) {})` | 3 args |
| `listview`, `gridview` | `.builder(count, (ctx,i)=>w)` **or** `.dataBuilder<T>(list, (ctx,i,item)=>w)` | ⚠️ `dataBuilder` callback is `(context, index, item)` — **index before item** |

**Wrapping helpers** (available on any `.mk`-producing chain, applied *after* `.mk`, or instead of `.mk` on a `MkBuilder`):
`.click(onTap:)` → wraps in `GestureDetector` (debounced) · `.iconClick(onTap:)` → `IconButton` · `.inkWellClick(onTap:)` → `InkWell`.
Example: `'edit'.text.blue.f14.mk.click(onTap: () {})` — note `.mk` then `.click`. Any plain `Widget` also gets `.click` via an extension.

---

## 4. Which builder supports which style axis

Only tokens from an axis the builder mixes in are valid. (Extracted from `with` clauses in `lib/src/widgets/`.)

| Builder | color | textColor | borderColor | size | font | padding | margin | radius | borderWidth | shadow | align | opacity | expanded | spacing |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| Container | ✅ | | ✅ | ✅ | | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | |
| Row / Column | ✅ | | | ✅ | | ✅ | | | | | | | ✅ | ✅ |
| Stack | ✅ | | | ✅ | | ✅ | | | | | | | | |
| Wrap | ✅ | | | | | ✅ | | | | | | | ✅ | ✅ |
| Text / strokeText | ✅ | ✅ | | | ✅ | ✅ | | | | | (align) | ✅ | ✅ | |
| Image | ✅ | | ✅ | ✅ | | ✅ | | ✅ | ✅ | ✅ | ✅ | ✅ | | |
| Icon | ✅ | | | ✅ | | ✅ | | | | | | ✅ | | |
| Button (all 4) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | | | ✅ | ✅ | |
| CheckBox / Radio | ✅ | | ✅ | ✅ | | ✅ | | ✅ | | ✅ | | | | |
| ListView | | | | ✅ | | ✅ | | | | | | | ✅ | |
| GridView | | | | | | ✅ | | | | | | | ✅ | ✅ |
| SizedBox | | | | ✅ | | ✅ | | | | | | | | |

> **Row/Column already include size/padding/color/expanded/spacing.** Do **not** wrap a Row/Column in a `container` just to set background, padding, or size — set them on the Row/Column directly. Same for `sizedBox`.

---

## 5. Token vocabulary (exact rules — do NOT extrapolate beyond these)

For any value not covered by a rule below, use the parameterized method shown in the "fallback" column.

### 5.1 Size — `w` (width), `h` (height), `s` (square w==h)
Valid `N` for `wN` / `hN` / `sN`:
- integers **1–20** (every int)
- even numbers **22–98** (step 2)
- multiples of 5 **55, 65, 75, 85, 95** (the odd-5s) and **100, 105, … 400** (step 5)

Fallback: `.w(123)` `.h(89)` `.s(167)`. Min/max: `.maxW(n)` `.minW(n)` `.maxH(n)` `.minH(n)`.

Screen-relative: `wFull` `hFull` `sFull` (full screen W/H/min-dim) · `wInfinity` `hInfinity` `sInfinity` · `wFull5 … wFull95` / `hFull5 … hFull95` / `sFull5 … sFull95` (percentages, **step 5**) · `sScreenW` `sScreenH`.
⚠️ `wFull/hFull/sScreen*` require `Tailwind.instance.init(context)` to have run, else they assert.

### 5.2 Padding — `p` + side
- `p` (all), `pl` `pr` `pt` `pb` (left/right/top/bottom), `ph` (horizontal), `pv` (vertical)
- Valid `N`: **0–100, even (step 2)** — e.g. `p0 p2 p4 … p100`. Fallback: `.p(13)` `.pl(17.5)` etc.

### 5.3 Margin — `m` + side
- `m` `ml` `mr` `mt` `mb` `mh` `mv`
- Valid `N`: **2–100, even (step 2)** — note **no `m0`**. Fallback: `.m(13)`.

### 5.4 Border radius — `rounded`
- `roundedN` (all corners): integers **1–10**, then even **12–50** (step 2). (`rounded25` also exists.)
- Per-corner `roundedTl` `roundedTr` `roundedBl` `roundedBr`, per-side `roundedT` `roundedB` `roundedL` `roundedR`: integers **1–50** (every int).
- Fallback: `.rounded(n)`. There is also `circle` (full round) on image/checkbox.

### 5.5 Border width — `border`
- `borderN`: integers **0–10**, then even **12–50** (step 2).
- Per-side `borderT` `borderR` `borderB` `borderL`: bare (default width) or with `N` = integers **0–40**.
- Border **color** is a separate axis — see §5.8 (`borderRed`, `borderBlue100`, …).

### 5.6 Font size — `f`
- `fN`: integers **5–40**, then even **42–60** (step 2), then multiples of 5 **65–100**. (Note: `f39` is a known typo that maps to 38.)
- Fallback: `.f(17.5)` or `.font(17.5)`.

### 5.7 Spacing (Row/Column/Wrap/GridView gaps)
- `spacingN` `runSpacingN` `mainSpacingN` `crossSpacingN`: even **2–32** (step 2). Fallback: `.spacing(25)`.
- **Prefer `.spacing16` on the parent over manual `h16`/`w8` spacers between children** when gaps are uniform.

### 5.8 Colors — `<name>` / `text<Name>` / `border<Name>`
Three prefixes select the target:
- **fill** (no prefix): `red`, `blue100`, `grey600` — the builder's primary color. **On a Text/Icon builder the bare color IS the glyph color** (`'hi'.text.red.mk` → red text); on Container it's the background. The `textX` prefix exists for builders where bare color means something else — on a plain Text it's redundant with the bare form.
- **text**: `textRed`, `textBlue100`, `textWhite` — text color.
- **border**: `borderRed`, `borderBlue100` — border color (pair with a `borderN` width).

Naming rule = Flutter Material colors:
- **Base names (23):** `amber black blue blueGrey brown cyan deepOrange deepPurple green grey indigo lightBlue lightGreen lime orange pink primary purple red teal transparent white yellow`
- **Shades:** append `50`, `100`, `200`, … `900` (e.g. `red300`, `textGrey600`). Bare name = the default shade.
- **Accent variants:** `<name>Accent` + `100/200/400/700`. Only these 9 base names have accents: **amber, blue, green, indigo, orange, purple, red, teal, yellow** — e.g. `redAccent`, `blueAccent200`. (Others like `pink`/`deepOrange` have NO accent getter.)
- **Black/White alpha:** `black12 black26 black38 black45 black54 black87`; `white12 white30 white38 white54 white60 white70` (and `text`/`border` variants).
- `primary` / `textPrimary` use `Tailwind.instance.primaryColor`.
- Fallback for any custom color: `.color(myColor)` (fill), `.textColor(c)`, `.borderColor(c)`.

### 5.9 Text weight & style (Text/RichText/strokeText/Button)
- Named weights: `thin extralight light normal medium semibold bold extrabold fontBlack`
- Numeric weights: `w100 w200 w300 w400 w500 w600 w700 w800 w900`
- Align: `center left right justify start end` · direction `ltr rtl` · baseline `alphabetic ideographic`
- Style / decoration: `italic` · `underline` `lineThrough` `overline`
- **Max lines:** preset getters `maxLine1` `maxLine2` … `maxLine9` (**no-arg getters**), or the method `.maxLines(n)`. ⚠️ There is **no `.maxLine(n)`** method — that name does not exist. Use `.maxLine2` or `.maxLines(2)`.

### 5.10 Alignment (Container/Image)
Getters: `topLeft topCenter topRight centerLeft center centerRight bottomLeft bottomCenter bottomRight`.
⚠️ **Known type quirk:** every corner getter *except* `center` returns a nullable-typed builder, so **you cannot chain anything after it** (`container.topLeft.mk` does NOT compile). Use the **method form** `.align(Alignment.topLeft)` instead — it chains cleanly. `center` is safe as a getter.

### 5.11 Opacity
`opacity5 opacity10 … opacity95` (step 5). Fallback: `.opacity(0.42)`.

### 5.12 Layout flags
`expanded` (wrap in Expanded), `center` (center alignment). Row/Column axis control: main-axis `spaceEvenly` `spaceBetween` `spaceAround` `center` `end` `start`; cross-axis `crossStart` `crossEnd` (default is center). (see `LinearFeature`.)

### 5.13 Shadow (Container / Image / CheckBox / Radio)
Preset getters only — **no numeric scale**: `cardShadow` `shadowSm` `shadowMd` `shadowLg` `shadowXl`. Fallback for custom: `.shadow([BoxShadow(...)])`.

### 5.14 Image fit (Image / Svg — how the picture fills its box)
`fill` `contain` `cover` `fitWidth` `fitHeight` `none` `scaleDown` (map 1:1 to Flutter `BoxFit`). For a photo in a fixed square, `cover` is the usual choice: `'url'.image.s120.cover.rounded8.mk`.

---

## 6. Anti-patterns (do this, not that)

| ❌ Don't | ✅ Do | Why |
|---|---|---|
| `container.child(row.children([...]))` to set bg/padding on a row | `row.white.p16.children([...])` | Row mixes in color/padding/size directly |
| `'x'.text.f17.mk` (guessing f17 exists) | `'x'.text.f16.mk` or `'x'.text.f(17).mk` | f16 is preset; 17 isn't — use the rule or the fallback |
| `.w(50)` | `.w50` | a preset exists → prefer it |
| `row.children([a, w16, b, w16, c])` (manual equal gaps) | `row.spacing16.children([a, b, c])` | use spacing for uniform gaps |
| `row.mk` | `row.children([...])` | Row/Column terminate with `.children`, never `.mk` |
| `listView` / `gridView` | `listview` / `gridview` | entry getters are lowercase |
| `column.children([singleChild])` | the child directly | strip single-child wrappers |
| `Container(color: …, child: …)` (raw Flutter) | `container.red.child(…)` | use the chained API for consistency |

---

## 7. Setup the AI must not forget

```dart
// Inside MaterialApp (e.g. MaterialApp.builder or home build), once:
Tailwind.instance.init(context);            // populates screenW/H + primaryColor
// Optional: custom scaling (default = no scaling)
Tailwind.instance.configSizeAdapter(MyAdapter());
```
Without `init`, the `wFull/hFull/sScreen*` family asserts. Plain sizes (`w100`, `p16`) work without it.

---

## 8. Keeping this file honest (for maintainers)

This file is verified, not vibes. Two fixtures under `example/lib/` use **only** the tokens/terminators promised here, each traceable to a section above:
- `ai_reference_smoke_test.dart` — broad coverage: every terminator type + one token per axis.
- `ai_blind_test.dart` — a realistic screen written from this doc alone.

Run **`tool/verify_ai_reference.sh`** after changing presets in `lib/` or editing this file. It runs `flutter analyze` on both fixtures; if a documented token is renamed/removed, it fails. This is the automated form of the blind test — it is what would have caught the `.maxLine(n)`, `dataBuilder` arg-order, and `topLeft`-nullable bugs before they shipped.

When you add/rename a preset: update the relevant §5 rule here **and** add a line exercising it to the smoke test.

*Precedence: if this file disagrees with the code, the code wins — fix this file (and the fixture).*
