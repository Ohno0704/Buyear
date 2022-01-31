import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Home/ItemListModel.dart';
import 'package:flutter_application_1/routes/Home/domain/Item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('items').snapshots();
  
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
        // child: Consumer<ItemListModel>(
          // builder: (context, model, child) {
            // final items = model.items;

            // if (items == null) {
            //   return CircularProgressIndicator();
            // }

            // if (snapshot.hasError) {
            //   return Text('Something went wrong');
            // }

            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Text('Loading');
            // }
            
            // Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
              itemCount: snapshot.data!.docs.length,
              padding: EdgeInsets.all(2.0),
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot? data = snapshot.data!.docs[index];
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child:GridTile(
                      child: Image.network(data["itemURL"]!, fit: BoxFit.cover,),
                      footer: Container(
                        color: Colors.grey[400],
                        child: Text(
                          '10000円',
                        ),
                      )
                    )
                  );
                });
            }
        )
      )
    );
  }
}

// return GridView.count(
//               crossAxisCount: 2,
//               mainAxisSpacing: 4,
//               // padding: const EdgeInsets.all(4),
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                   document.data() as Map<String, dynamic>;
//                   return Container(
//                     padding: const EdgeInsets.all(8.0),
//                     alignment: Alignment.center,
//                     child:GridTile(
//                       // child: Image.network('https://picsum.photos/250?image=9', fit: BoxFit.cover,),
//                       child: Image.network(data['itemURL'], fit: BoxFit.cover,),
//                       footer: Center(
//                         child: Text(
//                           '10000円',
//                         ),
//                       )
//                     )
//                   );
//                 }).toList()
//               );
//             }

// final List<Widget> widgets = items
//                   .map(
//                     (item) => GridView.count(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 4,
//                       // padding: const EdgeInsets.all(4),
//                       children: List.generate(10, (index) {
//                         return Container(
//                           padding: const EdgeInsets.all(8.0),
//                           alignment: Alignment.center,
//                           child:GridTile(
//                             // child: Image.network('https://picsum.photos/250?image=9', fit: BoxFit.cover,),
//                             child: Image.network(item.itemURL, fit: BoxFit.cover,),
//                             footer: Center(
//                               child: Text(
//                                 '10000円',
//                               ),
//                             )
//                           )
//                         );
//                       }).toList()////
//                     )
//                   ).toList();
//                   return Column(
//                     children: widgets,
//                   );