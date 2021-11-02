import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChat.dart';
import 'package:flutter_application_1/routes/Chat/Open/OpenChat.dart';
 
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
              minWidth: 180.0,
              height: 100.0,
              child: RaisedButton(
                  child: Text('個人チャット'),
                  onPressed: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMassageState(0),
                      ),
                    );
                  }
                ),
              ),

              Text('   '),

              ButtonTheme(
                minWidth: 180.0,
                height: 100.0,
                child: RaisedButton(
                    child: Text('全体チャット'),
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
      ),
    );
  }
}