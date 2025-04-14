import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final void Function(int) onTabChange;

  const CustomNavBar({super.key, required this.onTabChange});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _activeIndex = 1; // Default active index

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
      activeIndex: _activeIndex,
      circleWidth: 60,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      cornerRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      onTap: (index) {
        setState(() {
          _activeIndex = index;
        });
        widget.onTabChange(index);
      },
    );
  }
}
