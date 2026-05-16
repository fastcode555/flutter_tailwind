# Spacing: gap between children

Use the `spacing` property on `Row`, `Column`, `Wrap`, `GridView` etc. to set a uniform gap between children. This replaces inserting manual `h16` / `w8` spacer widgets between every pair.

## Two ways to set spacing

### Predefined shortcuts (preferred)

```dart
column.spacing16.children([
  _buildHeader(),
  _buildBody(),
  _buildFooter(),
])
// → 16-pixel gap between each child
```

Predefined values (from `lib/src/base/spacing_builder.dart`): every even number from 2 to 32:

```
spacing2, spacing4, spacing6, spacing8, spacing10, spacing12,
spacing14, spacing16, spacing18, spacing20, spacing22, spacing24,
spacing26, spacing28, spacing30, spacing32
```

### Parameterized form (for non-predefined values)

```dart
column.spacing(13).children([...])    // 13-pixel gap — no spacing13 exists
column.spacing(40).children([...])    // 40-pixel gap — beyond the predefined range
```

**Convention:** use the shortcut when a predefined value matches. The parameterized form is the escape hatch.

## When to use `spacing` vs manual spacers

`spacing` is only correct when every gap between children is identical. If the gaps differ for visual hierarchy reasons, **keep manual spacers**:

```dart
// ✅ Uniform gaps — use spacing
column.spacing16.children([
  _buildCard1(),
  _buildCard2(),
  _buildCard3(),
])

// ✅ Intentionally varied gaps — use manual spacers
column.children([
  'Main Title'.text.f24.bold.mk,
  h8,                                  // tight, title-to-subtitle
  'Subtitle'.text.f16.grey.mk,
  h32,                                 // wide, group separator
  'Section content...'.text.mk,
])

// ❌ Forcing uniform spacing where it harms the design
column.spacing16.children([
  'Main Title'.text.f24.bold.mk,       // wants 8 to subtitle, not 16
  'Subtitle'.text.f16.grey.mk,         // wants 32 to next group, not 16
  'Section content...'.text.mk,
])
```

The design principle: **visual hierarchy beats uniform spacing**.

## `spacing` vs `separated` on lists

`ListView` has a separate `separated*` API for the *same idea*, kept distinct because list separators can be widgets, not just gaps:

```dart
// Uniform 16-pixel separator (a SizedBox internally)
listview.separated16.builder(10, itemBuilder)

// Custom separator widget
listview.separated(const Divider(color: Colors.red)).builder(10, itemBuilder)
```

`separated*` predefined values follow the same convention as `spacing*` (every even number from 2 to 50, see `lib/src/widgets/container/list_view.g.dart`).

`GridView` uses `spacing*` for both main and cross axes, plus `mainSpacing*` / `crossSpacing*` when you need them split.

## Where `spacing` works

| Widget | API |
|---|---|
| `Row` | `row.spacing16.children([...])` |
| `Column` | `column.spacing16.children([...])` |
| `Wrap` | `wrap.spacing8.runSpacing8.children([...])` |
| `GridView` | `gridview.spacing16.crossAxisCount2.builder(...)` — also `mainSpacing*` / `crossSpacing*` |
| `ListView` | use `separated*` instead — see above |

## Common patterns

```dart
// Form with consistent vertical rhythm
column.spacing20.p16.children([
  _buildEmailField(),
  _buildPasswordField(),
  _buildSubmitButton(),
])

// Card grid
gridview.crossAxisCount2.spacing12.builder(items.length, (_, i) {
  return _buildCard(items[i]);
})

// Toolbar with uniform horizontal gaps
row.spacing8.children([
  _buildBackButton(),
  'Title'.text.f18.expanded.mk,
  _buildShareButton(),
  _buildMenuButton(),
])
```
