import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/root.dart';
// import 'package:flutter_application_1/routes/Home/HomePage.dart';

class LoginPage extends StatelessWidget {
  // LoginPage(this.name);
  // final String name;
  String infoText = '';
  // String univercity = '';
  String mailAdress = '';
  String password = '';
  String nickname = '';
  // List<String> _uniNames = ["豊橋技術科学大学", "その他"];
  // String _selectedItem = "豊橋技術科学大学";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TextFormField(
              //   decoration: InputDecoration(labelText: '大学名'),
              //   onChanged: (String text) {
              //     univercity = text;
              //   },
              // ),
              // DropdownButton<String>(
              //   value: _selectedItem,
              //   // onChanged: () {
              //     // setState(() {
              //     //   _selectedItem = newValue;
              //     // });
              //   // },
              //   selectedItemBuilder: (context) {
              //     return _uniNames.map((String item) {
              //       return Text(
              //         item,
              //         style: TextStyle(color: Colors.pink),
              //       );
              //     }).toList();
              //   },
              //   items: _uniNames.map((String item) {
              //     return DropdownMenuItem(
              //       value: item,
              //       child: Text(
              //         item,
              //         style: item == _selectedItem
              //             ? TextStyle(fontWeight: FontWeight.bold)
              //             : TextStyle(fontWeight: FontWeight.normal),
              //       ),
              //     );
                // }).toList(),
                // ),
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス（〇〇〇@tut.jp）'),
                onChanged: (text) {
                  mailAdress = text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (text) {
                  password = text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ニックネーム'),
                onChanged: (text) {
                  nickname = text;
                },
              ),
              Text(""),
              Container(
                  width: double.infinity,
                  // ユーザー登録ボタン
                  child: ElevatedButton(
                    child: Text('ユーザー登録'),
                    onPressed: () async {
                      try {//TODO ログイン機能追加後
                        // メール/パスワードでユーザー登録
                        // final FirebaseAuth auth = FirebaseAuth.instance;
                        // await auth.createUserWithEmailAndPassword(
                        //   email: mailAdress,
                        //   password: password,
                        // );
                        // ユーザー登録に成功した場合
                        // チャット画面に遷移＋ログイン画面を破棄
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return RootWidget();
                          }),
                        );
                      } catch (e) {
                        // ユーザー登録に失敗した場合
                        // setState(() {
                          infoText = "登録に失敗しました：${e.toString()}";
                        // });
                      }
                    },
                  ),
              ),
              Container(
                width: double.infinity,
                // ログイン登録ボタン
                child: OutlinedButton(
                  child: Text('ログイン'),
                  onPressed: () async {
                    try {//TODO ログイン機能追加後
                      // メール/パスワードでログイン
                      // final FirebaseAuth auth = FirebaseAuth.instance;
                      // await auth.signInWithEmailAndPassword(
                      //   email: mailAdress,
                      //   password: password,
                      // );
                      // ログインに成功した場合
                      // チャット画面に遷移＋ログイン画面を破棄
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return RootWidget();
                        }),
                      );
                    } catch (e) {
                      // ログインに失敗した場合
                      // setState(() {
                        infoText = "ログインに失敗しました：${e.toString()}";
                      // });
                    }
                  },
                ),
              )
            ],
          ),
        )
      )
    );
  }
}

// 予備
 // ButtonTheme(
              //   minWidth: 100,
              //   height: 60,
              //   child:RaisedButton(
              //     child: Text('新規登録'),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => RootWidget(),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // Text(""),
              // ButtonTheme(
              //   minWidth: 100,
              //   height: 60,
              //   child:RaisedButton(
              //     child: Text('ログイン'),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => RootWidget(),
              //         ),
              //       );
              //     },
              //   ),
              // ),