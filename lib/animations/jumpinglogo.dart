import 'package:flutter/material.dart';

class JumpingLogo extends StatefulWidget {
  @override
  _JumpingLogoState createState() => _JumpingLogoState();
}

class _JumpingLogoState extends State<JumpingLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds:600),
      reverseDuration: Duration(milliseconds: 600),
    )..repeat(reverse: true); // Repeating the animation back and forth
    _animation = Tween(begin: 0.0, end: 10.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0.0, _animation.value),
          child: Image.asset("assets/images/logo2.png", width: 320, height: 150),
        );
      },
    );
  }
}
