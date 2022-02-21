import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Account/MyPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Info/PerInfo.dart';

class InfoPage extends StatelessWidget {
  final Stream<QuerySnapshot> _info_school_Stream = FirebaseFirestore.instance.collection('info_school').snapshots();
  final Stream<QuerySnapshot> _info_circle_Stream = FirebaseFirestore.instance.collection('info_circle').snapshots();
  final Stream<QuerySnapshot> _info_job_Stream = FirebaseFirestore.instance.collection('info_job').snapshots();

  final List<int> checkedList = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("情報誌"),
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
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(" 学内情報", style: TextStyle(fontSize: 20),),
          StreamBuilder<QuerySnapshot>(
          stream: _info_school_Stream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
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
                          builder: (context) => PerInfo(data["title"]),
                          fullscreenDialog: true,
                        )
                      );
                    },
                    child:Container(
                      width: 160.0,
                      child: Card(
                        child: Wrap(
                          children: <Widget>[
                            Image.network(data["imageURL"]),
                            ListTile(
                              title: Text(data["title"]),
                              subtitle: Text(data["subTitle"]),
                            )
                          ],
                        )
                      )
                    )
                  );    
                })
            );
            }
        ),
        Text(" サークル情報", style: TextStyle(fontSize: 20),),
          StreamBuilder<QuerySnapshot>(
          stream: _info_circle_Stream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
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
                          builder: (context) => PerInfo(data["title"]),
                          fullscreenDialog: true,
                        )
                      );
                    },
                    child:Container(
                      width: 160.0,
                      child: Card(
                        child: Wrap(
                          children: <Widget>[
                            Image.network(data["imageURL"]),
                            ListTile(
                              title: Text(data["title"]),
                              subtitle: Text(data["subTitle"]),
                            )
                          ],
                        )
                      )
                    )
                  );    
                })
            );
            }
        ),
        Text(" アルバイト情報", style: TextStyle(fontSize: 20),),
          StreamBuilder<QuerySnapshot>(
          stream: _info_job_Stream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
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
                          builder: (context) => PerInfo(data["title"]),
                          fullscreenDialog: true,
                        )
                      );
                    },
                    child:Container(
                      width: 160.0,
                      child: Card(
                        child: Wrap(
                          children: <Widget>[
                            Image.network(data["imageURL"]),
                            ListTile(
                              title: Text(data["title"]),
                              subtitle: Text(data["subTitle"]),
                            )
                          ],
                        )
                      )
                    )
                  );    
                })
            );
            }
        ),
        ],
      )
    )
    );
  }
}