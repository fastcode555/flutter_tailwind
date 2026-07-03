import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Blind-test product card built purely from the flutter_tailwind chained API
/// as described in doc/AI_REFERENCE.md.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Outer rounded container: padding + background color.
    // Container is the only builder in the matrix that supports `radius`,
    // so it (not the Column) owns the rounded background.
    return container.white.p16.rounded12.cardShadow.child(
      // Vertical stack of card sections with a uniform gap via `spacing12`
      // (Column mixes in `spacing`, so no manual h-spacer widgets).
      column.crossStart.spacing12.children([
        // Square network image with rounded corners.
        // Image supports both `size` and `radius` per the matrix.
        'https://picsum.photos/300/300'.image.s120.cover.rounded8.mk,

        // Product title: bold, ~16pt, dark grey.
        // For Text builders the bare color name sets the text color
        // (per the doc's `'Hello'.text.red...` example).
        'Wireless Headphones'.text.grey800.f16.bold.mk,

        // Short description: smaller, grey, capped at 2 lines via the
        // `maxLine2` preset getter (doc §5.9).
        'Comfortable over-ear headphones with active noise cancellation and a 30-hour battery life.'
            .text
            .grey600
            .f12
            .maxLine2
            .mk,

        // Price (left) + Add button (right) on one row.
        row.spaceBetween.children([
          // Price: colored + larger font.
          r'$129.99'.text.red.f20.bold.mk,

          // Elevated button wired to an onTap via its `.click` terminator.
          'Add'.elevatedButton.blue.textWhite.rounded8.click(onTap: () {
            debugPrint('Add to cart tapped');
          }),
        ]),
      ]),
    );
  }
}
