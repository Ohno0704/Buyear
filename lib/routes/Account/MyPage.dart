import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Account/AccountPage.dart';
 
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("マイページ"),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('アカウント'),
              trailing:  Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AccountPage();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('お問い合わせ'),
              trailing:  Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('出品した商品'),
              trailing:  Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('購入した商品'),
              trailing:  Icon(Icons.arrow_forward_ios),
            ),
          ],
        )

      )
          );
  }
}