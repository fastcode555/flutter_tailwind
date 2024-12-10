import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class TableOfContents extends StatelessWidget {
  final String markdown;
  final ValueChanged<int> onHeadingSelected;

  const TableOfContents({
    required this.markdown,
    required this.onHeadingSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final headings = _parseHeadings(markdown);

    return container.white.rounded8.p16.cardShadow.child(
      column.crossStart.children([
        '目录'.text.f16.bold.mk,
        h16,
        Expanded(
          child: ListView.builder(
            itemCount: headings.length,
            itemBuilder: (context, index) {
              final heading = headings[index];
              return container.pl((heading.level - 1) * 16.0).child(
                    TextButton(
                      onPressed: () => onHeadingSelected(heading.offset),
                      child: heading.text.text.f14.mk,
                    ),
                  );
            },
          ),
        ),
      ]),
    );
  }

  List<HeadingNode> _parseHeadings(String markdown) {
    final headings = <HeadingNode>[];
    var offset = 0;

    final lines = markdown.split('\n');
    for (final line in lines) {
      final match = RegExp(r'^(#{1,6})\s+(.+)$').firstMatch(line);
      if (match != null) {
        headings.add(HeadingNode(
          level: match.group(1)!.length,
          text: match.group(2)!,
          offset: offset,
        ));
      }
      offset += line.length + 1;
    }

    return headings;
  }
}

class HeadingNode {
  final int level;
  final String text;
  final int offset;

  HeadingNode({
    required this.level,
    required this.text,
    required this.offset,
  });
}
