import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  late final birdY;
  late final double birdWidth; // normal double value for width.
  late final double birdHeight;
  MyBird({this.birdY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment(0, birdY),
        child: Image.asset(
          'assets/bird.png',
          width: MediaQuery.of(context).size.height * birdWidth / 1.2,
          height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 1,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
