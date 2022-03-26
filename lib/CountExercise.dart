import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountExercise extends StatefulWidget {
  //const CountExercise(this.child);
  //final Widget child;

  const CountExercise({ required this.question});
  final String question;

  @override
  State<StatefulWidget> createState() => _CountExerciseState();
}

class _CountExerciseState extends State<CountExercise> {

  void _doNothing() async {
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
              onPressed: _doNothing,
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
      ]
    )
    );
    //... return your container here
  }
}