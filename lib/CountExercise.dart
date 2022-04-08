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
  String _displayedAnswer = "";

  void _doNothing() async {
  }

  void _generateNumber () {
    setState(() {
      _imagesCount = 1 + Random().nextInt(_buttonsCount);
      _displayedAnswer = "";
    });
  }

  List<ElevatedButton> _getAnswerButtons() {
    List<ElevatedButton> buttons = [];
    for (int answer = 1 ; answer < _buttonsCount + 1 ; answer ++) {
      buttons.add(
          ElevatedButton(
              onPressed: () { _validateUserResponse(answer); },
              child: Text(answer.toString())
          )
      );
    }
    return buttons;
  }

  void _validateUserResponse(answer) {
    setState(() {
      if (answer == _imagesCount) {
        _displayedAnswer = "Correct";
      } else {
        _displayedAnswer = "Incorrect";
      }
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
          child: Text(_displayedAnswer)
      )
      ]
    )
    );
    //... return your container here
  }
}