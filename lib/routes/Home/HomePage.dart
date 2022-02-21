import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Home/ItemPage.dart';

class HomePage extends StatelessWidget {
  
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('items').snapshots();
  final List<int> checkedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("ホーム"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPage(),
                  ),
                );
            },
            icon: Icon(Icons.account_circle))
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _userStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
              itemCount: snapshot.data!.docs.length,
              padding: EdgeInsets.all(2.0),
              itemBuilder: (BuildContext context, int index) {
                final bool checked = checkedList.contains(index);
                DocumentSnapshot? data = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemPage(data["itemURL"], data["price"], data["contributor"]),
                          fullscreenDialog: true,
                        )
                      );
                    },
                    child:GridTile(
                      child: Image.network(data["itemURL"]!, fit: BoxFit.cover,),
                      footer: Container(
                        color: Colors.grey[400],
                        child: Text.rich(
                          TextSpan(
                            text: data["price"],
                            children: <TextSpan>[
                              TextSpan(
                                text: "円"
                              )
                            ]
                          ),
                        )
                      ),
                    )
                  );    
                });
             
            }
        )
      )
    );
  }
}