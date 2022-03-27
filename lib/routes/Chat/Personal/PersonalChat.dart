import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Personal/ChattingPage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChatModel.dart';
import 'package:flutter_application_1/routes/Chat/Personal/domain/Personal.dart';

class Tile extends StatelessWidget {

  IconData icon = Icons.visibility_off;
  String username = " ";
  String message = " ";

  Tile(IconData icon, String username, String message) {
    this.icon = icon;
    this.username = username;
    this.message = message;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable( //TODO
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(this.icon), // <- 追加：アイコンの設定
            backgroundColor: Colors.pink,
          ),
          title: Text(this.username), // <- 追加：ユーザ名の設定
          subtitle: Text(this.message), // <- 追加：メッセージの設定
          onTap: () => {
            // Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => Chatting(this.username)))
          },
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.red,
          iconWidget: Text(
            "削除",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () => {}, // _showSnackBar('Delete'),
        ),
      ],
    );
  }
}

class PersonalChat extends StatefulWidget {
  PersonalChat({Key? key}) : super(key: key);

  Tile friends = Tile(
        Icons.person,
        "初期化初期太郎222",
        "I am initializer",
        );

  @override
  _PersonalChatState createState() => new _PersonalChatState(false);
}

class _PersonalChatState extends State<PersonalChat> {
  _PersonalChatState(this.isAdd);

  // Tile friends = Tile(
  //       Icons.person,
  //       "初期化初期太郎222",
  //       "I am initializer",
  //       );
    
  bool isAdd = true;

  List<Tile> _massageList = [
    Tile(
        Icons.person,
        "初期化初期太郎",
        "I am initializer",
        ),
  ];

  fetchFriendList() async {
    
    return _massageList;
  }

  fetchUserData() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final userName = _firebaseAuth.currentUser!.uid;
    // final _userName = docu
    DocumentSnapshot snapshot = await _firestore.doc('chat_room/${userName}').get();
    // print(snapshot.data()['email']);
    Tile friends = Tile(
      Icons.person,
      "${userName}",
      "I am initializer",
    );
    _massageList.add(friends);
    return snapshot.data();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PersonalChatModel>(
      create: (_) => PersonalChatModel()..fetchPersonalChat(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<PersonalChatModel>(
            builder: (context, model, child) {
              final List<Personal>? friends = model.friends;

              if (friends == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = friends
                  .map(
                    (friend) => Card(
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.20,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person), // <- 追加：アイコンの設定
                            backgroundColor: Colors.pink,
                          ),
                          title: Text(friend.name),
                          // subtitle: Text(friend.text),
                          onTap: () {
                            Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                                return ChattingPage(friend.id, friend.name);
                            }));
                          },
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            color: Colors.red,
                            iconWidget: Text(
                              "削除",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () => {
                              showConfirmDialog(context, friend, model)
                            }, // _showSnackBar('Delete'),
                          ),
                        ],
                      )
                    ),
                  ).toList();
              return ListView(
                children: widgets,
              );
            },
          )
        )
      )
    );
  }
}

Future showConfirmDialog(BuildContext context, Personal friend, PersonalChatModel model) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("${friend.name}とのチャットを削除しますか？"),
          content: Text.rich(
                    TextSpan(
                    text: "${friend.name}が再度出品するまでチャットできなくなります！",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async{
                await model.deletefriend(friend);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("「${friend.name}」を削除しました"),
                );
                model.fetchPersonalChat();
                ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
              },
            ),         
          ],
        );
      }
    );
  }