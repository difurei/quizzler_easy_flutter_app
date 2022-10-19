import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../model/quiz_brain.dart';
import '../exit_screen.dart';



void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();

  List<Widget> scoreKeeper = [];
  int scores = 0;
  int rightScores = 0;

  void checkAnswer(BuildContext context, bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    bool isFinished = quizBrain.isFinished();


    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        scores++;
        rightScores++;
      }
      else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
        scores++;
      }
      if(isFinished) {
        _alertOfTheEndOfQuiz(context);
      }
      else {
        quizBrain.nextQuestion();
      }
    });
  }

  _alertOfTheEndOfQuiz(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "The End Of Quiz",
      desc: "Congratulations! You are finishing this quiz."
          " Your scores: $rightScores / $scores "
          " Do you want to try again?",
      buttons: [
        DialogButton(
          color: Colors.greenAccent,
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              scores = 0;
              rightScores = 0;
              scoreKeeper = [];
              quizBrain.restartQuest();
              Navigator.pop(context);
            });
          },
          width: 120,
        ),
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "Exit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ExitScreen())),
          width: 120,
        )
      ],
    ).show();
  }

  Widget buildFlatButton(BuildContext context, Color buttonColor, String text, bool check) {
    return  Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
            textColor: Colors.white,
            color: buttonColor,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              checkAnswer(context, check);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        buildFlatButton(context, Colors.green, 'True', true),
        buildFlatButton(context, Colors.red, 'False', false),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}



/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
