import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final PageController pageController;
  final int currentIndex;
  final Function(int) onPageChanged;
  const CustomNavBar({super.key, required this.pageController,required this.onPageChanged,required this.currentIndex});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {

  void _onTabSelected(int index) {
    widget.pageController.jumpToPage(index);
    widget.onPageChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
      activeIcons: const [
        Icon(Icons.slideshow, color: Colors.white),
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.favorite, color: Colors.white),
      ],
      inactiveIcons: [
        Icon(Icons.slideshow, color: Colors.black),
        Icon(Icons.home, color: Colors.black),
        Icon(Icons.favorite, color: Colors.black),
      ],
      color: const Color.fromARGB(186, 0, 255, 0),
      height: 60,
      circleWidth: 60,
      activeIndex: widget.currentIndex,
      onTap: _onTabSelected,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      cornerRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
    );
  }
}
