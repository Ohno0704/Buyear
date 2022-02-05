import 'package:flutter_application_1/routes/Chat/Open/AddBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
 
class AddBoardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBoardModel>(
      create: (_) => AddBoardModel(),
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text("掲示板を追加"),
          gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
        ),
        body: Center(
          child: Consumer<AddBoardModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'タイトル'
                    ),
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
                    onPressed: () async{

                      try {
                        await model.addBoard();
                        Navigator.of(context).pop(true);
                      } catch(e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString())
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("投稿する"),
                  ),
                ],
              )
            );
          }),
        ),
      )
    );
  }
}