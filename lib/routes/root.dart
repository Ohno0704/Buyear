import 'package:flutter/material.dart';

import 'package:flutter_application_1/routes/Home/HomePage.dart';
import 'package:flutter_application_1/routes/Shopping/ShoppingPage.dart';
import 'package:flutter_application_1/routes/Info/InfoPage.dart';
import 'package:flutter_application_1/routes/Chat/ChatPage.dart';

class RootWidget extends StatefulWidget {
  RootWidget({Key? key}) : super(key: key);
 
  @override
  _RootWidgetState createState() => _RootWidgetState();
}
 
class _RootWidgetState extends State<RootWidget> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];
 
  static const _footerIcons = [
    Icons.home,
    Icons.shop,
    Icons.content_paste,
    Icons.chat,
  ];
 
  static const _footerItemNames = [
    'ホーム',
    '売る',
    '情報誌',
    'チャット',
  ];

  // === 追加部分 ===
  var _routes = [
    HomePage(0),
    ShoppingPage(),
    InfoPage(),
    ChatPage(),
  ];
  // ==============
 
  @override
  void initState() {
    super.initState();
    _bottomNavigationBarItems.add(_UpdateActiveState(0));
    for (var i = 1; i < _footerItemNames.length; i++) {
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
    }
  }
 
  /// インデックスのアイテムをアクティベートする
  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black87,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black87,
          ),
        )
    );
  }
 
  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        )
    );
  }
 
  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] =
          _UpdateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndex = index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}