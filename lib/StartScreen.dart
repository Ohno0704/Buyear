import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginPage.dart';
import 'package:flutter_application_1/RegisterPage.dart';


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
      appBar: AppBar(
        // title: Text(widget.title),
        title: Text('Enjoy University Life With Buyear!'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 10.0,
            left: 10.0,
            width: 200.0,
            height: 100.0,
            child: LoginButton(),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            width: 200.0,
            height: 100.0,
            child: RegisterButton(),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('Log in'),
        onPressed: () async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(''),
                  ),
                );
              },
      ),
      // alignment: Alignment(1.0, 1.0),
      // color: Colors.lightBlue,
      // child: Text('Log in'),
    );
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('Register'),
        onPressed: () async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage('Register to Start!'),
                  ),
                );
              },
      ),
      // alignment: Alignment(1.0, 1.0),
      // color: Colors.lightBlue,
      // child: Text('Log in'),
    );
  }
}