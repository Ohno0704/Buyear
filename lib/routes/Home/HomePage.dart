import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Home/ItemPage.dart';
var itemNum = 30;
class HomePage extends StatelessWidget {
  // HomePage(this.itemAdder);
  // int itemAdder = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("ホーム"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
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
      body: Container(
        width: double.infinity,
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(itemNum, (index) {
            return Column(
              children: <Widget>[
                GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ItemPageAndAddFriend(itemNum-index),
                        ),
                      );
                    },
                    child: Image.asset(
                      'images/buyear_rogo.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          }
          )
        ),
      )
    );
  }
}