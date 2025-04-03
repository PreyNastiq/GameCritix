import 'package:flutter/material.dart';
import 'package:game_critix/Pages/HomepageWidgets/ProfilePage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        cursorColor: const Color.fromARGB(255, 0, 122, 8),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration.collapsed(
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfilePage()));
        },
        icon: Icon(Icons.person, color: Colors.grey),
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
