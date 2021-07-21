import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

void main() => runApp(Quizzler());
QuizBrain quizBrain = QuizBrain();

// ignore: use_key_in_widget_constructors
class Quizzler extends StatelessWidget {
  // Future<String>
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizzPage(),
          ),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class QuizzPage extends StatefulWidget {
  @override
  _QuizzPageState createState() => _QuizzPageState();
}

List<Widget> scoreKeeper = [];

class _QuizzPageState extends State<QuizzPage> {
  void checkAnswer(bool userInputAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (userInputAnswer == correctAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green[400],
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red[900],
        ));
      }
      // questionNumber++;
      if (quizBrain.isFinshed() == true) {
        _showConfirmationAlert(context);
        // scoreKeeper.clear();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  // backgroundColor: Colors.blue,
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  child: const Text('True'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                    onSurface: Colors.greenAccent[400],
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    checkAnswer(true);
                  })),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
                child: const Text('False'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.red,
                  onSurface: Colors.redAccent[100],
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  checkAnswer(false);
                }),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

_showConfirmationAlert(BuildContext context) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: const Text("End of Quizz!"),
      content: const Text("Would you like to reset the quizz"),
      actions: <Widget>[
        BasicDialogAction(
          title: const Text("OK"),
          onPressed: () {
            quizBrain.resetQuizz();
            scoreKeeper.clear();
            Navigator.pop(context);
          },
        ),
        BasicDialogAction(
          title: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
