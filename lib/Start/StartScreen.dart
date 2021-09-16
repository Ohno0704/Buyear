import 'package:flutter/material.dart';
import 'package:flutter_application_1/Start/LoginPage.dart';
import 'package:flutter_application_1/Start/RegisterPage.dart';


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
            // top: 5.0,
            right: 0.0,
            width: 400.0,
            height: 600.0,
            child: StartImage(),
          ),
          Positioned(
            bottom: 40.0,
            left: 10.0,
            width: 160.0,
            height: 100.0,
            child: LoginButton(),
          ),
          Positioned(
            bottom: 40.0,
            right: 10.0,
            width: 160.0,
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
                  MaterialPageRoute(builder: (context) => LoginPage(),
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

class StartImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/buyear_start.png',
        fit: BoxFit.contain,
        ),
    );
  }
}