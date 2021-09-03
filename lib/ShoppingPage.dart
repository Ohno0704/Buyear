import 'package:flutter/material.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(widget.title),
      //   title: Text('Enjoy University Life With Buyear!'),
      //   actions: <Widget>[
      //     Icon(Icons.home),
      //   ]
      // ),
      body: Container(
        // height: double.infinity,
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name),
            Center(
              child: ElevatedButton(
                child: Text('back'),
                onPressed: () {
                  Navigator.pop(context, 'Buyear');
                },
              )
            )
          ]
        )
      )
    );
  }
}