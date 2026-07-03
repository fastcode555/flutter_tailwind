# Copilot / AI instructions — flutter_tailwind

This is a **Flutter package** (a TailwindCSS-style chained-API UI library), not an app. Library code is in `lib/`; runnable demos are in `example/`.

## ⭐ Before writing any `flutter_tailwind` UI code, read `doc/AI_REFERENCE.md`

The library's public surface is a chained DSL, e.g. `'Hello'.text.red.f16.bold.mk`, `container.p16.rounded8.child(w)`, `row.spacing16.children([...])`. Every styling token is a **predefined getter** — you may only use tokens that exist. **Do not invent a token by pattern** (e.g. `.w73`, `.p13`, `.maxLine(2)` may not exist); when a value isn't in the predefined set, use the parameterized fallback method (`.w(73)`, `.maxLines(2)`).

The **single authoritative API cheat-sheet is [`doc/AI_REFERENCE.md`](../doc/AI_REFERENCE.md)**. It contains:
- exact token vocabulary with numeric rules (which `wN`/`pN`/`fN`/… actually exist),
- the entry-point → terminator map (`.mk` vs `.child(w)` vs `.children([...])` vs `.click(...)` vs `.builder(...)` — the most common mistake),
- the builder → supported-style-axis matrix.

`README.md`, `guide.md`, and `.cursor/rules/*` are human-oriented and may be stale. When any of them conflicts with `doc/AI_REFERENCE.md` or the source, **the source wins, then `doc/AI_REFERENCE.md`**.

## A few hard rules (full detail in the reference)

- Row/Column/Wrap already mix in size/padding/color/spacing — **do not wrap them in a `container`** just to set background/padding/size.
- Prefer a predefined token over its parameterized form (`.p16`, not `.p(16)`).
- For uniform gaps between children use `.spacing16` on the parent, not manual `h16`/`w8` spacers.
- There is **no `build_runner`** in this package; `.g.dart` files are hand-written `part` files.
- Run `flutter analyze` before considering UI code done.
