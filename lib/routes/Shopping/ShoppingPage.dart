import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Shopping/SellPage.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("売る"),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              SizedBox(
                height: 100,
                width: 180,
                child: ElevatedButton(
                  child: Text('出品'),
                  onPressed: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellPage(),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(
                height: 80,
                width: 100,
                child: TextButton(
                  child: const Text('出品方法　>'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 30,
                width: 100,
              ),
              SizedBox(
                height: 100,
                width: 180,
                child: ElevatedButton(
                  child: Text('取引中の商品'),
                  onPressed: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellPage(),
                      ),
                    );
                  }
                ),
              ),
          ],
        ) 
      ),
    );
  }
}

