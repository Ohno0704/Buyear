import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Chat/Open/OpenChat.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("売る"),
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
                  child: Text('出品'),
                  onPressed: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpenChat(),
                      ),
                    );
                  }
                ),
              ),
              TextButton(
                child: const Text('出品方法　>'),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {},
              ),
              Text(''),
              ButtonTheme(
              minWidth: 180.0,
              height: 100.0,
              child: RaisedButton(
                  child: Text('取引中の商品'),
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