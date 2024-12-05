import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FacebookAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: 'facebook'.text.blue.f24.bold.mk,
      actions: [
        container.s40.circle.grey100.center.child(
          Icons.search.icon.grey800.s24.mk,
        ).click(onTap: () => AppRoutes.toSearch(context)),
        w8,
        container.s40.circle.grey100.center.child(
          Icons.messenger_outline.icon.grey800.s24.mk,
        ).click(onTap: () => AppRoutes.toChat(context)),
        w16,
      ],
    );
  }
} 