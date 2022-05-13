import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountExercise extends StatefulWidget {
  const CountExercise({ required this.question, required this.imageURL});
  final String imageURL;
  final String question;

  @override
  State<StatefulWidget> createState() => _CountExerciseState();
}

class _CountExerciseState extends State<CountExercise> {
  int _imagesCount =  1 + Random().nextInt(5);
  final int _buttonsCount = 5;
  String _answerFeedback = "";
  List<int> _answersAttempts = [];

  void _doNothing() async {
  }

  void _resetExercise () {
    setState(() {
      _imagesCount = 1 + Random().nextInt(_buttonsCount);
      _answerFeedback = "";
      _answersAttempts = [];
    });
  }

  Widget _getAnswerSymbol() {
    if (_answerFeedback == "Correct") {
      return const Icon(Icons.check, color: Colors.green);
    } else if (_answersAttempts.isEmpty) {
      return const Icon(Icons.question_answer);
    } else {
      return const Icon(Icons.clear, color: Colors.redAccent);
    }
  }

  Widget _getAnswerAttempts() {
    return Text(" " + _answersAttempts.length.toString() + " attempts");
  }

  List<ElevatedButton> _getAnswerButtons() {
    List<ElevatedButton> buttons = [];
    for (int choiceNumber = 1 ; choiceNumber < _buttonsCount + 1 ; choiceNumber ++) {
      // Look at the answer attempts
      //   If attempt found for this button change color
      bool hasPriorAttempt = _answersAttempts.contains(choiceNumber);

      // What color?
      //   -> Default (orange) if not attempts made
      //   -> Success (green) if attempt correct
      //   -> Error (red) if attempt incorrect
      Color? buttonColor = Colors.amber[700];
      if (hasPriorAttempt) {
         buttonColor = (_imagesCount == choiceNumber) ? Colors.green : Colors.redAccent;
      }

      buttons.add(
          ElevatedButton(
              onPressed: () { _validateUserResponse(choiceNumber); },
              child: Text(
                  choiceNumber.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                )
              ),
              style: ElevatedButton.styleFrom(
                  primary: buttonColor
              )
          )
      );
    }
    //buttons.shuffle();
    return buttons;
  }

  void _validateUserResponse(answerAttempt) {
    setState(() {
      _answerFeedback = (answerAttempt == _imagesCount) ? "Correct" : "Incorrect";
      _answersAttempts.add(answerAttempt);
    });
  }

  List<ClipRRect> _getImages(count) {
    List<ClipRRect> boxedImages = [];
    for (int i = 0 ; i < count ; i++) {
      boxedImages.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child:Image(
            width: 50,
            image: NetworkImage(widget.imageURL),
          )
        )
      );
    }
    return boxedImages;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
    children: <Widget> [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: _doNothing,
              icon: const Icon(Icons.volume_down)
          ),
          Text(widget.question),
          IconButton(
              onPressed: _resetExercise,
              icon: const Icon(Icons.casino)
          )
        ],
      ),
      const TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.translate),
            hintText: 'Write translation...',
            helperText: 'Question translation',
            border: OutlineInputBorder(),
          )
      ),
      Container(
          margin: const EdgeInsetsDirectional.only(top: 20),
          child: Row( // Make row dynamic based on die roll
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _getImages(_imagesCount)
          )
      ),
      Container(
          margin: const EdgeInsetsDirectional.only(top: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _getAnswerButtons()
          )
      ),
      Container(
          margin: const EdgeInsetsDirectional.only(top: 20),
          child: Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getAnswerSymbol(),
              _getAnswerAttempts()
            ],
          )
      )
      ]
    )
    );
    //... return your container here
  }
}