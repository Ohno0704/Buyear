//メイン及び、スタート画面

import 'package:flutter/material.dart';
import 'package:flutter_application_1/StartScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buyear',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: StartScreen(title: 'Welcome to Buyear'),
    );
  }
}


