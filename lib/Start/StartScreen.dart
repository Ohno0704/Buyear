import 'package:flutter/material.dart';
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
      appBar: AppBar(
        // title: Text(widget.title),
        title: Text('Enjoy University Life With Buyear!'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            // top: 5.0,
            right: 0.0,
            width: 450.0,
            height: 600.0,
            child: StartImage(),
          ),
          Positioned(
            bottom: 20.0,
            left: 90.0,
            width: 200.0,
            height: 120.0,
            child: LoginButton(),
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
        child: Text('Lets Start!'),
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


class StartImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 220,
      child: Image.asset(
        'images/buyear_start.png',
        fit: BoxFit.contain,
        ),
    );
  }
}