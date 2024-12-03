import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class DiscoverSectionItem extends StatelessWidget {
  final Widget icon;
  final Color iconBgColor;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const DiscoverSectionItem({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return container.white
        .child(
          container.p16.child(
            Row(
              children: [
                container.s40.circle.color(iconBgColor).center.child(icon),
                w12,
                title.text.f16.expanded.mk,
                if (trailing != null) trailing!,
                Icons.chevron_right.icon.grey.s20.mk,
              ],
            ),
          ),
        )
        .click(onTap: onTap);
  }
}
