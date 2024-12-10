import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ContactListItem extends StatelessWidget {
  final String? avatar;
  final Widget? icon;
  final String name;
  final VoidCallback onTap;

  const ContactListItem({
    required this.name,
    required this.onTap,
    super.key,
    this.avatar,
    this.icon,
  }) : assert(avatar != null || icon != null);

  @override
  Widget build(BuildContext context) {
    return padding.p16
        .child(
          row.children(
            [
              if (avatar != null)
                avatar!.image.circle.s40.mk
              else if (icon != null)
                container.s40.circle.grey100.center.child(icon!),
              w12,
              name.text.f16.mk,
            ],
          ),
        )
        .click(onTap: onTap);
  }
}
