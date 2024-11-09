import 'package:flutter/material.dart';
import 'package:quiz_one/quiz_screen.dart';
import 'package:quiz_one/resources.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                'Android'.toOutlineButton(() {
                  gotoNext('assets/android_questions.json');
                }),
                SizedBox(
                  height: 20,
                ),
                'iOS'.toOutlineButton(() {
                  gotoNext('assets/ios_questions.json');
                }),
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
