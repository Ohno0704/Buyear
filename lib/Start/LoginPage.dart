/*
ユーザー登録とログインの画面
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/root.dart';
import 'package:flutter_application_1/Start/email_check.dart';
import 'package:flutter_application_1/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<LoginPage> {
  final GlobalKey<FormState> _mail_key = GlobalKey<FormState>();
  final GlobalKey<FormState> _password_key = GlobalKey<FormState>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  // 登録、ログインに関する情報を表示
  String infoText = '';
  String loginInfoText = '';

  String newMailAdress = '';
  String newPassword = '';
  // String newUsername = '';
  String? newUsername;
  String loginMailAdress = '';
  String loginPassword = '';

  String tut_filter = "@tut.jp";

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(bottom: bottomSpace),
                child: Center(
                    child: Container(
                  padding: EdgeInsets.all(32),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 16.0),
                        // ユーザー登録用メールアドレスの入力フォーム
                        Form(
                          key: _mail_key,
                          child: TextFormField(
                            onChanged: (String text) {
                              setState(() {
                                newMailAdress = text;
                              });
                            },
                            validator: (value) {
                              if (!value!.contains(tut_filter)) {
                                return ('学校のメールアドレスを使用してください');
                              }
                            },
                            onSaved: (value) => null,
                            decoration: InputDecoration(
                                labelText: 'メールアドレス（〇〇〇@tut.jp）'),
                          ),
                        ),
                        // ユーザー登録用パスワードの入力フォーム
                        Form(
                          key: _password_key,
                          child: TextFormField(
                            onChanged: (String text) {
                              setState(() {
                                newPassword = text;
                              });
                            },
                            validator: (value) {
                              if (value!.length < 6) {
                                return ('6桁以上のパスワードにしましょう');
                              }
                            },
                            onSaved: (value) => null,
                            decoration:
                                InputDecoration(labelText: 'パスワード（6桁以上）'),
                          ),
                        ),
                        Form(
                          key: _key,
                          child: TextFormField(
                            onChanged: (String text) {
                              setState(() {
                                newUsername = text;
                              });
                            },
                            validator: (value) {
                              if (value!.length == 0 || value.length > 10) {
                                return ('1~10文字のユーザーネームを決めてください');
                              }
                            },
                            onSaved: (value) => null,
                            decoration: InputDecoration(labelText: 'ユーザーネーム'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          // メッセージ表示
                          child: Text(infoText),
                        ),
                        Container(
                          width: double.infinity,
                          // ユーザー登録ボタン
                          child: ElevatedButton(
                            child: Text('ユーザー登録'),
                            onPressed: () async {
                              try {
                                if (!_mail_key.currentState!.validate()) return;
                                _mail_key.currentState!.save();
                                if (!_password_key.currentState!.validate())
                                  return;
                                _password_key.currentState!.save();
                                if (!_key.currentState!.validate()) return;
                                _key.currentState!.save();
                                // メール/パスワードでユーザー登録
                                final FirebaseAuth auth = FirebaseAuth.instance;
                                final result =
                                    await auth.createUserWithEmailAndPassword(
                                  email: newMailAdress,
                                  password: newPassword,
                                );
                                FirebaseFirestore.instance
                                    .collection('user')
                                    .add({
                                  'email': newMailAdress,
                                  'password': newPassword,
                                  'userName': newUsername,
                                  'userID': result.user!.uid,
                                });
                                // ユーザー情報を新規作成
                                userState.setUser(result.user!);
                                userState.setUserName(newUsername!);
                                userState.setUserID(result.user!.uid);

                                // Email確認のメールを送信
                                result.user!.sendEmailVerification();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Emailcheck(
                                          email: newMailAdress,
                                          pswd: newPassword,
                                          from: 2)),
                                );

                                // // Email確認が済んでいる場合
                                // if (result.user!.emailVerified) {
                                //   // チャット画面に遷移＋ログイン画面を破棄
                                //   await Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(builder: (context) {
                                //       return RootWidget();
                                //     }),
                                //   );
                                // } else {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => Emailcheck(
                                //           email: newMailAdress,
                                //           pswd: newPassword,
                                //           from: 2)),
                                // );
                                // }
                              } catch (e) {
                                // ユーザー登録に失敗した場合
                                setState(() {
                                  infoText = "登録に失敗しました";
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'メールアドレス'),
                          onChanged: (String text) {
                            setState(() {
                              loginMailAdress = text;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'パスワード'),
                          // パスワードが見えないようにする
                          obscureText: true,
                          onChanged: (String text) {
                            setState(() {
                              loginPassword = text;
                            });
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          // メッセージ表示
                          child: Text(loginInfoText),
                        ),
                        Container(
                          width: double.infinity,
                          // ログイン登録ボタン
                          child: ElevatedButton(
                            child: Text('ログイン'),
                            onPressed: () async {
                              try {
                                // メール/パスワードでログイン
                                final FirebaseAuth auth = FirebaseAuth.instance;
                                final loginResult =
                                    await auth.signInWithEmailAndPassword(
                                  email: loginMailAdress,
                                  password: loginPassword,
                                );
                                final uid = loginResult.user!.uid;
                                // ユーザー情報を更新
                                final QuerySnapshot userSnapshot =
                                    await FirebaseFirestore.instance
                                        .collection("user")
                                        .where("userID", isEqualTo: uid)
                                        .get();
                                final userProfile = userSnapshot.docs.first
                                    .data() as Map<String, dynamic>;
                                final loginUserName = userProfile["userName"];
                                userState.setUser(loginResult.user!);
                                userState.setUserName(loginUserName!);
                                userState.setUserID(uid);

                                // Email確認が済んでいる場合
                                // チャット画面に遷移＋ログイン画面を破棄
                                if (loginResult.user!.emailVerified) {
                                  await Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                      return RootWidget();
                                    }),
                                  );
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Emailcheck(
                                              email: loginMailAdress,
                                              pswd: loginPassword,
                                              from: 2)));
                                }
                              } catch (e) {
                                // ログインに失敗した場合
                                setState(() {
                                  loginInfoText = "ログインに失敗しました";
                                });
                              }
                              // ログイン失敗時のエラーメッセージ
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          child: Text('上記メールアドレスにパスワード再設定メールを送信'),
                          onPressed: () => _auth.sendPasswordResetEmail(
                              email: loginMailAdress),
                        ),
                      ]),
                )))));
  }
}
