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
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(friend.id),
                        // subtitle: Text(friend.text),
                        onTap: () {
                          // Navigator.of(context)
                          //   .push(MaterialPageRoute(builder: (context) {
                          //     return ChattingPage(friend.id, friend.name);
                          // }));
                        },
                      )
                    ),
                  ).toList();
              return ListView(
                children: widgets,
              );
            },
            // child: Column(
            //   children: [
            //     Expanded(
            //       child: ListView.builder(
            //         itemCount: _massageList.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           fetchUserData();
            //           print(_massageList.length);
            //           return _massageList[index];
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          )
        )
      )
    );
  }
}