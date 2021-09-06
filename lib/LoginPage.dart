import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/root.dart';
// import 'package:flutter_application_1/routes/Home/HomePage.dart';

class LoginPage extends StatelessWidget {
  // LoginPage(this.name);
  // final String name;
  String maleAdress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: '〇〇〇@gmail.com'
              ),
              onChanged: (text) {
                maleAdress = text;
                // print("メールアドレスは $text");
              },
            ),
            Text(''),
            RaisedButton(
              child: Text('ログイン'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RootWidget(),
                  ),
                );
              },
            )
          ],
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Center(
        //       child: ElevatedButton(
        //         child: Text('ログイン'),
        //         onPressed: () {
        //           Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => RootWidget(),
        //           ),
        //         );
        //           // Navigator.pop(context, 'Buyear');
        //         },
        //       )
        //     )
        //   ]
        // )
      )
    );
  }
}