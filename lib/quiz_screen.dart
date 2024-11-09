import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_one/questions_model.dart';
import 'package:quiz_one/resources.dart';
import 'package:quiz_one/result_screen.dart';
import 'package:radio_group_v2/utils/radio_group_decoration.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';
import 'package:radio_group_v2/widgets/views/radio_group.dart';

class QuizScreen extends StatefulWidget {
  String filePath;

  QuizScreen(this.filePath, {super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _secondsRemaining = 60;
  int _mScore = 0;
  Timer? _timer;
  RadioGroupController myController = RadioGroupController();
  List<Question>? _questions;
  int _currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (_questions == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final currentQuestion = _questions![_currentQuestionIndex];
    return Scaffold(
      body: Container(
        width: double.maxFinite,
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
            _secondsRemaining.toString().toWhiteLabel(),
            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(12),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white60,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentQuestion.question,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: RadioGroup(
                controller: myController,
                values: currentQuestion.options,
                indexOfDefault: 0,
                orientation: RadioGroupOrientation.vertical,
                decoration: RadioGroupDecoration(
                  spacing: 10.0,
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                  fillColor: WidgetStateProperty.all<Color>(Colors.white),
                  activeColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                child: Text(
                  _currentQuestionIndex == _questions!.length - 1
                      ? 'Submit'
                      : 'Next',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    if (myController.value.toString() ==
                        currentQuestion.answer) {
                      _mScore = _mScore + 1;
                    }
                    changeToNext();
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _loadQuestions() async {
    final questions = await loadQuestions();
    setState(() {
      _questions = questions;
    });
  }

  Future<List<Question>> loadQuestions() async {
    final String jsonString = await rootBundle.loadString(widget.filePath);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Question.fromJson(json)).toList();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          changeToNext();
        }
      });
    });
  }

  void changeToNext() {
    if (_currentQuestionIndex < _questions!.length - 1) {
      _currentQuestionIndex++;
      myController = RadioGroupController();
      _secondsRemaining = 60; // Restart the timer
    } else {
      // Handle quiz completion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(_mScore)),
      );
    }
  }
}
