import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Home/Account/MyPage.dart';
import 'package:flutter_application_1/routes/Chat/Open/OpenChat.dart';
import 'package:flutter_application_1/routes/root.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/services.dart';

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

  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  // final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("出品"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400]),
      ),
      body: SingleChildScrollView(
        reverse: true,
      child: Center(
        // child: _image == null ? Text('No image selected.') : Image.file(_image!),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 35,
              width: 100,
              child: Text("画像を追加", style: TextStyle(fontSize: 20),),
            ),
            SizedBox(
              height: 80,
              width: 80,
              child: RaisedButton(
                        onPressed: () {
                          _getImage();
                        },
                        child: Text('+', style: TextStyle(fontSize: 20, color: Colors.white),),
                        color: Colors.grey,
                        shape: CircleBorder(),
                      ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 150,
              width: 180,
              child: _image == null ? Container(color: Colors.grey, width: 150, height: 200,) : Image.file(_image!),
            ),
            SizedBox(
              height: 30,
              width: 50,
            ),
            SizedBox(
              height: 90,
              width: 350,
              child: TextField(
                enabled: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.black,
                maxLength: 300,
                onChanged: _handleText,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mode_edit),
                  labelText: '商品の状態、説明',
                ),
              ),
            ),
            SizedBox(
              height: 90,
              width: 350,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[ 
                  FilteringTextInputFormatter.digitsOnly // ③ 数字入力のみ許可する
                ], 
                decoration: const InputDecoration(
                  icon: Icon(Icons.mode_edit),
                  labelText: '希望価格',
                ),
              ),
            ),
            SizedBox(
              height: 80,
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
      )
    );
  }
}