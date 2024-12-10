import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class OutlineNavigator extends StatefulWidget {
  final String markdown;
  final ValueChanged<int> onHeadingSelected;
  final ScrollController scrollController;

  const OutlineNavigator({
    required this.markdown,
    required this.onHeadingSelected,
    required this.scrollController,
    super.key,
  });

  @override
  State<OutlineNavigator> createState() => _OutlineNavigatorState();
}

class _OutlineNavigatorState extends State<OutlineNavigator> {
  @override
  Widget build(BuildContext context) {
    final headings = _parseHeadings(widget.markdown);

    return container.white.rounded8.p16.cardShadow.child(
      column.children([
        // 标题
        row.spaceBetween.children([
          '大纲'.text.f16.bold.mk,
          IconButton(
            icon: Icons.refresh.icon.grey600.s20.mk,
            onPressed: () => setState(() {}),
          ),
        ]),

        h16,

        // 大纲列表
        Expanded(
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: headings.length,
            itemBuilder: (context, index) {
              final heading = headings[index];
              return container.pl((heading.level - 1) * 16.0).child(
                    TextButton(
                      onPressed: () => widget.onHeadingSelected(heading.offset),
                      child: row.children([
                        // 标题图标
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: Colors.grey[400],
                        ),
                        // 标题文本
                        Expanded(
                          child: heading.text.text.f14.color(Colors.grey[700]).ellipsis.mk,
                        ),
                      ]),
                    ),
                  );
            },
          ),
        ),
      ]),
    );
  }

  List<Heading> _parseHeadings(String text) {
    final headings = <Heading>[];
    var offset = 0;

    for (final line in text.split('\n')) {
      final match = RegExp(r'^(#{1,6})\s+(.+)$').firstMatch(line);
      if (match != null) {
        headings.add(Heading(
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

class Heading {
  final int level;
  final String text;
  final int offset;

  Heading({
    required this.level,
    required this.text,
    required this.offset,
  });
}
