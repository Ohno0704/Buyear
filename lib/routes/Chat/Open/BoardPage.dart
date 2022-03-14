import 'package:flutter_application_1/routes/Chat/Open/BoardListModel.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Open/AddBoardPage.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Board.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoardPage extends StatefulWidget {
  BoardPage(this.boardTitle);
  String boardTitle;
  @override
  _BoardPageState createState() => _BoardPageState(boardTitle);
}

class _BoardPageState extends State<BoardPage> {
  String boardTitle = '';

  _BoardPageState(String boardTitle) {
    this.boardTitle = boardTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
          title: Text(this.boardTitle),
          gradient: LinearGradient(colors: [
            Colors.blue.shade200,
            Colors.blue.shade300,
            Colors.blue.shade400
          ])),
      body: Center(
        child: Text(
          "$boardTitle",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}