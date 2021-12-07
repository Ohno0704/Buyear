import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/routes/Chat/Open/BoardListModel.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Open/AddBoard.dart';
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
          child: Consumer<BoardListModel>(builder: (context, model, child) {
            final List<Board>? boards = model.boards;

            if(boards == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = boards
            .map(
              (board) => ListTile(
                title: Text(board.title), 
                subtitle: Text(board.date),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return OpenChatting(board.title);
                  }));
                },
              ),
            ).toList();
            return ListView(
              children: widgets,
            );
          },),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.mode_edit),
          onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              appTime = now;
              return AddBoard2();
              }));
          },
        ),
      )
    );
  }
}

class OpenChatting extends StatelessWidget {
  String boardTitle = '';
 
  OpenChatting(String boardTitle) {
    this.boardTitle = boardTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(this.boardTitle),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      body: Center(
        child: Text(
          "$boardTitle",
          style: TextStyle(
            fontSize: 20,
            ),
        ),
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.
//         collection("posts")
//         .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               return Card(
//                 child: ListTile(
//                   title: Text(document['content']),
//                   subtitle: Text('${appTime.year}/${appTime.month}/${appTime.day}'),
//                   onTap:() {
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                     return OpenChatting(document['content']);
//                     }));
//                   },
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),

// class OpenChat extends StatelessWidget {
  
//   OpenChat(this.user);
//   final User user;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         // ユーザー情報を表示
//         child: Text('ログイン情報：${user.email}'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () async {
//           // 投稿画面に遷移
//           await Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) {
//               // 引数からユーザー情報を渡す
//               return AddBoard(user);
//             }),
//           );
//         },
//       ),
//     );
//   }
// }

// class AddBoard extends StatefulWidget {
//   // 引数からユーザー情報を受け取る
//   AddBoard(this.user);
//   // ユーザー情報
//   final User user;

//   @override
//   _AddPostPageState createState() => _AddPostPageState();
// }

// class _AddPostPageState extends State<AddBoard> {
//   // 入力した投稿メッセージ
//   String messageText = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('チャット投稿'),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // 投稿メッセージ入力
//               TextFormField(
//                 decoration: InputDecoration(labelText: '投稿メッセージ'),
//                 // 複数行のテキスト入力
//                 keyboardType: TextInputType.multiline,
//                 // 最大3行
//                 maxLines: 3,
//                 onChanged: (String value) {
//                   setState(() {
//                     messageText = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   child: Text('投稿'),
//                   onPressed: () async {
//                     final date =
//                         DateTime.now().toLocal().toIso8601String(); // 現在の日時
//                     final email = widget.user.email; // AddPostPage のデータを参照
//                     // 投稿メッセージ用ドキュメント作成
//                     await FirebaseFirestore.instance
//                         .collection('posts') // コレクションID指定
//                         .doc() // ドキュメントID自動生成
//                         .set({
//                       'text': messageText,
//                       'email': email,
//                       'date': date
//                     });
//                     // 1つ前の画面に戻る
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }