import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Chat/Open/OpenChat.dart';
import 'package:flutter_application_1/routes/root.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

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

// class SellPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     // var itemWidgets = _makeWidgets();
//     return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("出品"),
      // ),
//       body: Center(
//         child: ButtonTheme(
//               minWidth: 180.0,
//               height: 100.0,
//               child: RaisedButton(
//                   child: Text('出品'),
//                   onPressed: () async{
//                     // itemNum++;
//                     await Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => RootWidget(),
//                       ),
//                     );
//                   }
//                 ),
//               ),
//       ),
//     );
//   }
// }

class SellPage extends StatefulWidget {
  // SellPage({Key key, this.title}) : super(key: key);

  // final String title;

  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  File? _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("出品"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
      ),
      body: Center(
        // child: _image == null ? Text('No image selected.') : Image.file(_image!),
        child: _image == null ? Text('商品の画像を選択してください👇', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)) : Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 150,
              width: 180,
              child: Image.file(_image!),
            ),
            SizedBox(
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 100,
              width: 180,
              child: ElevatedButton(
                    child: Text('出品'),
                    onPressed: () async{
                      // itemNum++;
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RootWidget(),
                        ),
                      );
                    }
              ),
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: Icon(Icons.add),
      ),
    );
  }
}