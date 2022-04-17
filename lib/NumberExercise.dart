import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NumberExercise extends StatefulWidget {
  const NumberExercise();

  @override
  State<StatefulWidget> createState() => _NumberExerciseState();
}


class _NumberExerciseState extends State<NumberExercise> {
  int _maxNumber =  2 + Random().nextInt(4);
  final _words = ["one", "two", "three", "four", "five"];
  String _displayedAnswer = "";

  void _doNothing() async {
  }

  void _generateNumber () {
    setState(() {
      _maxNumber = 2 + Random().nextInt(4);
      _displayedAnswer = "";
    });
  }

  List<Widget> _getWordAnswers() {
    List<Widget> answers = [];
    for(int i = 0; i < _maxNumber ; i ++) {
      answers.add(
        Text(
          _words[i],
          style: const TextStyle(
              color: Colors.amber,
              fontSize: 22,
              fontWeight: FontWeight.bold
          )
        )
      );
    }
    answers.shuffle();
    return answers;
  }

  List<ElevatedButton> _getNumberButtons() {
    List<ElevatedButton> buttons = [];
    for (int i = 1 ; i < _maxNumber + 1  ; i++) {
      buttons.add(
          ElevatedButton(
              onPressed: () {_doNothing(); },
              child: Text(
                  i.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ))
          )
      );
    }
    buttons.shuffle();
    return buttons;
  }

  void _validateUserResponse(answer) {
    setState(() {
      _displayedAnswer = "Incorrect";
    });
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
                  onPressed: _generateNumber,
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
          Column(
              children: _getWordAnswers(),
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