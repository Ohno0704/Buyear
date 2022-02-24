import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/Account/MyPage.dart';
import 'package:flutter_application_1/routes/root.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

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
  List<File> _images = [];
  File? _image;
  DocumentReference sightingRef = FirebaseFirestore.instance.collection("items").doc();
  var storage = firebase_storage.FirebaseStorage.instance;
  bool isLoading = false;
  List<String?> listOfItem = []; //商品画像ファイル名
  String? _text; // 商品の概要
  String? imageURL;
  String? price;
  String? storageURL;

  final doc = FirebaseFirestore.instance.collection("sightings").doc();

  Future addItem() async{
    
    setState(() {

      if(_text == null || _text == "") {
        throw '商品に関する説明が入力されていません';
      }
      
      // if (imageURL == null || imageURL == "") {
      //   throw '画像が入力されていません';
      // }

      if (_image == null) {
        throw '画像が入力されていません';
      }

      if(price == null || price == "") {
        throw '希望価格が入力されていません';
      }

      // if(imageURL != null) {
        FirebaseFirestore.instance.collection('items').add({
          'itemURL': imageURL!,
          'price': price,
          'contributor': "ono.hiroyuki.ok@tut.jp",
        });
      // }
      

      doc.set({
        'itemURL': _image, //imageURL,
        'price': price,
        'contributor': "ono.hiroyuki.ok@tut.jp",
      });

    });
  }

  Future _getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile? pickedFile;
    // PickedFile pickedFile;
    // Let user select photo from gallery
    if(gallery) {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery,);
    } 
    // Otherwise open camera to get new photo
    else{
      pickedFile = await picker.getImage(
          source: ImageSource.camera,);
    }

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
        _image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> saveImages(List<File> _images, DocumentReference ref) async {
      _images.forEach((image) async {
        String _imageURL = await uploadFile(image);
        ref.update({"items": FieldValue.arrayUnion([_imageURL])});
      });
  }

  Future<String> uploadFile(File _image) async {
    
    // final task = await firebase_storage.FirebaseStorage.instance.ref('items/${doc.id}').putFile(_image);
    // final _imageURL = await task.ref.getDownloadURL();
    // return _imageURL;
    firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('items/${basename(_image.path)}');
    storageURL = _image.path;
    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask;
    print('File Uploaded');
    String? returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL =  fileURL;
      imageURL = fileURL;
    });
    return returnURL!;
  }

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  void _handlePrice(String e) {
    setState(() {
      price = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        firebase_storage.Reference imageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('items/${basename(storageURL!)}');
        imageRef.delete();
        Navigator.of(context).pop();
        return Future.value(false);
      },
    child: Scaffold(
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
              child: RawMaterialButton(
                fillColor: Theme.of(context).accentColor,
                child: Icon(Icons.add_photo_alternate_rounded,
                color: Colors.white,),
                elevation: 8,
                onPressed: () async{                          
                  await _getImage(true);
                  await saveImages(_images,sightingRef);
                },
                padding: EdgeInsets.all(15),
                shape: CircleBorder(),
              )
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
                onChanged: _handlePrice,
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
                      try {
                        
                        await addItem();                      
                        await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RootWidget(),
                        ),
                      );
                      } catch(e) {
                        print(e);
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
              ),
            )
          ]
        )
      ),
      )
    )
    );
  }
}