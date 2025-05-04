import 'package:flutter/material.dart';
import 'package:game_critix/Pages/GameDetailPage.dart';

class CustomCardCarousel extends StatefulWidget {
  const CustomCardCarousel({super.key});

  @override
  State<CustomCardCarousel> createState() => _CustomCardCarouselState();
}

class _CustomCardCarouselState extends State<CustomCardCarousel> {
  final List<Map<String, String>> gameCards = [
    {
      'image': 'lib/Images/cod.jpeg',
      'title': 'Call of Duty',
      'price': '\$59.99',
      'requirements': 'i5 | GTX 1060 | 16GB RAM',
      'description':
          'A first-person shooter franchise that revolutionized military gaming.',
    },
    {
      'image': 'lib/Images/fh5.jpeg',
      'title': 'Forza Horizon 5',
      'price': '\$49.99',
      'requirements': 'i7 | RTX 2060 | 16GB RAM',
      'description':
          'An open-world racing game set in beautiful landscapes of Mexico.',
    },
    {
      'image': 'lib/Images/fortnite.jpeg',
      'title': 'Fortnite',
      'price': 'Free to Play',
      'requirements': 'i3 | GTX 960 | 8GB RAM',
      'description':
          'A battle royale sensation known for its fast pace and vibrant visuals.',
    },
    {
      'image': 'lib/Images/got.jpeg',
      'title': 'Game of Thrones',
      'price': '\$39.99',
      'requirements': 'i5 | GTX 970 | 12GB RAM',
      'description':
          'An epic fantasy drama full of political intrigue and dragons.',
    },
    {
      'image': 'lib/Images/mc.jpeg',
      'title': 'Minecraft',
      'price': '\$26.95',
      'requirements': 'Any Dual Core CPU | Intel HD Graphics | 4GB RAM',
      'description':
          'A sandbox game where creativity and survival meet in blocky beauty.',
    },
    {
      'image': 'lib/Images/rdr2.jpeg',
      'title': 'Red Dead Redemption 2',
      'price': '\$59.99',
      'requirements': 'i7 | GTX 1070 | 16GB RAM',
      'description':
          'A cinematic western story set in a stunning open-world frontier.',
    },
    {
      'image': 'lib/Images/tlou2.jpeg',
      'title': 'The Last of Us 2',
      'price': '\$69.99',
      'requirements': 'PS4 / PS5 Exclusive',
      'description':
          'A gritty, emotional journey of survival in a post-apocalyptic world.',
    },
  ];

  int? _currentIndex; // Track the selected card index
  final ScrollController _scrollController = ScrollController();
  List<bool> _likedGames = [];

  @override
  void initState() {
    super.initState();
    _likedGames = List.generate(gameCards.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCard =
        _currentIndex != null ? gameCards[_currentIndex!] : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Text('Top Games',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: gameCards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_currentIndex == index) {
                        _currentIndex = null;
                      } else {
                        _currentIndex = index;
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: _currentIndex == index ? 300 : 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(gameCards[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: _currentIndex == index
                            ? const Color.fromARGB(255, 0, 255, 0)
                            : Colors.white30,
                        width: 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          AnimatedOpacity(
            opacity: selectedCard != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: selectedCard != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 255, 0),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCard['title']!,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "💵 Price:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green[300],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            selectedCard['price']!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "🖥️ System Requirements:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyan[300],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            selectedCard['requirements']!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "📝 Description:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.amber[300],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            selectedCard['description']!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  size: 40,
                                  _likedGames[_currentIndex!]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _likedGames[_currentIndex!]
                                      ? const Color.fromARGB(255, 0, 255, 0)
                                      : const Color.fromARGB(255, 0, 255, 0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _likedGames[_currentIndex!] =
                                        !_likedGames[_currentIndex!];
                                  });
                                },
                              ),
                              const SizedBox(width: 160),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GameDetailsPage(
                                        gameDetails: selectedCard,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 0, 255, 0),
                                ),
                                child: const Text("Show More"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
