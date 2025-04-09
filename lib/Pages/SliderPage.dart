import 'package:eazy_swipeable_cards/eazy_swipeable_cards.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  int counter = 0;
  Widget? swipeIndicator;

  final List<String> allImages = [
    'lib/Images/cod.jpeg',
    'lib/Images/fh5.jpeg',
    'lib/Images/fortnite.jpeg',
    'lib/Images/got.jpeg',
    'lib/Images/mc.jpeg',
    'lib/Images/rdr2.jpeg',
    'lib/Images/tlou2.jpeg',
  ];

  final int pageSize = 7;

  void _showSwipeIndicator(Widget indicator) {
    setState(() {
      swipeIndicator = indicator;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        swipeIndicator = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: EazySwipeableCards<String>(
                cardHeight: 400,
                cardWidth: 300,
                shownCards: 7,
                cardDistance: 50,
                cardsAnimationInMilliseconds: 100,
                behindCardsShouldBeOpaque: false,
                borderRadius: 50,
                elevation: 5,
                pageSize: pageSize,
                pageThreshold: 10,

                /// Build each card using asset image path
                builder: (index, item, context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(item),
                        onError: (exception, stackTrace) {
                          debugPrint('Failed to load image: $item');
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },

                /// Load more cards as needed
                onLoadMore: ({required pageNumber, required pageSize}) async {
                  int start = pageNumber * pageSize;
                  int end = start + pageSize;

                  if (start >= allImages.length) return [];

                  return allImages.sublist(
                    start,
                    end > allImages.length ? allImages.length : end,
                  );
                },

                /// Swipe callbacks with animated indicator
                onSwipeLeft: (item) {
                  counter--;
                  _showSwipeIndicator(
                    Column(
                      key: const ValueKey('dislike'),
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.thumb_down,
                          size: 100,
                          color: Colors.red,
                        ),
                        Text(
                          "Disliked",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ],
                    ),
                  );
                  return true;
                },
                onSwipeRight: (item) {
                  counter++;
                  _showSwipeIndicator(
                    Column(
                      key: const ValueKey('like'),
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.thumb_up,
                          size: 100,
                          color: Colors.green,
                        ),
                        Text(
                          "Liked",
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      ],
                    ),
                  );
                  return true;
                },
                onSwipeUp: (item) {
                  _showSwipeIndicator(
                    Column(
                      key: const ValueKey('skip'),
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.skip_next,
                          size: 100,
                          color: Colors.yellow,
                        ),
                        Text(
                          "Skipped",
                          style: TextStyle(color: Colors.yellow, fontSize: 18),
                        ),
                      ],
                    ),
                  );
                  return true;
                },
                onSwipeDown: (item) {
                  _showSwipeIndicator(
                    Column(
                      key: const ValueKey('message'),
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.message_outlined,
                          size: 100,
                          color: Colors.blue,
                        ),
                        Text(
                          "Review",
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ],
                    ),
                  );
                  return true;
                },
                onDoubleTap: (item) {
                  _showSwipeIndicator(
                    Column(
                      key: const ValueKey('doubleTap'),
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.favorite,
                          size: 100,
                          color: Colors.pink,
                        ),
                        Text(
                          "Double Tapped",
                          style: TextStyle(color: Colors.pink, fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },

                onSwipedLeftAppear: const SizedBox.square(),
                onSwipedRightAppear: const SizedBox.square(),
                onSwipedDownAppear: const SizedBox.square(),
                onSwipedUpAppear: const SizedBox.square(),
              ),
            ),
          ),

          /// Animated swipe indicator at the bottom
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: swipeIndicator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
