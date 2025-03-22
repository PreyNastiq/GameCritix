import 'package:game_critix/Pages/HomepageWidgets/CustomAppBar.dart';
import 'package:game_critix/Pages/HomepageWidgets/CustomCardCarousel.dart';
import 'package:game_critix/Pages/HomepageWidgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:game_critix/Pages/HomepageWidgets/CustomNavBar.dart';
import 'package:game_critix/Pages/HomepageWidgets/InventoryPage.dart';
import 'package:game_critix/Pages/SliderPage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final PageController pageController = PageController(initialPage: 1);

  final List<Widget> pages = [
    SliderPage(),
    CustomCardCarousel(),
    InventoryPage(),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _currentPage = 1;

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }  

  void _updatePageIndex(int index) {
    setState(() {
      _currentPage = index;
      if (_currentPage == 1) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      //AppBar
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: _currentPage == 1 ? CustomAppBar() : Container(),
        ),
      ),

      //Drawer
      endDrawer: _currentPage == 1 ? CustomDrawer() : null,

      //Body
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: PageView(
          controller: widget.pageController,
          onPageChanged: _updatePageIndex,
          children: widget.pages.map((page) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: page,
            )).toList(),
        ),
      ),

      //NavBar
      bottomNavigationBar: CustomNavBar(
        pageController: widget.pageController,
        onPageChanged: _updatePageIndex,
        currentIndex: _currentPage,
      ),
    );
  }
}
