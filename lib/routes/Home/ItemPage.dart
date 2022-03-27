import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/root.dart';
import 'package:flutter_application_1/user.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Home/ItemListModel.dart';
import 'package:flutter_application_1/routes/Home/domain/Item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChat.dart';
import 'package:flutter_application_1/routes/Chat/Personal/ChattingPage.dart';
// ランダムなIDを採番してくれるパッケージ
import 'package:uuid/uuid.dart';

// class AccountPage extends StatefulWidget {
//   @override
//   _AccountPageState createState() => _AccountPageState();
// }

class ItemPage extends StatelessWidget {
  ItemPage(this. documentID, this.itemURL, this.price, this.text, this.userName, this.contributorID);

  // 商品情報
  final _itemData = FirebaseFirestore.instance.collection('items');
  String? documentID;
  String? contributorID;
  String? itemURL;
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
        title: Text('商品情報'),
        actions: <Widget>[
          userState.userID == contributorID
          ? IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              // 商品を削除
              showConfirmDialog(context, userName!, documentID!);
            },
          ):Text("")
        ],
      ),
      
      persistentFooterButtons: <Widget>[
        userState.userID != contributorID
        ? Center(
            child: RaisedButton(
                    child: Text('購入するためにフレンドになる'),
                    onPressed: () async{
                      Future<QuerySnapshot> snapshot;
                      snapshot = FirebaseFirestore.instance
                      .collection("chat_room")
                      .where('name', isEqualTo: userName)
                      .get();
                      int document_num = 0;
                      // bool existFriend = true; // すでに追加済みのフレンドか確認する
                      snapshot.then((value) {
                        print(value.docs.length);
                        document_num = value.docs.length;
                        if(document_num == 0) {
                          FirebaseFirestore.instance
                          .collection("chat_room")
                          .add({
                            'name': userName,
                          });
                          showFriendAdd(context, userName!);
                        } else {
                          showExistFriend(context, userName!);
                        }
                      });
                    }
              ),
          ):Center(child: Text(
                      "チャットが来るのを待ちましょう！", 
                      style: TextStyle(
                        // color:  Colors.blue[300],
                        fontSize: 15.0,
                      ),
                    ),)
        ],
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
                    text: "出品者",
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
                    // children: <TextSpan>[
                    //   TextSpan(
                    //     text: "円"
                    //   )
                    // ]
                  ),),
              ]),
            ],
      )
    );

  }
}

Future showConfirmDialog(BuildContext context, String title, String documentID) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("「この商品のを出品を取り消しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async{
                FirebaseFirestore.instance.collection("items").doc(documentID).delete();
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return RootWidget();
                  }),
                );
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("出品を取り消しました"),
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

// フレンド追加前と後でわざわざ二つ関数用意しているバカ
Future showFriendAdd(BuildContext context, String friendName) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("${friendName}をフレンドに追加しました！"),
          content: Text("チャットに移動して交渉してみましょう！"),
          actions: [
            TextButton(
              child: Text("はい"),
              onPressed: () async{
                Navigator.pop(context);
              },
            ),         
          ],
        );
      }
    );
  }

Future showExistFriend(BuildContext context, String friendName) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("${friendName}はすでにフレンドです！"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () async{
                Navigator.pop(context);
              },
            ),         
          ],
        );
      }
    );
  }