import 'package:flutter_application_1/routes/Chat/Open/AddBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    String? userID = userState.userID;
    return ChangeNotifierProvider<AddBoardModel>(
        create: (_) => AddBoardModel(),
        child: Scaffold(
          appBar: NewGradientAppBar(
              title: Text("掲示板を追加"),
              gradient: LinearGradient(colors: [
                Colors.blue.shade200,
                Colors.blue.shade300,
                Colors.blue.shade400
              ])),
          body: Center(
            child: Consumer<AddBoardModel>(builder: (context, model, child) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 32.0,
                      ),
                      // Text("特定の人物名を後悔すること、ダメ"),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        maxLength: 30,
                        decoration: InputDecoration(hintText: '掲示板タイトル'),
                        onChanged: (text) {
                          model.title = text;
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            model.contributorID = userID;
                            model.documentID = model.title;
                            await model.addBoard();
                            Navigator.of(context).pop(true);
                          } catch (e) {
                            final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text("投稿する"),
                      ),
                    ],
                  ));
            }),
          ),
        ));
  }
}
