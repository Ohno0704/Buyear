import 'package:flutter/material.dart';
 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ホーム"),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text("ホーム") 
          ),
    );
  }
}