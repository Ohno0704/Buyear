import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
 
class AddBoard2 extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();
  final data = DateTime.now().toLocal().toIso8601String();

  _onSubmitted(String content){
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    posts.add({
      "content": content
    });
    
    /// 入力欄をクリアにする
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("掲示板に投稿しよう！"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      body: Center(
        child: TextField(
          controller: _textEditingController,
          onSubmitted: _onSubmitted,
          enabled: true,
          maxLength: 50, // 入力数
          maxLengthEnforced: false, // 入力上限になったときに、文字入力を抑制するか
          style: TextStyle(color: Colors.black),
          obscureText: false,
          maxLines:1 ,
          decoration: const InputDecoration(
            icon: Icon(Icons.speaker_notes),
            hintText: '投稿内容を記載します',
            labelText: '投稿内容 * ',
          ),
        ),
      ),
    );
  }
}

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