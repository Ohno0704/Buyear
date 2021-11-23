import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Chat/Open/AddBoard.dart';
 
class OpenChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("open"),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AddBoard();
                  }));
              },
      ),
    );

  }
}