import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ItemPage extends StatelessWidget {
  ItemPage(this.itemURL, this.price);
  String? itemURL;
  String? price;
  int _index = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("商品情報"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      persistentFooterButtons: <Widget>[
        Center(
          child: RaisedButton(
                  child: Text('購入するため個人チャットへ'),
                  onPressed: () async{
                  }
            ),
        )
      ],
      body: Column(
        children: <Widget>[
          Center(
            child: Expanded(
              child: Image.network(
                itemURL!,
                fit: BoxFit.contain,
                ),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                text: price!,
                style: TextStyle(
                  fontSize: 30,
                  // color: Colors.red,
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "円"
                  )
                ]
              ),),
          ]),
        ],
      )
      
      
    );
  }
}