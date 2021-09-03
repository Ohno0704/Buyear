import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  var _navIndex = 0;
  var _label = '';
  var _titles = ['Contacts', 'Map', 'Map', 'Map', 'Chat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            title: Text('ホーム'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('お知らせ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('ショッピング'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('情報誌'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('チャット'),
          ),
        ],
        onTap: (int index) {
          // setState(
          //   () {
          //     _navIndex = index;
          //     _label = _titles[index];
          //   },
          // );
        },
        currentIndex: _navIndex,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                _label,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}