import 'dart:math';

import 'package:flutter/material.dart';

class BalloonAnimation extends StatefulWidget {
  @override
  _BalloonAnimationState createState() => _BalloonAnimationState();
}

class _BalloonAnimationState extends State<BalloonAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _sprinklesController;
  final List<Balloon> balloons = [];
  final List<Sprinkle> sprinkles = [];
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _controller.forward();

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });

    _sprinklesController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _sprinklesController.repeat();

    for (int i = 0; i < 20; i++) {
      balloons.add(Balloon(
        offset: Offset(
          random.nextDouble() * 400,
          random.nextDouble() * 800,
        ),
        color: Colors.primaries[random.nextInt(Colors.primaries.length)].withOpacity(0.7),
        radius: random.nextDouble() * 20 + 10,
      ));
    }

    for (int i = 0; i < 100; i++) {
      sprinkles.add(Sprinkle(
        offset: Offset(
          random.nextDouble() * 400,
          random.nextDouble() * 800,
        ),
        color: i % 2 == 0 ? Colors.red.withOpacity(0.8) : Colors.blue.withOpacity(0.8),
        radius: random.nextDouble() * 2 + 1,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _sprinklesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBalloons(),
        _buildSprinkles(),
      ],
    );
  }

  Widget _buildBalloons() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: balloons.map((balloon) {
            final offsetY = -400 * _controller.value + balloon.offset.dy;
            final offsetX = sin(_controller.value * pi) * 50 + balloon.offset.dx;

            return Positioned(
              top: offsetY,
              left: offsetX,
              child: _buildBalloon(balloon),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBalloon(Balloon balloon) {
    return Container(
      decoration: BoxDecoration(
        color: balloon.color,
        shape: BoxShape.circle,
      ),
      width: balloon.radius * 2,
      height: balloon.radius * 2,
    );
  }

  Widget _buildSprinkles() {
    return AnimatedBuilder(
      animation: _sprinklesController,
      builder: (context, child) {
        return Stack(
          children: sprinkles.map((sprinkle) {
            final offsetY = -400 * _sprinklesController.value + sprinkle.offset.dy;
            final offsetX = sin(_sprinklesController.value * pi) * 50 + sprinkle.offset.dx;

            return Positioned(
              top: offsetY,
              left: offsetX,
              child: _buildSprinkle(sprinkle),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSprinkle(Sprinkle sprinkle) {
    return Container(
      decoration: BoxDecoration(
        color: sprinkle.color,
        shape: BoxShape.circle,
      ),
      width: sprinkle.radius * 2,
      height: sprinkle.radius * 2,
    );
  }
}

class Balloon {
  final Offset offset;
  final Color color;
  final double radius;

  Balloon({required this.offset, required this.color, required this.radius});
}

class Sprinkle {
  final Offset offset;
  final Color color;
  final double radius;

  Sprinkle({required this.offset, required this.color, required this.radius});
}
