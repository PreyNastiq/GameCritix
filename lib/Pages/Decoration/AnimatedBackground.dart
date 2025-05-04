import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;
  final List<Offset> plusPositions;
  final List<Offset> circlePositions;
  final List<Offset> trianglePositions;
  final List<Offset> squarePositions;

  const AnimatedBackground({
    super.key,
    required this.controller,
    required this.plusPositions,
    required this.circlePositions,
    required this.trianglePositions,
    required this.squarePositions,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: [
            _buildIcons(plusPositions, Icons.add),
            _buildIcons(circlePositions, Icons.circle_outlined),
            _buildIcons(trianglePositions, Icons.change_history),
            _buildIcons(squarePositions, Icons.square_outlined),
          ],
        );
      },
    );
  }

  Widget _buildIcons(List<Offset> positions, IconData icon) {
    return Stack(
      children: List.generate(positions.length, (index) {
        final dx = positions[index].dx +
            sin(controller.value * 2 * pi + index) * 50;
        final dy = positions[index].dy +
            cos(controller.value * 2 * pi + index) * 50;
        return Positioned(
          left: dx,
          top: dy,
          child: Transform.rotate(
            angle: controller.value * 2 * pi,
            child: Icon(
              icon,
              size: 50,
              color: const Color.fromARGB(255, 0, 255, 0),
            ),
          ),
        );
      }),
    );
  }
}
