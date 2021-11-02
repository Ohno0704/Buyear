import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Chat/Personal/PersonalChat.dart';
// import 'package:flutter_application_1/routes/Chat/Personal/.dart';
 
class ItemPage extends StatelessWidget {
  ItemPage(this._index);
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("商品情報"),
      ),
      persistentFooterButtons: <Widget>[
        Center(
          child: RaisedButton(
                  child: Text('購入するため個人チャットへ'),
                  onPressed: () async{
                    Tile(Icons.person, '$_index', '$_index');
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMassageState(1),
                      ),
                    );
                  }
            ),
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     RaisedButton(
        //           child: Text('購入するため個人チャットへ'),
        //           onPressed: () async{
        //             await Navigator.push(
        //               context,
        //               MaterialPageRoute(builder: (context) => PersonalChat(),
        //               ),
        //             );
        //           }
        //     ),
        //   ],
        // )
      ],
      body: Column(
        children: <Widget>[
          Center(
            child: Text('$_index番目の商品'),
          ),
          Center(
            child: Image.asset(
              'images/buyear_start.png',
              fit: BoxFit.contain,
              ),
          )
        ],
      )
      
      
    );
  }
}