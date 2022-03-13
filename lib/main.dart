import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Games',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: "Word Games App"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _imagesCount =  1 + Random().nextInt(5);

  void _generateNumber () {
    setState(() {
      _imagesCount = 1 + Random().nextInt(5);
    });
  }

  List<Image> _getBirdImages(count) {
    List<Image> images = [];
    for (int i = 0 ; i < count ; i++) {
      images.add(const Image(
        width: 72,
        image: NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
      )
      );
    }
    return images;
  }

  void _linkToGame () async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter += 1;
    });
    const URL = "https://wordlegame.org/";
    if (! await launch(URL)){
      throw "Could not launch $URL";
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: const Text.rich(
            TextSpan(
              children: [
                //Text(widget.title),
                WidgetSpan(child: Icon(Icons.sort_by_alpha)),
                TextSpan(text:  "Word Games", style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          )
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal)
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       IconButton(
                         onPressed: _linkToGame,
                         icon: const Icon(Icons.volume_down)
                       ),
                       const Text("How many birds are there?"),
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
                        children: _getBirdImages(_imagesCount)
                    )
                  )
                 

                ]
              )
            ),
            Container(
                margin: const EdgeInsetsDirectional.only(top: 400),
              child: Column (
                children: <Widget> [
                  const Text(
                    'You have played these games this many times:',
                  ),
                  Text(
                    'Wordle: $_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  IconButton(
                      onPressed: _linkToGame,
                      icon: const Icon(
                          Icons.book,
                          size: 40,
                          color: Colors.amber
                      )
                  )
                ]
              )
            )

          ],
        ),
      ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
