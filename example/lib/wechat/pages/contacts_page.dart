import 'package:example/wechat/widgets/contact_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Contacts'.text.bold.f18.mk,
        actions: [
          Icons.person_add_outlined.icon.s24.iconClick(
            onTap: () {
              /* Add new contact */
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Top section with special items
          _buildSpecialItems(),
          // Contacts list with index
          // ...List.generate(26, (index) {
          //   final letter = String.fromCharCode(65 + index);
          //   return _buildContactSection(letter, _mockContacts
          //       .where((contact) => contact.name.startsWith(letter))
          //       .toList());
          // }).where((section) => section != null),
        ],
      ),
    );
  }

  Widget _buildSpecialItems() {
    return column.children([
      ContactListItem(
        icon: Icons.people.icon.green.s28.mk,
        name: 'New Friends',
        onTap: () {},
      ),
      ContactListItem(
        icon: Icons.group.icon.blue.s28.mk,
        name: 'Group Chats',
        onTap: () {},
      ),
      ContactListItem(
        icon: Icons.tag.icon.orange.s28.mk,
        name: 'Tags',
        onTap: () {},
      ),
      ContactListItem(
        icon: Icons.public.icon.teal.s28.mk,
        name: 'Official Accounts',
        onTap: () {},
      ),
    ]);
  }

/*  Widget? _buildContactSection(String letter, List<Contact> contacts) {
    if (contacts.isEmpty) return null;
    
    return column.children([
      container.grey200.p8.ph16.wFull.child(
        letter.text.grey600.f14.mk,
      ),
      ...contacts.map((contact) => ContactListItem(
            avatar: contact.avatar,
            name: contact.name,
            onTap: () {},
          )),
    ]);
  }*/
}
