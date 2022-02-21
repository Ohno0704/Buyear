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
    return Scaffold(
      appBar: AppBar(
        title: Text('チャット'),
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
          Text("ここにユーザーネーム"),
          Text("mail adress:${user.email}"),
          Text("ログアウト"),

        ],
      )
          );
  }
}