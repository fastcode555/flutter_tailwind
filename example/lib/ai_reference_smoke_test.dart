// DOC-COVERAGE SMOKE TEST for doc/AI_REFERENCE.md
//
// Purpose: institutionalize the "blind test". Every construct below uses ONLY
// tokens/terminators promised by doc/AI_REFERENCE.md. If a documented token is
// ever renamed or removed in lib/, `flutter analyze` on this file fails — which
// is exactly how the `.maxLine(n)` doc bug would have been caught automatically.
//
// Run:  tool/verify_ai_reference.sh   (or: cd example && flutter analyze lib/ai_reference_smoke_test.dart)
//
// When you add/rename presets, update doc/AI_REFERENCE.md AND add a line here.
// Keep every token traceable to a doc section (comments cite §).
//
// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class AiReferenceSmokeTest {
  // §3 terminator: container -> .mk (no child)
  Widget containerMk() => container.white.p16.rounded12.cardShadow.mk;

  // §3 terminator: container -> .child(w); §4 Container axes: color/size/
  // padding/margin/radius/borderWidth/borderColor/shadow/align/opacity
  Widget containerChild() => container.grey100
      .s120 // §5.1 size
      .p16 // §5.2 padding
      .m8 // §5.3 margin
      .rounded12 // §5.4 radius
      .border2 // §5.5 border width
      .borderRed // §5.8 border color
      .shadowMd // §5.13 shadow
      .opacity90 // §5.11 opacity
      // §5.10 alignment: use the .align(...) METHOD (corner getters like
      // .topLeft return a nullable-typed builder and break the chain).
      .align(Alignment.topLeft)
      .child(const SizedBox());

  // §3 terminator: text -> .mk; §4 Text axes + §5.9 weight/decoration/maxlines
  Widget textMk() => 'Title'.text
      .grey800 // §5.8 fill == glyph color on Text
      .textRed // §5.8 explicit text color prefix
      .f16 // §5.6 font size
      .bold // §5.9 named weight
      .w600 // §5.9 numeric weight
      .italic // §5.9 style
      .underline // §5.9 decoration
      .center // §5.9 align
      .maxLine2 // §5.9 max-lines preset (NOT .maxLine(n))
      .mk;

  // §5.9 max-lines via method form
  Widget textMaxLinesMethod() => 'body'.text.grey600.f12.maxLines(3).mk;

  // §3: image -> .mk; §5.14 fit; §4 Image axes
  Widget imageMk() => 'https://picsum.photos/200'.image
      .s120 // §5.1
      .cover // §5.14 fit
      .rounded8 // §5.4
      .border1 // §5.5
      .borderGrey300 // §5.8
      .opacity80 // §5.11
      .mk;

  // §2 asset entry; §5.14 fit
  Widget assetMk() => 'assets/logo.png'.asset.s50.contain.mk;

  // §3: icon -> .mk; §4 Icon axes (color/size/padding/opacity)
  Widget iconMk() => Icons.add.icon.amber.s24.p4.opacity90.mk;

  // §3: row -> .children([]); §5.12 layout flags; §5.7 spacing
  Widget rowChildren() => row.spaceBetween.center.spacing16.children([
        'a'.text.f14.mk,
        'b'.text.f14.mk,
      ]);

  // §3: column -> .children([]); crossStart + expanded + spacing
  Widget columnChildren() => column.crossStart.expanded.spacing12.children([
        'x'.text.f14.mk,
        'y'.text.f14.mk,
      ]);

  // §3: wrap -> .children([]); §5.7 spacing + runSpacing
  Widget wrapChildren() => wrap.spacing16.runSpacing16.children([
        'chip'.text.f12.mk,
      ]);

  // §3: stack -> .children([]); + positioned -> .child(w)
  Widget stackChildren() => stack.s120.children([
        positioned.child(const SizedBox()),
      ]);

  // §3: sizedBox -> .mk / .child; §4 SizedBox axes (size/padding)
  Widget sizedBoxMk() => sizedBox.w200.h100.mk;

  // §3: padding entry -> .child(w)
  Widget paddingChild() => padding.p16.child(const SizedBox());

  // §3: buttons -> .click(onTap:)  (terminator IS the tap handler)
  Widget elevatedBtn() =>
      'Add'.elevatedButton.blue.textWhite.f14.rounded8.p8.click(onTap: () {});
  Widget textBtn() => 'More'.textButton.blue.click(onTap: () {});
  Widget outlinedBtn() =>
      'Edit'.outlinedButton.blue.border1.borderBlue.click(onTap: () {});

  // §3 wrapping helper: .mk then .click / .iconClick / .inkWellClick
  Widget mkThenClick() => 'edit'.text.blue.f14.mk.click(onTap: () {});

  // §3: listview -> .builder / .dataBuilder
  Widget listBuilder() => listview.divider.neverScroll.shrinkWrap.builder(
        3,
        (ctx, i) => 'row $i'.text.f14.mk,
      );
  // NOTE callback order is (context, index, item) — index BEFORE item.
  Widget listDataBuilder() => listview.expanded.dataBuilder<String>(
        const ['a', 'b'],
        (ctx, i, item) => item.text.f14.mk,
      );

  // §3: gridview -> .builder; §5.7 spacing on grid
  Widget gridBuilder() =>
      gridview.crossAxisCount2.ratio80.spacing16.p16.builder(
        4,
        (ctx, i) => container.grey100.rounded8.mk,
      );

  // §3: checkBox -> .onChanged(initial, fn)
  Widget checkBoxOnChanged() =>
      checkBox.s24.blue.onChanged(false, (v) {});

  // §3: radio -> .onChanged(initial, group, fn)  (3 args)
  Widget radioOnChanged() =>
      radio.s24.blue.onChanged<int>(0, 1, (v) {});

  // §2 value builders: ts -> TextStyle, linearGradient -> LinearGradient
  TextStyle textStyle() => ts.grey800.f16.bold.mk;
  // textRich is a TOP-LEVEL getter (not 'str'.textRich); text comes from spans.
  Widget richText() => textRich.f14.grey800.children(const []);
}
