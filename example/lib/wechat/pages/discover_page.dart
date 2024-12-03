import 'package:example/wechat/widgets/discover_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Discover'.text.bold.f18.mk,
      ),
      body: ListView(
        children: [
          DiscoverSectionItem(
            icon: Icons.photo_camera.icon.white.s20.mk,
            iconBgColor: Colors.amber,
            title: 'Moments',
            onTap: () {},
          ),
          h12,
          column.children([
            DiscoverSectionItem(
              icon: Icons.qr_code_scanner.icon.white.s20.mk,
              iconBgColor: Colors.blue,
              title: 'Scan',
              onTap: () {},
            ),
            DiscoverSectionItem(
              icon: Icons.handshake_outlined.icon.white.s20.mk,
              iconBgColor: Colors.blue,
              title: 'Shake',
              onTap: () {},
            ),
          ]),
          h12,
          column.children([
            DiscoverSectionItem(
              icon: Icons.search.icon.white.s20.mk,
              iconBgColor: Colors.green,
              title: 'Search',
              onTap: () {},
            ),
            DiscoverSectionItem(
              icon: Icons.location_on.icon.white.s20.mk,
              iconBgColor: Colors.green,
              title: 'Nearby',
              onTap: () {},
            ),
          ]),
        ],
      ),
    );
  }
}
