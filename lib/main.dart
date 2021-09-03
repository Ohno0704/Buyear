import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginPage.dart';

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
      home: MyHomePage(title: 'Welcome to Buyear'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        title: Text('Enjoy University Life With Buyear!'),
      ),
      body: Center(
        child: Column( //Column:縦に並ぶ, Row:横に並ぶ
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Text('Start Buyear'),
            Text(''),
            ElevatedButton(
              child: Text('Log In'),
              onPressed: () async{
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage('Log in to Start!'),
                  ),
                );
                print(result);
              }
            ),
          ],
        ),
      ),
    );
  }
}
