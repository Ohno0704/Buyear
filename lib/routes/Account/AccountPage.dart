import 'package:flutter/material.dart';
import 'package:flutter_application_1/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Start/LoginPage.dart';
 
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    final String userName = userState.userName!;
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
      body: Column(
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
                  "自己紹介文", 
                  style: TextStyle(
                    color:  Colors.blue[300],
                    fontSize: 25.0,
                  ),
                ),
                TextField(
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.left,
                  decoration: new InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                  // decoration: InputDecoration.collapsed(
                  //   hintText: "簡単な自己紹介文を決めましょう！"
                  // ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}