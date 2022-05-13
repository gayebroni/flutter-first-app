import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NumberExercise extends StatefulWidget {
  const NumberExercise();

  @override
  State<StatefulWidget> createState() => _NumberExerciseState();
}


class _NumberExerciseState extends State<NumberExercise> {
  int _maxNumber =  2 + Random().nextInt(4);
  static const int NO_SELECTION = 0;

  int selectedNumber = NO_SELECTION;
  final _words = ["one", "two", "three", "four", "five"];
  String _displayedAnswer = "";
  List<int> _answersAttempts = [];

  void _doNothing() async {
  }

  void validateAnswer (answer) {
    // Check does <answer> ("three") equals <selectedNumber> (4)
    const answers = {
      "one": 1,
      "two": 2,
      "three" : 3,
      "four": 4,
      "five": 5,
    };

    setState(() {
      if (selectedNumber == answers[answer]) {
        // Answer is correct
        _displayedAnswer = "Correct";
      } else {
        // Answer is incorrect
        _displayedAnswer = "Incorrect";
      }
      _answersAttempts.add(answers[answer] ?? 1);
    });

  }

  void toggleSelectedNumber(number) {
    setState(() {
      selectedNumber = selectedNumber == NO_SELECTION ? number : NO_SELECTION;
      _answersAttempts = [];
    });
  }

  void _resetExercise () {
    setState(() {
      _maxNumber = 2 + Random().nextInt(4);
      _displayedAnswer = "";
      _answersAttempts = [];
    });
  }

  List<Widget> _getWordButtons() {
    List<Widget> answers = [];
    for(int wordIndex = 0; wordIndex < _maxNumber ; wordIndex ++) {
      // Look at the answer attempts
      //   If attempt found for this button change color
      bool hasPriorAttempt = _answersAttempts.contains(wordIndex + 1);

      // What color?
      //   -> Inactive/Disabled (grey)
      //   -> Active (amber)
      //   -> Active and Success (green)
      //   -> Active and Error (red)
      Color? buttonColor = Colors.grey;

      if (selectedNumber != NO_SELECTION) { // If there is a selection
        buttonColor =  Colors.amber[700];

        if (hasPriorAttempt && selectedNumber == wordIndex + 1) { // If selection and correct
          buttonColor = Colors.green;
        }
        if (hasPriorAttempt && selectedNumber != wordIndex + 1) { // If selection and incorrect
          buttonColor = Colors.redAccent;
        }
      }

      answers.add(
        ElevatedButton(
          onPressed: selectedNumber == NO_SELECTION ?
            null : () { validateAnswer(_words[wordIndex]); },
          child: Text(
            _words[wordIndex],
            style: const TextStyle(
              fontSize: 20,
            )
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor
          )
        )
      );
    }
    //answers.shuffle();
    return answers;
  }

  List<ElevatedButton> _getNumberButtons() {
    List<ElevatedButton> buttons = [];
    for (int i = 1 ; i < _maxNumber + 1  ; i++) {
      buttons.add(
          ElevatedButton(
              onPressed: selectedNumber == NO_SELECTION || selectedNumber == i ?
                  () { toggleSelectedNumber(i); } :
                  null,
              child: Text(
                  i.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  )
              ),
              style: ElevatedButton.styleFrom(
                primary: selectedNumber == i ?
                  Colors.blueAccent :
                  selectedNumber == NO_SELECTION ?
                    Colors.amber[700] :
                    Colors.grey
              )
          )
      );
    }
    //buttons.shuffle();
    return buttons;
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
              const Text("Match the numbers with the word form"),
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
                  children: _getNumberButtons()
              )
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 80),
            child: Row(
                children: _getWordButtons(),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
          Container(
              margin: const EdgeInsetsDirectional.only(top: 20),
              child: Text(_displayedAnswer)
          )
        ]
    )
    );
    //... return your container here
  }
}