import 'package:flutter/material.dart';
 
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("チャット"),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text("チャット") 
          ),
    );
  }
}