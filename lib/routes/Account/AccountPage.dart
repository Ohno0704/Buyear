import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Start/LoginPage.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final name_controller = TextEditingController();
  final introduce_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final String userName = userState.userName!;
    final String userIntroduce = userState.userIntroduce;
    String newUserName = "";
    String newIntroduce = "";

    return Scaffold(
      appBar: NewGradientAppBar(
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
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
            height: 20.0,
          ),
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ユーザーネーム", 
                      style: TextStyle(
                        color:  Colors.blue[300],
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Text(
                  "${userName}",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "ユーザーネームの更新", 
                  style: TextStyle(
                    color:  Colors.blue[300],
                    fontSize: 25.0,
                  ),
                ),
                TextField(
                  controller: name_controller,
                  maxLines: 1,
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
                      newUserName = text;
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('更新'),
                  onPressed: () async{
                    final nameText = name_controller.text;
                    final snackBar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('自己紹介を更新しました！'),
                    );
                    userState.setUserName(nameText);
                    // userState.setIntroduce(newIntroduce);
                    // userIntroduce = userState.userIntroduce;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    name_controller.clear();
                  }
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
                  controller: introduce_controller,
                  maxLines: 3,
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
                    final introduceText = introduce_controller.text;
                    final snackBar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('自己紹介を更新しました！'),
                    );
                    userState.setIntroduce(introduceText);
                    // userState.setIntroduce(newIntroduce);
                    // userIntroduce = userState.userIntroduce;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    introduce_controller.clear();
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