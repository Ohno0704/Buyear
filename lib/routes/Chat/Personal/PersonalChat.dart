import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
 
 // flutter_chat_uiを使うためのパッケージをインポート
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:provider/provider.dart';
// ランダムなIDを採番してくれるパッケージ
import 'package:uuid/uuid.dart';

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
      secondaryActions: <Widget>[
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
  AddMassageState({Key? key}) : super(key: key);
  Tile friends = Tile(
        Icons.person,
        "初期化初期太郎222",
        "I am initializer",
        );

  @override
  PersonalChat createState() => new PersonalChat(friends, false);
}

class PersonalChat extends State<AddMassageState> {
  PersonalChat(this.friends, this.isAdd);
  Tile friends = Tile(
        Icons.person,
        "初期化初期太郎222",
        "I am initializer",
        );
    
  bool isAdd = true;

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _massageList.length,
                itemBuilder: (BuildContext context, int index) {
                  if(isAdd == true) {
                    setState(() {
                      _massageList.add(friends);
                    });
                  }
                  return _massageList[index];
                },
              ),
            ),

            // Row(
            //   children: [
            //     _massageList;
            //     IconButton(
            //       icon: Icon(Icons.add),
            //       onPressed: () {
            //         setState(() {
            //           _massageList.add(
            //             Tile(
            //               Icons.person,
            //               "鹿太郎",
            //               "しかし、鹿しかいない",
            //               ),
            //           );
            //         });
            //       },
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.remove),
            //       onPressed: (() {
            //         if (_massageList.length == 1) {
            //           // Fluttertoast.showToast(msg: "これ以上減らせません！！");
            //         } else {
            //           setState(() {
            //             _massageList.removeAt(_massageList.length - 1);
            //           });
            //         }
            //       })(),
            //     ),
            //   ],
            // )
          ],
        ),
      )
    );
  }
}

// class AddMassageState extends StatelessWidget {
//   // 引数からユーザー情報を受け取れるようにする
//   AddMassageState();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             // Stream 非同期処理の結果を元にWidgetを作る
//             child: StreamBuilder<QuerySnapshot>(
//             // 投稿メッセージ一覧の取得
//             stream: FirebaseFirestore.instance
//                 .collection('chat_room')
//                 .orderBy('createdAt')
//                 .snapshots(),
//             builder: (context, snapshot) {
//               // データが取得できた場合
//               if (snapshot.hasData) {
//                 final List<DocumentSnapshot> documents = snapshot.data!.docs;
//                 return ListView(
//                   children: documents.map((document) {
//                     return Card(
//                       child: ListTile(
//                         title: Text(document['name']),
//                         trailing: IconButton(
//                           icon: Icon(Icons.input),
//                           onPressed: () async {
//                             // チャットページへ画面遷移
//                             await Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return Chatting(document['name']);
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               }
//               // データが読込中の場合
//               return Center(
//                 child: Text('読込中……'),
//               );
//             },
//           )),
//         ],
//       ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     await Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) {
      //       return AddRoomPage();
      //     }));
      //   },
      // ),
//     );
//   }
// }

class Chatting extends StatefulWidget {
  const Chatting(this.name, {Key? key}) : super(key: key);

  final String name;
  @override
  _ChatPageState createState() => _ChatPageState(name);
}

class _ChatPageState extends State<Chatting> {
  String username = '';
  _ChatPageState(this.username) {
    this.username = username;
  }
  List<types.Message> _messages = [];
  String randomId = Uuid().v4();
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c', firstName: '名前');


  void initState() {
    _getMessages();
    super.initState();
  }

  // firestoreからメッセージの内容をとってきて_messageにセット
  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('contents')
        .get();

    final message = getData.docs
        .map((d) => types.TextMessage(
            author:
                types.User(id: d.data()['uid'], firstName: d.data()['name']),
            createdAt: d.data()['createdAt'],
            id: d.data()['id'],
            text: d.data()['text']))
        .toList();

    setState(() {
      _messages = [...message];
    });
  }

  // メッセージ内容をfirestoreにセット
  void _addMessage(types.TextMessage message) async {
    setState(() {
      _messages.insert(0, message);
    });
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('contents')
        .add({
      'uid': message.author.id,
      'name': message.author.firstName,
      'createdAt': message.createdAt,
      'id': message.id,
      'text': message.text,
    });
  }

  // リンク添付時にリンクプレビューを表示する
  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  // メッセージ送信時の処理
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
            author: _user,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: randomId,
            text: message.text,
          );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(username),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      body: Chat(
        theme: const DefaultChatTheme(
          // メッセージ入力欄の色
          inputBackgroundColor: Colors.blue,
          // 送信ボタン
          sendButtonIcon: Icon(Icons.send),
          sendingIcon: Icon(Icons.update_outlined),
        ),
        // ユーザーの名前を表示するかどうか
        showUserNames: true,
        // メッセージの配列
        messages: _messages,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}
// class Chatting extends StatelessWidget {
//   String username = " ";
 
//   Chatting(String username) {
//     this.username = username;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(this.username),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () => {},
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: IconButton(
//               icon: Icon(Icons.call),
//               onPressed: () => {},
//             ),
//           ),
//           Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: IconButton(
//                 icon: Icon(Icons.dehaze),
//                 onPressed: () => {},
//               )),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                   vertical: 32.0,
//                   ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       rightMassage(),
//                       leftMassage(),
//                       rightMassage(),
//                       rightMassage(),
//                       leftMassage(),
//                       leftMassage(),
//                     ]
//                   )),
//                 ),
//               ),
//             textInputWidget(),
//           ],
//         )
//       ),
//     );
//   }
//   Container textInputWidget() {
//       return Container(
//               height: 68,
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.camera_alt_outlined),
//                     iconSize: 28,
//                     color: Colors.black54,
//                     onPressed: (){},
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.photo_outlined),
//                     iconSize: 28,
//                     color: Colors.black54,
//                     onPressed: (){},
//                   ),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       child: TextField(
//                         autofocus: true,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     )
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.add),
//                     iconSize: 28,
//                     color: Colors.black54,
//                     onPressed: (){},
//                   ),
//                 ],
//               ),
//             );
//     }
//   Padding rightMassage() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 28.0),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(40),
//               topLeft: Radius.circular(40),
//               bottomLeft: Radius.circular(40),
//             ),
//             color: Colors.blue[200],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text("Hello"),
//           ),
//         ),
//       ),
//     );
//   }
//   Padding leftMassage() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 28.0),
//       child: Row(
//         children: <Widget>[
//           CircleAvatar(
//             child: ClipOval(
//               child: Image.asset('images/buyear_start.png'),
//             ),
//           ),
//           const SizedBox(width: 16.0),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(28),
//               color: Colors.grey[350],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text("Fuck"),
//             ),
//           ),
          
//         ],
//       ),
//     );
//   }
// }