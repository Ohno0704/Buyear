import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChat.dart';
import 'package:flutter_application_1/routes/Chat/ChatPage.dart';

class ItemPageAndAddFriend extends StatefulWidget {
  ItemPageAndAddFriend(this._index);
  int _index = 0;
  @override
  ItemPage createState() => ItemPage(_index);
} 
class ItemPage extends State<ItemPageAndAddFriend> {
  ItemPage(this._index);
  int _index = 0;
  // Tile friends = Tile(
  //       Icons.person,
  //       "初期化初期太郎",
  //       "I am initializer",
  //       );
  bool isPressed = false;

  // FriendListController _addFriendController;

  // void initState() {
  //   super.initState();
  //   _addFriendController = FriendListController();
  // }

  // void dispose() {
  //   super.dispose();
  //   _addFriendController.dispose();
  // }

  // void _addFriend(String name, String message) {
  //   if(isPressed == true) {
  //     friends = Tile(
  //       Icons.person,
  //       name,
  //       message,
  //     );
  //     isPressed = false;
  //   }
  //   setState(() {
  //     PersonalChat(friends, true);
  //   });
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ChatPage())
  //   );
    // friends = Tile(
    //   Icons.person,
    //     "初期化初期太郎",
    //     "I am initializer",
    // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("商品情報"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      persistentFooterButtons: <Widget>[
        Center(
          child: RaisedButton(
                  child: Text('購入するため個人チャットへ'),
                  onPressed: () async{
                    // isPressed = true;
                    // _addFriend('people', '$_index');
                    // Tile(Icons.person, 'People', '$_index');
                    // await Navigator.push(
                    //   context,
                    //   _addFriend()
                    //   // MaterialPageRoute(builder: (context) => ChatPage(),
                    //   ),
                    // );
                  }
            ),
        )
      ],
      body: Column(
        children: <Widget>[
          Center(
            child: Text('番目の商品'),
          ),
          Center(
            child: Image.asset(
              'images/buyear_start.png',
              fit: BoxFit.contain,
              ),
          )
        ],
      )
      
      
    );
  }
}