import 'package:flutter/material.dart';
import 'package:flutter_application_1/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Start/LoginPage.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    // final User user = userState.user!;
    final String userName = userState.userName!;
    final String userIntroduce = userState.userIntroduce;
    // String userIntroduce = "初めまして！";
    String newIntroduce = "";

    return Scaffold(
      appBar: AppBar(
        title: Text('アカウント情報'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // ログアウト処理
              // 内部で保持しているログイン情報等が初期化される
              await FirebaseAuth.instance.signOut();
              // ログイン画面に遷移＋チャット画面を破棄
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }),
              );

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "ユーザーネーム", 
                  style: TextStyle(
                    color:  Colors.blue[300],
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${userName}",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "自己紹介", 
                  style: TextStyle(
                    color:  Colors.blue[300],
                    fontSize: 25.0,
                  ),
                ),
                Text(
                  "${userIntroduce}", 
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "自己紹介の更新", 
                  style: TextStyle(
                    color:  Colors.blue[300],
                    fontSize: 25.0,
                  ),
                ),
                TextField(
                  controller: myController,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.left,
                  decoration: new InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                  onChanged: (text){
                    setState(() {
                      newIntroduce = text;
                    });
                  },
                  // decoration: InputDecoration.collapsed(
                  //   hintText: "簡単な自己紹介文を決めましょう！"
                  // ),
                ),
                ElevatedButton(
                  child: Text('更新'),
                  onPressed: () async{
                    final hobbyText = myController.text;
                    final snackBar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('自己紹介を更新しました！'),
                    );
                    userState.setIntroduce(hobbyText);
                    // userState.setIntroduce(newIntroduce);
                    // userIntroduce = userState.userIntroduce;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                ),
              ],
            ),
          ),
        ],
      )
    )
    );
  }
}

// Future showConfirmDialog(BuildContext context, String text, UserState userState) {
//     return showDialog(
//       context: context, 
//       barrierDismissible: false,
//       builder: (_) {
//         return AlertDialog(
//           title: Text("更新しました！"),
//           content: Text("「${board.title}」を削除しますか？"),
//           actions: [
//             TextButton(
//               child: Text("いいえ"),
//               onPressed: () => Navigator.pop(context),
//             ),
//             TextButton(
//               child: Text("はい"),
//               onPressed: () async{
//                 await model.deleteboard(board);
//                 Navigator.pop(context);
//                 final snackBar = SnackBar(
//                   backgroundColor: Colors.red,
//                   content: Text("「${board.title}」を削除しました"),
//                 );
//                 model.fetchBoardList();
//                 ScaffoldMessenger.of(context)
//                 .showSnackBar(snackBar);
//               },
//             ),         
//           ],
//         );
//       }
//     );
//   }
// }