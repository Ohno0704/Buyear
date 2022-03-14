import 'package:flutter_application_1/routes/Chat/Open/MutterListModel.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Mutter.dart';
import 'package:flutter_application_1/routes/Chat/Open/BoardPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoardPage extends StatefulWidget {
  BoardPage(this.boardTitle);
  String boardTitle;
  @override
  _BoardPageState createState() => _BoardPageState(boardTitle);
}

class _BoardPageState extends State<BoardPage> {
  String boardTitle = '';

  _BoardPageState(String boardTitle) {
    this.boardTitle = boardTitle;
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    return ChangeNotifierProvider<MutterListModel>(
      create: (_) => MutterListModel()..fetchMutterList(),
      child: Scaffold(
        appBar: NewGradientAppBar(
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
        title: Text('${boardTitle}'),
        ),
        body: Center(
          child: Consumer<MutterListModel>(
            builder: (context, model, child) {
              final List<Mutter>? mutters = model.mutters;

              if (mutters == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = mutters
                  .map(
                    (mutter) => ListTile(
                        title: Text(mutter.comment),
                        subtitle: Text(mutter.date),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{
                            //掲示板削除処理
                            // await showConfirmDialog(context, board, model);
                          }
                        ),
                        // onTap: () {
                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: (context) {
                        //     return BoardPage(board.title);
                        //   }));
                        // },
                      )
                  ).toList();
              return ListView(
                children: widgets,
              );
            },
          ),
        )
      )
    );
  }
}