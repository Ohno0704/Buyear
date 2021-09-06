import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Chat/PersonalChat.dart';
import 'package:flutter_application_1/routes/Chat/OpenChat.dart';
 
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("チャット"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPage(),
                  ),
                );
            },
            icon: Icon(Icons.account_circle))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            ButtonTheme(
              minWidth: 200.0,
              height: 100.0,
              child: RaisedButton(
                  child: Text('Personal Chat'),
                  onPressed: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PersonalChat(),
                      ),
                    );
                  }
                ),
              ),

              Text('   '),

              ButtonTheme(
                minWidth: 200.0,
                height: 100.0,
                child: RaisedButton(
                    child: Text('Open Chat'),
                    onPressed: () async{
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OpenChat(),
                        ),
                      );
                    }
                  ),
              ),
            ],
          )
        ],
        // child: Row(
        //   children: <Widget>[
        //     ElevatedButton(
        //         child: Text('Go to Personal Chat'),
        //         onPressed: () async{
        //           await Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => PersonalChat(),
        //             ),
        //           );
        //         }
        //       ),
        //       ElevatedButton(
        //         child: Text('Go to Open Chat'),
        //         onPressed: () async{
        //           await Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => OpenChat(),
        //             ),
        //           );
        //         }
        //       ),
        //     ],
        // )
      ),
    );
  }
}