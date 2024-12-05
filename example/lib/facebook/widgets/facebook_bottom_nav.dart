import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookBottomNav extends StatelessWidget {
  const FacebookBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return container.white.borderT1.borderGrey200.h56.child(
      row.spaceEvenly.children([
        _buildNavItem(Icons.home, true),
        _buildNavItem(Icons.ondemand_video_outlined, false),
        _buildNavItem(Icons.store_outlined, false),
        _buildNavItem(Icons.groups_outlined, false),
        _buildNavItem(Icons.notifications_outlined, false),
        _buildNavItem(Icons.menu, false),
      ]),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return icon.icon.s28.color(isSelected ? Colors.blue : Colors.grey[600]).mk;
  }
}
