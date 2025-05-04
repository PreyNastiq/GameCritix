import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_critix/Pages/Decoration/AnimatedBackground.dart';

class GameDetailsPage extends StatefulWidget {
  final Map<String, String> gameDetails;

  const GameDetailsPage({super.key, required this.gameDetails});

  @override
  GameDetailsPageState createState() => GameDetailsPageState();
}

class GameDetailsPageState extends State<GameDetailsPage>
    with SingleTickerProviderStateMixin {
  late List<Offset> _positions = [];
  late List<Offset> _circlePositions = [];
  late List<Offset> _trianglePositions = [];
  late List<Offset> _squarePositions = [];
  late AnimationController _controller;
  late ScrollController _scrollController;
  final TextEditingController _reviewController = TextEditingController();
  final List<String> _reviews = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeShapes(context.size!);
    });
  }

  void _onScroll() {
    setState(() {});
  }

  void _initializeShapes(Size size) {
    final random = Random();
    setState(() {
      _positions = List.generate(10, (_) => Offset(random.nextDouble() * size.width, random.nextDouble() * size.height));
      _circlePositions = List.generate(10, (_) => Offset(random.nextDouble() * size.width, random.nextDouble() * size.height));
      _trianglePositions = List.generate(10, (_) => Offset(random.nextDouble() * size.width, random.nextDouble() * size.height));
      _squarePositions = List.generate(10, (_) => Offset(random.nextDouble() * size.width, random.nextDouble() * size.height));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: AnimatedBackground(
                  controller: _controller,
                  plusPositions: _positions,
                  circlePositions: _circlePositions,
                  trianglePositions: _trianglePositions,
                  squarePositions: _squarePositions,
                ),
              ),
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    iconTheme: const IconThemeData(color: Colors.white70),
                    backgroundColor: Colors.transparent,
                    expandedHeight: 400.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop,
                        child: Image.asset(
                          widget.gameDetails['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            color: Colors.black.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.attach_money, color: Colors.green),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Price: ${widget.gameDetails['price']}",
                                        style: const TextStyle(fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.computer, color: Colors.blue),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Requirements: ${widget.gameDetails['requirements']}",
                                          style: const TextStyle(fontSize: 18, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.description, color: Colors.orange),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Description: ${widget.gameDetails['description']}",
                                          style: const TextStyle(fontSize: 18, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            "Reviews",
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _reviewController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Write a review...",
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white70.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 0, 255, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: () {
                              if (_reviewController.text.isNotEmpty) {
                                setState(() {
                                  _reviews.add(_reviewController.text);
                                  _reviewController.clear();
                                });
                              }
                            },
                            child: const Text("Submit Review"),
                          ),
                          const SizedBox(height: 20),
                          ..._reviews.map((review) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  review,
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
