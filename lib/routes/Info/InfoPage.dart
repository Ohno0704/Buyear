import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Chat/Open/OpenChat.dart';
 
class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("情報誌"),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 180.0,
              height: 100.0,
              child: RaisedButton(
                  child: Text('全体'),
                  onPressed: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpenChat(),
                      ),
                    );
                  }
                ),
              ),
              Text(' '),
              ButtonTheme(
              minWidth: 180.0,
              height: 100.0,
              child: RaisedButton(
                  child: Text('部活・サークル'),
                  onPressed: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpenChat(),
                      ),
                    );
                  }
                ),
              ),
              Text(' '),
              ButtonTheme(
              minWidth: 180.0,
              height: 100.0,
              child: RaisedButton(
                  child: Text('自動車学校'),
                  onPressed: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpenChat(),
                      ),
                    );
                  }
                ),
              ),
              Text(' '),
              ButtonTheme(
              minWidth: 180.0,
              height: 100.0,
              child: RaisedButton(
                  child: Text('アルバイト'),
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
          ),
    );
  }
}