import 'dart:async';

import 'package:flappybird/Barrier.dart';
import 'package:flappybird/Mybird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double Birdy = 0;
  double time = 0;
  double height = 0;
  double initalHeigt = Birdy;
  bool Gamestarted = false;
  int score = 0;
  int bestscore = 0;

  double birdWidth = 0.1;
  double birdHeight = 0.1;

  static List<double> barrierX = [1, 2 + 1.5];
  static double barrierWidth = 0.5; // out of 2
  List<List<double>> barrierHeight = [
    [0.8, 0.4],
    [0.5, 0.6],
  ];

  void StartGame() {
    Gamestarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        Birdy = initalHeigt - height;
      });

      if (birdIsDead()) {
        timer.cancel();
        _showdialog();
      }
      moveMap();

      time += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.015;
      });

      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      Birdy = 0;
      Gamestarted = false;
      time = 0;
      initalHeigt = Birdy;
      barrierX = [2, 2 + 1.5];
      score = 0;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initalHeigt = Birdy;
      score += 1;

      if (score >= bestscore) {
        setState(() {
          bestscore = score;
        });
      }
    });
  }

  bool birdIsDead() {
    if (Birdy < -1 || Birdy > 1) {
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (Birdy <= -1 + barrierHeight[i][0] ||
              Birdy + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  void _showdialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: Text("OYUN BİTTİ"),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Tekrar Başlat"),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Gamestarted) {
          jump();
        } else {
          StartGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/arkaplan.png"),
                          fit: BoxFit.fill)),
                  child: Center(
                    child: Stack(
                      children: [
                        MyBird(
                          birdY: Birdy,
                          birdWidth: birdWidth,
                          birdHeight: birdHeight,
                        ),

                        Container(
                          alignment: Alignment(0, -0.2),
                          child: Gamestarted
                              ? Text(" ")
                              : Text(
                                  "O Y U N U   B A Ş L A T",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                        ),
                        Barrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][0],
                          isThisBottomBarrier: false,
                        ),

                        // Bottom barrier 0
                        Barrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][1],
                          isThisBottomBarrier: true,
                        ),

                        // Top barrier 1
                        Barrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][0],
                          isThisBottomBarrier: false,
                        ),

                        // Bottom barrier 1
                        Barrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][1],
                          isThisBottomBarrier: true,
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Skor",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$score",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "En Yüksek Skor",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$bestscore",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
