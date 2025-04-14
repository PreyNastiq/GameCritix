import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_critix/Pages/HomepageWidgets/InventoryPage.dart';
import 'package:game_critix/Pages/HomepageWidgets/HistoryPage.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Container(
        color: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "M E N U",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 255, 0),
                    fontSize: 45,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Inventory",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InventoryPage()));
              },
            ),
            ListTile(
              title: Text("History",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HistoryPage()));
              },
            ),
            ListTile(
              title: Text("Report Issues",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              onTap: () {},
            ),
            SizedBox(
              height: 450,
            ),
            ListTile(
                title: Text("Sign Out",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.red, fontSize: 20)),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                }),
          ],
        ),
      ),
    );
  }
}
