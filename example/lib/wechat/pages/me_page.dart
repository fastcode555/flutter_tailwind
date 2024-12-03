import 'package:example/wechat/widgets/me_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Me'.text.bold.f18.mk,
        actions: [
          Icons.settings_outlined.icon.s24.iconClick(
            onTap: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Profile header
          container.white.p16.child(
            Row(
              children: [
                'https://randomuser.me/api/portraits/men/1.jpg'.image.circle.s70.mk,
                w16,
                column.crossStart.expanded.children([
                  'John Doe'.text.bold.f18.mk,
                  h8,
                  'WeChat ID: johndoe'.text.grey.f14.mk,
                ]),
                Icons.qr_code.icon.grey.s24.mk,
                w8,
                Icons.chevron_right.icon.grey.s24.mk,
              ],
            ),
          ),
          h12,
          // Services section
          column.children([
            MeSectionItem(
              icon: Icons.payment.icon.orange.s24.mk,
              title: 'Pay',
              onTap: () {},
            ),
            MeSectionItem(
              icon: Icons.favorite.icon.red.s24.mk,
              title: 'Favorites',
              onTap: () {},
            ),
          ]),
          h12,
          // Settings section
          column.children([
            MeSectionItem(
              icon: Icons.photo_album.icon.blue.s24.mk,
              title: 'Posts',
              onTap: () {},
            ),
            MeSectionItem(
              icon: Icons.credit_card.icon.green.s24.mk,
              title: 'Cards & Offers',
              onTap: () {},
            ),
            MeSectionItem(
              icon: Icons.emoji_emotions.icon.yellow.s24.mk,
              title: 'Sticker Gallery',
              onTap: () {},
            ),
          ]),
        ],
      ),
    );
  }
}
