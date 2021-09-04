import 'package:flutter/material.dart';
 
class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("情報誌"),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text("情報誌") 
          ),
    );
  }
}