import 'package:flutter/material.dart';
 
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MyPage"),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: const <Widget>[
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
            // ListTile(
            //   leading: Icon(Icons.map),
            //   title: Text('Map'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
            // ListTile(
            //   leading: Icon(Icons.photo_album),
            //   title: Text('Album'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
            // ListTile(
            //   leading: Icon(Icons.phone),
            //   title: Text('Phone'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
            // ListTile(
            //   leading: Icon(Icons.map),
            //   title: Text('Map'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
            // ListTile(
            //   leading: Icon(Icons.photo_album),
            //   title: Text('Album'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
            // ListTile(
            //   leading: Icon(Icons.phone),
            //   title: Text('Phone'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
            // ListTile(
            //   leading: Icon(Icons.map),
            //   title: Text('Map'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
            // ListTile(
            //   leading: Icon(Icons.photo_album),
            //   title: Text('Album'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
            // ListTile(
            //   leading: Icon(Icons.phone),
            //   title: Text('Phone'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            // ),
          ],
        )

      )
          );
  }
}