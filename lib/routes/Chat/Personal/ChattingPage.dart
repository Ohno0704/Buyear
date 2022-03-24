import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
 // flutter_chat_uiを使うためのパッケージをインポート
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:provider/provider.dart';
// ランダムなIDを採番してくれるパッケージ
import 'package:uuid/uuid.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage(this.name, this.contributorID);

  final String name;
  final String contributorID;
  @override
  _ChatPageState createState() => _ChatPageState(name, contributorID);
}

class _ChatPageState extends State<ChattingPage> {
  String? username;
  _ChatPageState(this.username, contributorID) {
    this.username = username;
    this.contributorID = contributorID;
  }

  String? contributorID;
  List<types.Message> _messages = [];
  String randomId = Uuid().v4();
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c', firstName: '名前');


  void initState() {
    _getMessages();
    super.initState();
  }

  // firestoreからメッセージの内容をとってきて_messageにセット
  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('contents')
        .get();

    final message = getData.docs
        .map((d) => types.TextMessage(
            author:
                types.User(id: d.data()['uid'], firstName: d.data()['name']),
            createdAt: d.data()['createdAt'],
            id: d.data()['id'],
            text: d.data()['text']))
        .toList();

    setState(() {
      _messages = [...message];
    });
  }

  // メッセージ内容をfirestoreにセット
  void _addMessage(types.TextMessage message) async {
    setState(() {
      _messages.insert(0, message);
    });
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('contents')
        .add({
      'uid': message.author.id,
      'name': message.author.firstName,
      'createdAt': message.createdAt,
      'id': message.id,
      'text': message.text,
    });
  }

  // リンク添付時にリンクプレビューを表示する
  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  // メッセージ送信時の処理
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
            author: _user,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: randomId,
            text: message.text,
          );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(username!),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      body: Chat(
        theme: const DefaultChatTheme(
          // メッセージ入力欄の色
          inputBackgroundColor: Colors.blue,
          // 送信ボタン
          sendButtonIcon: Icon(Icons.send),
          sendingIcon: Icon(Icons.update_outlined),
        ),
        // ユーザーの名前を表示するかどうか
        showUserNames: true,
        // メッセージの配列
        messages: _messages,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}