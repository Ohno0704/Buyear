import 'package:flutter/material.dart';
import 'package:flutter_application_1/user.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemPage extends StatelessWidget {
  ItemPage(this.itemURL, this.price, this.contributor);
  String? itemURL;
  String? price;
  String? contributor;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("${user.email}"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
        actions: [
          // contributor == user.email
          // ? IconButton(
          //   onPressed: () {
          //     FirebaseFirestore.instance.collection("posts").doc(board.id).delete();
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => MyPage(),
          //         ),
          //       );
          //   },
          //   icon: Icon(Icons.account_circle))
        ],
      ),
      persistentFooterButtons: <Widget>[
        Center(
          child: RaisedButton(
                  child: Text('購入するため個人チャットへ'),
                  onPressed: () async{
                  }
            ),
        )
      ],
      body: Column(
        children: <Widget>[
          Center(
            child: Expanded(
              child: Image.network(
                itemURL!,
                fit: BoxFit.contain,
                ),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                text: price!,
                style: TextStyle(
                  fontSize: 30,
                  // color: Colors.red,
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "円"
                  )
                ]
              ),),
          ]),
        ],
      )
      
      
    );
  }
}