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
                  setState(() {
                    counter--;
                    swipeIndicator = const Icon(
                      Icons.thumb_down,
                      key: ValueKey('dislike'),
                      size: 100,
                      color: Colors.red,
                    );
                  });
                  return true;
                },
                onSwipeRight: (item) {
                  setState(() {
                    counter++;
                    swipeIndicator = const Icon(
                      Icons.thumb_up,
                      key: ValueKey('like'),
                      size: 100,
                      color: Colors.green,
                    );
                  });
                  return true;
                },
                onSwipeUp: (item) {
                  setState(() {
                    swipeIndicator = const Icon(
                      Icons.skip_next,
                      key: ValueKey('skip'),
                      size: 100,
                      color: Colors.yellow,
                    );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You swiped up!")),
                  );
                  return true;
                },
                onSwipeDown: (item) {
                  setState(() {
                    swipeIndicator = const Icon(
                      Icons.message_outlined,
                      key: ValueKey('message'),
                      size: 100,
                      color: Colors.blue,
                    );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You swiped down!")),
                  );
                  return true;
                },
                onDoubleTap: (item) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You double tapped!")),
                  );
                },

                onSwipedLeftAppear: const SizedBox.shrink(),
                onSwipedRightAppear: const SizedBox.shrink(),
                onSwipedDownAppear: const SizedBox.shrink(),
                onSwipedUpAppear: const SizedBox.shrink(),
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
                duration: const Duration(milliseconds: 300),
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
