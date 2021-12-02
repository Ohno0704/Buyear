import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChat.dart';
import 'package:flutter_application_1/routes/Chat/Open/OpenChat.dart';

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class ChatPage extends StatelessWidget {
  // ChatPage(this.user);
  // final User user;

  final List<TabInfo> _tabs = [
    TabInfo("掲示板", OpenChat()),
    TabInfo("チャット", AddMassageState()),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: NewGradientAppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              tabs: _tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),
            preferredSize: Size.fromHeight(30.0),
          ),
          gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
        ),
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
      )
    );
  }
}