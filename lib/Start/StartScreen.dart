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
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            // top: 5.0,
            right: 0.0,
            width: 420.0,
            height: 500.0,
            child: StartImage(),
          ),
          Positioned(
            bottom: 50.0,
            left: 125.0,
            width: 150.0,
            height: 50.0,
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
        child: const Text('Press to Start!'),
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(),
                  ),
                );
              },
      ),
    );
    //   child: RaisedButton(
    //     child: Text('Lets Start!'),
    //     onPressed: () async{
    //             await Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => LoginPage(),
    //               ),
    //             );
    //           },
    //   ),
    // );
  }
}


class StartImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      child: Image.asset(
        'images/buyear_rogo.jpeg',
        fit: BoxFit.contain,
        ),
    );
  }
}