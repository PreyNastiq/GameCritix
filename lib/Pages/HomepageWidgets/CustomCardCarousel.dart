import 'package:flutter/material.dart';

class CustomCardCarousel extends StatefulWidget {
  const CustomCardCarousel({super.key});

  @override
  State<CustomCardCarousel> createState() => _CustomCardCarouselState();
}

class _CustomCardCarouselState extends State<CustomCardCarousel> {
  final List<Map<String,String>> gameCards = [
    {'image': 'lib/Images/cod.jpeg', 'title': 'Call of Duty',},
    {'image': 'lib/Images/fh5.jpeg', 'title': 'Forza Horizon 5',},
    {'image': 'lib/Images/fortnite.jpeg', 'title': 'Fortnite',},
    {'image': 'lib/Images/got.jpeg', 'title': 'Game of Thrones',},
    {'image': 'lib/Images/mc.jpeg', 'title': 'Minecraft',},
    {'image': 'lib/Images/rdr2.jpeg', 'title': 'Red Dead Redemption 2',},
    {'image': 'lib/Images/tlou2.jpeg', 'title': 'The Last of Us 2',},
  ];

  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 500),
      child: SizedBox(
        height: 150, // Fixed height for proper visibility
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: gameCards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: _currentIndex == index ? 200 : 100, // Selected tile is wider
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(gameCards[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: _currentIndex == index ? const Color.fromARGB(255, 0, 255, 0) : Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
