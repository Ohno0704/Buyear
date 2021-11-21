import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
 
class Tile extends StatelessWidget {

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

class AddMassageState extends StatefulWidget {
  AddMassageState(this.addFriend);
  int addFriend = 0;
  @override
  PersonalChat createState() => new PersonalChat(addFriend);
}

class PersonalChat extends State<AddMassageState> {
  PersonalChat(this.addFriend);
  int addFriend = 0;

  List<Tile> _massageList = [
    Tile(
        Icons.person,
        "初期化初期太郎",
        "I am initializer",
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(" 個人チャット"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => MyPage(),
      //             ),
      //           );
      //       },
      //       icon: Icon(Icons.account_circle))
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _massageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _massageList[index];
                },
              ),
            ),

            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _massageList.add(
                        Tile(
                          Icons.person,
                          "鹿太郎",
                          "しかし、鹿しかいない",
                          ),
                      );
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (_massageList.length == 1) {
                      // Fluttertoast.showToast(msg: "これ以上減らせません！！");
                    } else {
                      setState(() {
                        _massageList.removeAt(_massageList.length - 1);
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      )
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 32.0,
                  ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      rightMassage(),
                      leftMassage(),
                      rightMassage(),
                      rightMassage(),
                      leftMassage(),
                      leftMassage(),
                    ]
                  )),
                ),
              ),
            textInputWidget(),
          ],
        )
      ),
    );
  }
  Container textInputWidget() {
      return Container(
              height: 68,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt_outlined),
                    iconSize: 28,
                    color: Colors.black54,
                    onPressed: (){},
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_outlined),
                    iconSize: 28,
                    color: Colors.black54,
                    onPressed: (){},
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 28,
                    color: Colors.black54,
                    onPressed: (){},
                  ),
                ],
              ),
            );
    }
  Padding rightMassage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
            color: Colors.blue[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Hello"),
          ),
        ),
      ),
    );
  }
  Padding leftMassage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            child: ClipOval(
              child: Image.asset('images/buyear_start.png'),
            ),
          ),
          const SizedBox(width: 16.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.grey[350],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Fuck"),
            ),
          ),
          
        ],
      ),
    );
  }
}