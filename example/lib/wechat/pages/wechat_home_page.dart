import 'package:example/wechat/pages/chats_page.dart';
import 'package:example/wechat/pages/contacts_page.dart';
import 'package:example/wechat/pages/discover_page.dart';
import 'package:example/wechat/pages/me_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class WeChatHomePage extends StatefulWidget {
  const WeChatHomePage({super.key});

  @override
  State<WeChatHomePage> createState() => _WeChatHomePageState();
}

class _WeChatHomePageState extends State<WeChatHomePage> {
  int _currentIndex = 0;

  final _pages = const [
    ChatsPage(),
    ContactsPage(),
    DiscoverPage(),
    MePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF07C160),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icons.chat_bubble_outline.icon.mk,
            activeIcon: Icons.chat_bubble.icon.mk,
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icons.contacts_outlined.icon.mk,
            activeIcon: Icons.contacts.icon.mk,
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icons.explore_outlined.icon.mk,
            activeIcon: Icons.explore.icon.mk,
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icons.person_outline.icon.mk,
            activeIcon: Icons.person.icon.mk,
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
