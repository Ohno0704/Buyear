import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Home/ItemPage.dart';
 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ホーム"),
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
      body: Container(
        width: double.infinity,
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(50, (index) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemPage(index),
                      ),
                    );
                  },
                  child: Expanded(
                    child: Image.network(
                    'https://pbs.twimg.com/profile_images/1420594554617556992/LmaZQTSv_400x400.jpg'
                    ),
                  ),
                  
                ),
                // Expanded(
                //   child: Image.network(
                //     'https://pbs.twimg.com/profile_images/1420594554617556992/LmaZQTSv_400x400.jpg'
                //   ),
                // ),
                // Text('$index'),
              ],
            );
          }
          )
        ),
      )
    );
  }
}