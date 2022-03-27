import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Account/AccountPage.dart';
import 'package:flutter_application_1/routes/Account/InquiryPage.dart';
 
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("マイページ"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
        actions: [
        ],
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('アカウント'),
              trailing:  Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AccountPage();
                }));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.person_add),
            //   title: Text('フレンドリスト'),
            //   trailing:  Icon(Icons.arrow_forward_ios),
            //   onTap: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) {
            //       return AccountPage();
            //     }));
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('お問い合わせ'),
              trailing:  Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InquiryPage();
                }));
              },
            ),
          ],
        )

      )
          );
  }
}