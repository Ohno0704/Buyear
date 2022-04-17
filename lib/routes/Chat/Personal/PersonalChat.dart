import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Personal/ChattingPage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChatModel.dart';
import 'package:flutter_application_1/routes/Chat/Personal/domain/Personal.dart';

class PersonalChat extends StatefulWidget {
  PersonalChat({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PersonalChatModel>(
        create: (_) => PersonalChatModel()..fetchPersonalChat(),
        child: Scaffold(body: SafeArea(child: Consumer<PersonalChatModel>(
          builder: (context, model, child) {
            final List<Personal>? friends = model.friends;

            if (friends == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = friends
                .map(
                  (friend) => Card(
                      child: Slidable(
                    // actionPane: SlidableDrawerActionPane(),
                    // actionExtentRatio: 0.20,
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
                          return ChattingPage(friend);
                        }));
                      },
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            showConfirmDialog(context, friend, model);
                          },
                          label: "削除",
                        ),
                      ],
                    ),
                    // secondaryActions: <Widget>[
                    //   IconSlideAction(
                    //     color: Colors.red,
                    //     iconWidget: Text(
                    //       "削除",
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     onTap: () => {}, // _showSnackBar('Delete'),
                    //   ),
                    // ],
                  )),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          },
        ))));
  }
}

Future showConfirmDialog(
    BuildContext context, Personal friend, PersonalChatModel model) {
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
            ),
          ),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                await model.deletefriend(friend);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("「${friend.name}」を削除しました"),
                );
                model.fetchPersonalChat();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      });
}
