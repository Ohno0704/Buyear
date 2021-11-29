import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Open/AddBoard.dart';
 
class OpenChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Card(
                child: ListTile(
                  title: Text(document['content']),
                  subtitle: Text("サブタイトル"),
                  onTap:() {
                    //オープンチャットへ移動
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
              child: Icon(Icons.mode_edit),
              onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AddBoard2();
                  }));
              },
      ),
    );
  }
}

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