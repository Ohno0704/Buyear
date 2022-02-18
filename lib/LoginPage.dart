import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/root.dart';
// import 'package:flutter_application_1/routes/Home/HomePage.dart';

class LoginPage extends StatelessWidget {
  LoginPage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(widget.title),
      //   title: Text('Enjoy University Life With Buyear!'),
      //   actions: <Widget>[
      //     Icon(Icons.home),
      //   ]
      // ),
      body: Container(
        // height: double.infinity,
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name),
            Text(''),
            Center(
              child: ElevatedButton(
                child: Text('ログイン'),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootWidget(),
                  ),
                );
                  // Navigator.pop(context, 'Buyear');
                },
              )
            )
          ]
        )
      )
    );
  }
}