import 'package:flutter/material.dart';
import 'package:flutter_application_1/user.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_application_1/routes/Chat/Personal/PersonalChat.dart';
// ランダムなIDを採番してくれるパッケージ
import 'package:uuid/uuid.dart';

// class AccountPage extends StatefulWidget {
//   @override
//   _AccountPageState createState() => _AccountPageState();
// }

class WantItemPage extends StatelessWidget {
  WantItemPage(this. documentID, this.contributorID, this.date, this.itemURL, this.price, this.text, this. itemName, this.userName);

  // 商品情報
  final _itemData = FirebaseFirestore.instance.collection('wantList');
  String? documentID;
  String? itemName;
  String? contributorID;
  String? itemURL;
  String? date;
  String? price;
  String? text;
  String? userName;
  String randomId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    // final User user = userState.user!;
    String? userID = userState.userID;
    return Scaffold(
      appBar: NewGradientAppBar(
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
        title: Text("aaa"),// Text('${itemName}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              // 商品を削除
            },
          ),
        ],
      ),
        body: Column(
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 300.0,
                  child: Image.network(
                    itemURL!,
                    fit: BoxFit.contain,
                    ),
                )
              ),
              // 価格
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                    text: price!,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.red,
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
              // 商品の説明
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                    text: "商品の説明",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                    text: text!,
                    style: TextStyle(
                      fontSize: 20,
                      // color: Colors.red,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),),
              ]),
              // 出品者情報
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                    text: "希望者",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                    text: userName!,
                    style: TextStyle(
                      fontSize: 20,
                      // color: Colors.red,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),),
              ]),
            ],
      )
    );

  }
}