import 'package:example/facebook/pages/facebook_groups_page.dart';
import 'package:example/facebook/pages/facebook_home_page.dart';
import 'package:example/facebook/pages/facebook_marketplace_page.dart';
import 'package:example/facebook/pages/facebook_profile_page.dart';
import 'package:example/facebook/pages/facebook_video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookMainPage extends StatefulWidget {
  const FacebookMainPage({super.key});

  @override
  State<FacebookMainPage> createState() => _FacebookMainPageState();
}

class _FacebookMainPageState extends State<FacebookMainPage> {
  int _currentIndex = 0;

  final _pages = const [
    FacebookHomePage(),
    FacebookVideoPage(),
    FacebookMarketplacePage(),
    FacebookGroupsPage(),
    FacebookProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: container.white.borderT1.borderGrey200.h56.child(
        row.spaceEvenly.children([
          _buildNavItem(Icons.home, 0),
          _buildNavItem(Icons.ondemand_video_outlined, 1),
          _buildNavItem(Icons.store_outlined, 2),
          _buildNavItem(Icons.groups_outlined, 3),
          _buildNavItem(Icons.menu, 4),
        ]),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return icon.icon.s28
        .color(isSelected ? Colors.blue : Colors.grey[600])
        .click(onTap: () => setState(() => _currentIndex = index));
  }
}
