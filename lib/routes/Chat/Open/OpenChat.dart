import 'package:flutter_application_1/routes/Chat/Open/BoardListModel.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Open/AddBoardPage.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Board.dart';
import 'package:provider/provider.dart';

class OpenChat extends StatelessWidget {
  String content = '';
  DateTime now = DateTime.now();
  DateTime appTime = DateTime.now();
  // DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  // String date = outputFormat.format(nowTime);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BoardListModel>(
      create: (_) => BoardListModel()..fetchBoardList(),
      child: Scaffold(
        body: Center(
          child: Consumer<BoardListModel>(
            builder: (context, model, child) {
              final List<Board>? boards = model.boards;

              if (boards == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = boards
                  .map(
                    (board) => ListTile(
                      title: Text(board.title),
                      subtitle: Text(board.date),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async{
                          //掲示板削除処理
                          await showConfirmDialog(context, board, model);
                          // await FirebaseFirestore.instance
                          // .collection('posts')
                          // .doc(boards.id)
                          // .delete();
                        }
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return OpenChatting(board.title);
                        }));
                      },
                    ),
                  ).toList();
              return ListView(
                children: widgets,
              );
            },
          ),
        ),
        floatingActionButton: Consumer<BoardListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async {
      
                final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBoardPage(),
                    fullscreenDialog: true,
                  ),
                );
      
                if(added != null && added) {
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('掲示板を追加しました'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                    
                model.fetchBoardList();
              },
              child: Icon(Icons.mode_edit),
            );
          }
        )
      )
    );
  }

  Future showConfirmDialog(BuildContext context, Board board, BoardListModel model) {
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("「${board.title}」を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async{
                await model.deleteboard(board);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("「${board.title}」を削除しました"),
                );
                model.fetchBoardList();
                ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
              },
            ),         
          ],
        );
      }
    );
  }
}

class OpenChatting extends StatelessWidget {
  String boardTitle = '';

  OpenChatting(String boardTitle) {
    this.boardTitle = boardTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
          title: Text(this.boardTitle),
          gradient: LinearGradient(colors: [
            Colors.blue.shade200,
            Colors.blue.shade300,
            Colors.blue.shade400
          ])),
      body: Center(
        child: Text(
          "$boardTitle",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}