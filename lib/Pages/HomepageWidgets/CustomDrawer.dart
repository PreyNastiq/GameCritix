import 'package:flutter/material.dart';
import 'package:game_critix/Pages/HomepageWidgets/DeveloperPage.dart';
import 'package:game_critix/Pages/HomepageWidgets/HistoryPage.dart';
import 'package:game_critix/Services/Auth/AuthService.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  //get auth service
  final authService = AuthService();

  //logout function
  void signOut() async {
      await authService.signOut();
  }

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
              title: Text("Developer",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DeveloperPage()));
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
                  signOut();
                }),
          ],
        ),
      ),
    );
  }
}
