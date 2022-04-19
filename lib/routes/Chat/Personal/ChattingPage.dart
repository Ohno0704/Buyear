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

import 'domain/Personal.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage(this.friend);

  final Personal friend;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChattingPage> {
  String? contributorID;
  List<types.Message> _messages = [];
  String randomId = Uuid().v4();
  var _user;

  void initState() {
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    _user = types.User(id: myUserId, firstName: '名前');
    _getMessages();
    super.initState();
  }

  // firestoreからメッセージの内容をとってきて_messageにセット
  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.friend.documentId)
        .collection('contents')
        .orderBy("createdAt", descending: true)
        .get();

    final message = getData.docs
        .map(
          (d) => types.TextMessage(
              author: types.User(id: d.data()['uid']),
              createdAt: d.data()['createdAt'],
              id: d.id,
              text: d.data()['message']),
        )
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
        .doc(widget.friend.documentId)
        .collection('contents')
        .add({
      'uid': message.author.id,
      'createdAt': message.createdAt,
      'message': message.text,
    });
  }

  // リンク添付時にリンクプレビューを表示する
  // void _handlePreviewDataFetched(
  //   types.TextMessage message,
  //   types.PreviewData previewData,
  // ) {
  //   final index = _messages.indexWhere((element) => element.id == message.id);
  //   final updatedMessage = _messages[index].copyWith(previewData: previewData);

  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     setState(() {
  //       _messages[index] = updatedMessage;
  //     });
  //   });
  // }

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
          title: Text(widget.friend.name),
          gradient: LinearGradient(colors: [
            Colors.blue.shade200,
            Colors.blue.shade300,
            Colors.blue.shade400
          ])),
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
        // onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}
