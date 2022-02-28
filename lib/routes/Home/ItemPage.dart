import 'package:flutter/material.dart';
import 'package:flutter_application_1/user.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemPage extends StatelessWidget {
  ItemPage(this.itemURL, this.price, this.contributor);
  String? itemURL;
  String? price;
  String? contributor;
  bool isPressed = false;
  final _userName = FirebaseFirestore.instance.collection('user');

  // Future<Map<String, dynamic>> getData(String collection, String documentId) async {
  //   DocumentSnapshot docSnapshot =
  //       await FirebaseFirestore.instance.collection(collection).doc(documentId).get();

  //   return docSnapshot.data();
  // }

  void fetchuserName() async{
    final QuerySnapshot snapshot = await _userName.get();

    final List users = snapshot.docs.map((DocumentSnapshot document) {

      Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String userName = data['userName'];
      
    }).toList();
  }
  
  fetchUserData() async {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final userId = _firebaseAuth.currentUser!.uid;
      DocumentSnapshot snapshot = await _firestore.doc('user/${userId}').get();
      // print(snapshot.data()['email']);
      return snapshot.data();
    }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("商品情報"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
        actions: [
          // contributor == user.email
          // ? IconButton(
          //   onPressed: () {
          //     FirebaseFirestore.instance.collection("posts").doc(board.id).delete();
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => MyPage(),
          //         ),
          //       );
          //   },
          //   icon: Icon(Icons.account_circle))
        ],
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
            child: SizedBox(
              width: double.infinity,
              height: 300.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                text: "${_userName}",
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
    );
  }
}