
import 'dart:math';

import 'package:flutter/material.dart';

class CircularCarousel extends StatefulWidget {
  const CircularCarousel({super.key});

  @override
  _CircularCarouselState createState() => _CircularCarouselState();
}

class _CircularCarouselState extends State<CircularCarousel>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  double startAngle = 0;
  double endAngle = 0;

  int currentIndex = 1;

  final int length = 4;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void updatedangle(int delta) {
    startAngle = endAngle;
    endAngle = startAngle + delta * (2 * pi / length);
    _animation = Tween<double>(begin: startAngle, end: endAngle).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward(from: 0.0);
    setState(() {
      currentIndex = (currentIndex + -1 * delta) % length;
      if (currentIndex < 0) currentIndex += length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double majorAxis = 150;
    final double minorAxis = 100;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (_animation.isAnimating) return;
        if (details.delta.dx > 0) {
          updatedangle(-1);
        } else if (details.delta.dx < 0) {
          updatedangle(1);
        }
      },
      child: Center(
        child: Container(
          color: Colors.blue,
          height: double.infinity,
          width: double.infinity,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => Stack(
              alignment: Alignment.center,
              children: List.generate(length, (index) {
                double angle = index * (2 * pi / length) + _animation.value;
                return Transform.translate(
                  offset: Offset(majorAxis * cos(angle),
                      minorAxis * sin(angle)), // Ellipse shape
                  child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            color: index == currentIndex?Colors.red:Colors.grey.withOpacity(0.5), // No blur for current index
                          ),
                          height: index == currentIndex?200:100,
                          width: index == currentIndex?200:100,
                          child: Center(child: Text("item $index")),
                        )
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}