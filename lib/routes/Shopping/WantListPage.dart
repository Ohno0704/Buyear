import 'package:flutter_application_1/routes/Chat/Open/BoardListModel.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Shopping/WantListModel.dart';
import 'package:flutter_application_1/routes/Shopping/AddWantListPage.dart';
import 'package:flutter_application_1/routes/Shopping/domain/WantList.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WantListPage extends StatefulWidget {

  @override
  _WantListPageState createState() => _WantListPageState();
}

class _WantListPageState extends State<WantListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WantListModel>(
      create: (_) => WantListModel()..fetchWantList(),
      child: Scaffold(
        appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text("ほしいものリスト"),
            gradient:
              LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
          ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async{
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddWantListPage(),
              )
            );
          },
        ),
        body: Container(
          child: Consumer<WantListModel>(
            builder: (context, model, child) {
              final List<WantList>? wantLists = model.wantLists;

              if (wantLists == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = wantLists
                  .map(
                    (wantList) => Card(
                      child: ListTile(
                        leading: Image.network(wantList.itemURL),
                        title: Text(wantList.title),
                        subtitle: Text(wantList.date),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{
                            //掲示板削除処理
                            // await showConfirmDialog(context, wantList, model);
                          }
                        ),
                        onTap: () {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return OpenChatting(wantList.title);
                          // }));
                        },
                      )
                    ),
                  ).toList();
              return ListView(
                itemExtent: 100,
                children: widgets,
              );
            },
          ),
        )
      )
    );
  }
}

Future showConfirmDialog(BuildContext context, WantList wantList, WantListModel model) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("「${wantList.title}」を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async{
                await model.deleteboard(wantList);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("「${wantList.title}」を削除しました"),
                );
                model.fetchWantList();
                ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
              },
            ),         
          ],
        );
      }
    );
  }
