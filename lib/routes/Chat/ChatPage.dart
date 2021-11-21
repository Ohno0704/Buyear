import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChat.dart';
import 'package:flutter_application_1/routes/Chat/Open/OpenChat.dart';

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class ChatPage extends StatelessWidget {

  final List<TabInfo> _tabs = [
    TabInfo("オープンチャット", OpenChat()),
    TabInfo("パーソナルチャット", AddMassageState(1)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          // title: Text("チャット"),
          bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              tabs: _tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),
            preferredSize: Size.fromHeight(30.0),
          ),
          // automaticallyImplyLeading: false,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => MyPage(),
          //           ),
          //         );
          //     },
          //     icon: Icon(Icons.account_circle))
          // ],
        ),
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //       ButtonTheme(
      //         minWidth: 180.0,
      //         height: 100.0,
      //         child: RaisedButton(
      //             child: Text('個人チャット'),
      //             onPressed: () async{
      //               await Navigator.push(
      //                 context,
      //                 MaterialPageRoute(builder: (context) => AddMassageState(0),
      //                 ),
      //               );
      //             }
      //           ),
      //         ),

      //         Text('   '),

      //         ButtonTheme(
      //           minWidth: 180.0,
      //           height: 100.0,
      //           child: RaisedButton(
      //               child: Text('全体チャット'),
      //               onPressed: () async{
      //                 await Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => OpenChat(),
      //                   ),
      //                 );
      //               }
      //             ),
      //         ),
      //       ],
      //     )
      //   ],
      // ),
      )
    );
  }
}