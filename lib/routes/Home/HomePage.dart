import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Home/ItemPage.dart';

// var itemNum = 10;
class HomePage extends StatelessWidget {
  // HomePage(this.itemAdder);
  // int itemAdder = 0;
  var itemNum = 10;
  
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
        crossAxisCount: 2,
        children: List.generate(itemNum, (index) {
          return Column(
            children: <Widget>[
              GridTile(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemPageAndAddFriend(index),
                      ),
                    );
                  },
                  child: Image.asset(
                    'images/buyear_rogo.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "￥$index",
                  style: TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: "Roboto"),
                ),
              ),
            ],
          );
        }
        )
      ),
    )
      // body: GridView.count(
      //     padding: EdgeInsets.all(4.0),
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 10.0, // 縦
      //     mainAxisSpacing: 10.0, // 横
      //     childAspectRatio: 0.7, // 高さ
      //     shrinkWrap: true,
      //     children: List.generate(50, (index) {

      //       // var rng = new Random();
      //       // var imgNumber = rng.nextInt(3);
      //       var assetsImage = "images/buyear_rogo2.png";

      //       return Container(
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           boxShadow: [
      //             new BoxShadow(
      //               color: Colors.grey,
      //               offset: new Offset(5.0, 2.0),
      //               blurRadius: 10.0,
      //             )
      //           ],
      //         ),
      //         child:Column(
      //           children: <Widget>[
      //           //   width: 154,
      //           // height: 230,
      //             Image.asset(assetsImage, fit: BoxFit.fitWidth,),
      //             Container(
      //               margin: EdgeInsets.all(32.0),
      //               child: Text(
      //                 '￥ $index',
      //               ),
      //             ),
      //           ]
      //         ),
      //       );
      //     }),
      //   ),
      );
  }
}