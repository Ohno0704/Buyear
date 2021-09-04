import 'package:flutter/material.dart';
 
class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ショッピング"),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text("ショッピング") 
          ),
    );
  }
}