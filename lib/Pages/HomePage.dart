import 'package:game_critix/Pages/HomepageWidgets/CustomAppBar.dart';
import 'package:game_critix/Pages/HomepageWidgets/CustomCardCarousel.dart';
import 'package:game_critix/Pages/HomepageWidgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:game_critix/Pages/HomepageWidgets/CustomNavBar.dart';
import 'package:game_critix/Pages/HomepageWidgets/HistoryPage.dart';
import 'package:game_critix/Pages/SliderPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //selected index control nav bar
  int _selectedTab = 1;

  //Pages to navigate
  final List<Widget> _pages = [
    const SliderPage(),
    const CustomCardCarousel(),
    const HistoryPage(),
  ];

  //update selected index
  void navigateBottomBar(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      //AppBar
      appBar: (_selectedTab == 1) ? CustomAppBar() : null,

      //Drawer
      endDrawer: CustomDrawer(),

      //Body
      body: _pages[_selectedTab],

      //NavBar
      bottomNavigationBar: CustomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}
