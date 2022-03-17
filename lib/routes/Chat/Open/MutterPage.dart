import 'package:flutter_application_1/routes/Chat/Open/MutterListModel.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Mutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

 // flutter_chat_uiを使うためのパッケージをインポート
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MutterPage extends StatefulWidget {
  MutterPage(this.boardTitle);
  String boardTitle;
  @override
  _MutterPageState createState() => _MutterPageState(boardTitle);
}

class _MutterPageState extends State<MutterPage> {
  _MutterPageState(String boardTitle) {
    this.boardTitle = boardTitle;
  }

  String boardTitle = '';
  String? comment;
  String? date;
  String? contributorID;

    // メッセージ内容をfirestoreにセット
  void _addMutter() async {
    // setState(() {
    //   _messages.insert(0, message);
    // });
    await FirebaseFirestore.instance
        .collection('mutter')
        .doc('コメント一覧')
        .collection('コメント')
        .add({
      'comment': comment,
      'contributorID': contributorID,
      'date': DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    return ChangeNotifierProvider<MutterListModel>(
      create: (_) => MutterListModel()..fetchMutterList(),
      child: Scaffold(
        appBar: NewGradientAppBar(
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
        title: Text('${boardTitle}'),
        ),
        body: Center(
          child: Consumer<MutterListModel>(
            builder: (context, model, child) {
              final List<Mutter>? mutters = model.mutters;

              if (mutters == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = mutters
                  .map(
                    (mutter) => ListTile(
                        title: Text(mutter.comment),
                        subtitle: Text(mutter.date),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{
                            //掲示板削除処理
                            // await showConfirmDialog(context, board, model);
                          }
                        ),
                        // onTap: () {
                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: (context) {
                        //     return BoardPage(board.title);
                        //   }));
                        // },
                      )
                  ).toList();
              return ListView(
                children: widgets,
              );
            },
          ),
        ),
        persistentFooterButtons: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: ElevatedButton(
                child: Icon(Icons.send),
                onPressed: () {

                },
              )
            ),
          ),
        ],
      )
    );
  }
}