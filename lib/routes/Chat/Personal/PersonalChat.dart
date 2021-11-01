import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
 
class Tile extends StatelessWidget {

  // コンストラクタへ代入して初期化しても初期化できない(dartクソ)
  IconData icon = Icons.visibility_off;
  String username = " ";
  String message = " ";

  Tile(IconData icon, String username, String message) {
    this.icon = icon;
    this.username = username;
    this.message = message;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(this.icon), // <- 追加：アイコンの設定
            backgroundColor: Colors.pink,
          ),
          title: Text(this.username), // <- 追加：ユーザ名の設定
          subtitle: Text(this.message), // <- 追加：メッセージの設定
          onTap: () => {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Chatting(this.username)))
          },
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          color: Colors.blue,
          icon: Icons.flash_off,
          onTap: () => {
          }, // _showSnackBar('Archive'),
        ),
        IconSlideAction(
          color: Colors.indigo,
          icon: Icons.volume_off,
          onTap: () => {}, // _showSnackBar('Share'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.black45,
          iconWidget: Text(
            "非表示",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () => {}, // _showSnackBar('More'),
        ),
        IconSlideAction(
          color: Colors.red,
          iconWidget: Text(
            "削除",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () => {}, // _showSnackBar('Delete'),
        ),
      ],
    );
  }
}
class PersonalChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" 個人チャット"),
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
      body: ListView(
          children: <Widget>[
            Tile(
              Icons.person,
              "鹿太郎",
              "しかし、鹿しかいない",
              ),
            Tile(
              Icons.person,
              "久米酒",
              "おいしいよー",
              ),
            Tile(
              Icons.person, 
              "くら", 
              "とっても美味しい沖縄のお酒"
              ),
            Tile(
              Icons.person, 
              "団長", 
              "止まるんじゃ、ねぇぞ"
              ),
            Tile(
              Icons.person,
              "サルーイン",
              "こい"
              ),
            Tile(
                Icons.person,
                "がらはど",
                "だめだ！いくら積まれても..."
                ),
            Tile(
                Icons.person,
                "太郎",
                "だめだ、久しぶりにキレちまったよ"
                ),
            Tile(
                Icons.person,
                "Harry",
                "エクスペクト・パトローナーーム"
                ),
            Tile(
                Icons.person,
                "くろひげ",
                "似合ってるぜぃ、そのきずぅ〜"
                ),
            Tile(
              Icons.person,
              "あすらん",
              "キラァァァァ"
              ),
            Tile(
              Icons.person,
              "知人B",
              "1.14 release !"
              ),
          ]),
    );
  }
}

class Chatting extends StatelessWidget {
  String username = " ";
 
  Chatting(String username) {
    this.username = username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.username),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => {},
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(Icons.dehaze),
                onPressed: () => {},
              )),
        ],
      ),
      body: Center(child: Text("Chat")),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () => {},
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Aa',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () => {},
            ),
          ],
        ),
      ),

      backgroundColor: Colors.cyan,
    );
  }
}