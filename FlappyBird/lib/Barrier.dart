import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  late final barrierWidth; // out of 2, where 2 is the width of the screen
  late final barrierHeight; // proportion of the screenheight
  late final barrierX;
  late final bool isThisBottomBarrier;

  Barrier(
      {this.barrierHeight,
      this.barrierWidth,
      required this.isThisBottomBarrier,
      this.barrierX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
            border: Border.all(color: Colors.green.shade900, width: 10)),
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
