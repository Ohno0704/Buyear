//メイン及び、スタート画面

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Start/StartScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buyear',
      // gradient: LinearGradient(
      //       colors: [Colors.lightBlue.shade200, Colors.deepPurple.shade200],
      //     ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: StartScreen(title: 'Welcome to Buyear'),
    );
  }
}