import 'package:flutter_application_1/routes/Chat/Open/BoardListModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

 // flutter_chat_uiを使うためのパッケージをインポート
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// ランダムなIDを採番してくれるパッケージ
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Open/AddBoardPage.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Board.dart';
import 'package:provider/provider.dart';

class OpenChat extends StatelessWidget {
  String content = '';
  DateTime now = DateTime.now();
  DateTime appTime = DateTime.now();
  // DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  // String date = outputFormat.format(nowTime);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BoardListModel>(
      create: (_) => BoardListModel()..fetchBoardList(),
      child: Scaffold(
        body: Center(
          child: Consumer<BoardListModel>(
            builder: (context, model, child) {
              final List<Board>? boards = model.boards;

              if (boards == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = boards
                  .map(
                    (board) => ListTile(
                      title: Text(board.title),
                      subtitle: Text(board.date),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async{
                          //掲示板削除処理
                          await showConfirmDialog(context, board, model);
                          // await FirebaseFirestore.instance
                          // .collection('posts')
                          // .doc(boards.id)
                          // .delete();
                        }
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return OpenChatting(board.title);
                        }));
                      },
                    ),
                  ).toList();
              return ListView(
                children: widgets,
              );
            },
          ),
        ),
        floatingActionButton: Consumer<BoardListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async {
      
                final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBoardPage(),
                    fullscreenDialog: true,
                  ),
                );
      
                if(added != null && added) {
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('掲示板を追加しました'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                    
                model.fetchBoardList();
              },
              child: Icon(Icons.mode_edit),
            );
          }
        )
      )
    );
  }

  Future showConfirmDialog(BuildContext context, Board board, BoardListModel model) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("「${board.title}」を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async{
                await model.deleteboard(board);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("「${board.title}」を削除しました"),
                );
                model.fetchBoardList();
                ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
              },
            ),         
          ],
        );
      }
    );
  }
}

// 更新可能なデータ
class UserState extends ChangeNotifier {
  User? user;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}

class OpenChatting extends StatefulWidget {
  const OpenChatting(this.boardTitle, {Key? key}) : super(key: key);
  final String boardTitle;

  @override
  _OpenChatPageState createState() => _OpenChatPageState(boardTitle);
}

class _OpenChatPageState extends State<OpenChatting> {
  String boardTitle = '';
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c', firstName: '名前');
  // final UserState _user = UserState();
  String randomId = Uuid().v4();

  _OpenChatPageState(this.boardTitle) {
    this.boardTitle = boardTitle;
  }

  void initState() {
    _getMessages();
    super.initState();
  }

  // firestoreからメッセージの内容をとってきて_messageにセット
  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection('board_room')
        .doc(widget.boardTitle)
        .collection('boardTitle')
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
        .collection('board_room')
        .doc(widget.boardTitle)
        .collection('boardTitle')
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

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        // id: randomString(),
        id: randomId,
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      // _addMessage(message); //TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState> (
      create: (context) => UserState(),
      child: Scaffold(
        appBar: NewGradientAppBar(
            title: Text(this.boardTitle),
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
          showUserNames: false,

          onAttachmentPressed: _handleImageSelection,

          // メッセージの配列
          messages: _messages,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      )
    );
  }
}