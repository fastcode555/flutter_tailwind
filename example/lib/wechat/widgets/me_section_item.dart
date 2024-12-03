import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class MeSectionItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const MeSectionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return container.p16.white
        .child(
          row.children(
            [
              icon,
              w16,
              title.text.f16.expanded.mk,
              if (trailing != null) trailing!,
              Icons.chevron_right.icon.grey.s20.mk,
            ],
          ),
        )
        .click(onTap: onTap);
  }
}
