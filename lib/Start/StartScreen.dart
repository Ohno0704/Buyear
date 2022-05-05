/*
buyearのロゴが現れる最初の画面
*/

import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/Start/LoginPage.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
            title: Text('Enjoy University Life With Buyear!'),
            gradient: LinearGradient(colors: [
              Colors.blue.shade200,
              Colors.blue.shade300,
              Colors.blue.shade400
            ])),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 500,
                width: 500,
                child: StartImage(),
              ),
              SizedBox(
                height: 80,
                width: 400,
                child: LoginButton(),
              ),
              SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('version:1.0.2'),
                    ],
                  ))
            ],
          ),
        ));
  }
}

// ログインボタンに関するクラス
class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shadowColor: Colors.red,
        ),
        child: const Text('Press to Start!'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
      ),
    );
  }
}

// buyearのロゴ画像に関するクラス
class StartImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 100,
      child: Image.asset(
        'images/buyear_rogo.jpeg',
        fit: BoxFit.contain,
      ),
    );
  }
}
