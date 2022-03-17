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

import 'dart:async';

class MutterPage extends StatefulWidget {
  MutterPage(this.documentID, this.boardTitle);
  String documentID;
  String boardTitle;
  @override
  _MutterPageState createState() => _MutterPageState(documentID, boardTitle);
}

class _MutterPageState extends State<MutterPage> {
  _MutterPageState(String documentID, String boardTitle) {
    this.documentID = documentID;
    this.boardTitle = boardTitle;
  }

  String? documentID;
  String? boardTitle;
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
        .doc('${boardTitle}')
        .collection('コメント')
        .add({
      'comment': comment,
      'contributorID': contributorID,
      'date': DateTime.now().toIso8601String(),
    });
  }

  final messageTextInputCtl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();

  void _addMessage(String _comment) {
    setState(() {
      FirebaseFirestore.instance
        .collection('mutter')
        .doc('${boardTitle}')
        .collection('コメント')
        .add({
          'comment': _comment,
          'contributorID': contributorID,
          'date': DateTime.now().toIso8601String(),
        });
    });
  }

  void _scrollToBottom(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + MediaQuery.of(context).viewInsets.bottom,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    contributorID = userState.userID;
    return ChangeNotifierProvider<MutterListModel>(
      create: (_) => MutterListModel()..fetchMutterList(boardTitle!),
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
                        // documentID = mutter.id;
                        // onTap: () {
                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: (context) {
                        //     return BoardPage(board.title);
                        //   }));
                        // },
                      )
                  ).toList();
              return Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  ListView(
                    controller: _scrollController,
                    children: widgets,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      new Container(
                        color: Colors.green[100],
                        child: Column(
                          children: <Widget>[
                            new Form(
                              key: _formKey, 
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      controller: messageTextInputCtl,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      decoration: const InputDecoration(
                                        hintText: 'コメントを入力してください',
                                      ),
                                      onTap: (){
                                        // タイマーを入れてキーボード分スクロールする様に
                                        Timer(
                                          Duration(milliseconds: 200),
                                          _scrollToBottom,
                                        );
                                      },
                                    )
                                  ),
                                  Material(
                                    color: Colors.green[100],
                                    child: Center(
                                      child: Ink(
                                        decoration: const ShapeDecoration(
                                          color: Colors.green,
                                            shape: CircleBorder(),
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.send),
                                            color: Colors.white,
                                            onPressed: () {
                                              _addMessage(messageTextInputCtl.text);
                                              FocusScope.of(context).unfocus();
                                              messageTextInputCtl.clear();
                                              Timer(
                                                Duration(milliseconds: 200),
                                                _scrollToBottom,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ]
                                )
                              ),
                            ]
                          )
                        ),
                      ],
                    )

                ]
              );
            },
          ),
        ),
      )
    );
  }
}