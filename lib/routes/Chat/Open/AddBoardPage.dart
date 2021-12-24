import 'package:flutter_application_1/routes/Chat/Open/AddBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
 
class AddBoardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBoardModel>(
      create: (_) => AddBoardModel(),
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text("掲示板を追加"),
          gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
        ),
        body: Center(
          child: Consumer<AddBoardModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'タイトル'
                    ),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: '時間'
                  //   ),
                  //   onChanged: (text) {
                  //     model.date = text;
                  //   },
                  // ),
                  SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: () async{

                      try {
                        await model.addBoard();
                        Navigator.of(context).pop(true);
                      } catch(e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString())
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("投稿する"),
                  ),
                ],
              )
            );
          }),
        ),
      )
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
 
// class AddBoard2 extends StatelessWidget {
//   TextEditingController _textEditingController = TextEditingController();
//   final data = DateTime.now().toLocal().toIso8601String();

//   _onSubmitted(String content){
//     CollectionReference posts = FirebaseFirestore.instance.collection('posts');
//     posts.add({
//       "content": content
//     });
    
//     /// 入力欄をクリアにする
//     _textEditingController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: NewGradientAppBar(
//         centerTitle: true,
//         title: Text("掲示板に投稿しよう！"),
//         gradient:
//           LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
//       ),
//       body: Center(
//         child: TextField(
//           controller: _textEditingController,
//           onSubmitted: _onSubmitted,
//           enabled: true,
//           maxLength: 50, // 入力数
//           maxLengthEnforced: false, // 入力上限になったときに、文字入力を抑制するか
//           style: TextStyle(color: Colors.black),
//           obscureText: false,
//           maxLines:1 ,
//           decoration: const InputDecoration(
//             icon: Icon(Icons.speaker_notes),
//             hintText: '投稿内容を記載します',
//             labelText: '投稿内容 * ',
//           ),
//         ),
//       ),
//     );
//   }
// }


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

// class AddBoard2 extends StatefulWidget {
//   // 引数からユーザー情報を受け取る
//   AddBoard2(this.user);
//   // ユーザー情報
//   final User user;

//   @override
//   _AddPostPageState createState() => _AddPostPageState();
// }

// class _AddPostPageState extends State<AddBoard2> {
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