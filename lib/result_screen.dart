import 'package:flutter/material.dart';
import 'package:quiz_one/quiz_screen.dart';
import 'package:quiz_one/resources.dart';

class ResultScreen extends StatefulWidget {
  int _score;

  ResultScreen(this._score, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [mYellowGreenColor, mDarkGreenColor],
                    stops: [0.0, 1.0],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.repeated)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Your Score is \n ${ widget._score.toString()} ',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            )));
  }

  void gotoNext(String path) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizScreen(path)),
    );
  }
}
