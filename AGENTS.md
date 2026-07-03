# AGENTS.md — flutter_tailwind

Cross-tool instructions for AI coding agents (Codex, Cursor, and others that read `AGENTS.md`).
Claude Code reads `CLAUDE.md`; GitHub Copilot reads `.github/copilot-instructions.md` — all three point here.

## What this repo is

A **Flutter package** (not an app): a TailwindCSS-style chained-API UI library. Library code in `lib/`, demos in `example/`. No `flutter run` at the root; no `build_runner` (the `.g.dart` files are hand-written `part` files).

## ⭐ Before writing any UI code, read `doc/AI_REFERENCE.md`

The API is a chained DSL: `'Hello'.text.red.f16.bold.mk`, `container.p16.rounded8.child(w)`, `row.spacing16.children([...])`. Every styling token is a **predefined getter** — only use tokens that exist. **Never invent a token by pattern** (`.w73`, `.p13`, `.maxLine(2)` may not exist); use the parameterized fallback (`.w(73)`, `.maxLines(2)`) for unlisted values.

**[`doc/AI_REFERENCE.md`](doc/AI_REFERENCE.md) is the single source of truth** for: the exact token vocabulary (with numeric rules), the entry-point → terminator map (`.mk` / `.child` / `.children` / `.click` / `.builder` — the #1 mistake area), and the builder → supported-axis matrix.

`README.md`, `guide.md`, and `.cursor/rules/*` are human-oriented and may be stale. On any conflict: **source code wins, then `doc/AI_REFERENCE.md`.**

## Conventions

- Row/Column/Wrap mix in size/padding/color/spacing — don't wrap them in a `container` just for background/padding/size.
- Prefer predefined tokens over parameterized forms (`.p16`, not `.p(16)`).
- Uniform child gaps → `.spacing16` on the parent, not manual `h16`/`w8` spacers.
- Lints: single quotes, `const` constructors, no `print`. **Run `flutter analyze` before claiming UI code is done.**
