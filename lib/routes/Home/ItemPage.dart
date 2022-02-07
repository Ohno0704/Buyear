import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Home/HomePage.dart';
import 'package:flutter_application_1/routes/root.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChat.dart';
import 'package:flutter_application_1/routes/Chat/ChatPage.dart';

// class ItemPageAndAddFriend extends StatefulWidget {
//   ItemPageAndAddFriend(this._index);
//   int _index = 0;
//   @override
//   ItemPage createState() => ItemPage(_index);
// } 
// class ItemPage extends State<ItemPageAndAddFriend> {
  // ItemPage(this._index);
class ItemPage extends StatelessWidget {
  ItemPage(this.itemURL, this.price);
  String? itemURL;
  String? price;
  int _index = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("商品情報"),
        actions: [
          IconButton(
            onPressed: () {
              showConfirmDialog(context);
            },
            icon: Icon(Icons.delete))
        ],
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
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
                  fontWeight: FontWeight.bold,
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

Future showConfirmDialog(BuildContext context) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("この商品の出品を取り消しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async{
                deleteItem();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootWidget(),
                  ),
                );
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("商品を削除しました"),
                );
                ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
              },
            ),         
          ],
        );
      }
    );
  }

Future deleteItem() async{
  String id = FirebaseFirestore.instance.collection('items').doc().id;
  return await FirebaseFirestore.instance.collection("items").doc(id).delete();
}