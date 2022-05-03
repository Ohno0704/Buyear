import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_application_1/routes/root.dart';
import 'dart:async';
// import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:flutter_application_1/user.dart';
import 'package:provider/provider.dart';

import 'package:cached_network_image/cached_network_image.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  List<XFile> _images = [];
  XFile? _image;
  DocumentReference sightingRef =
      FirebaseFirestore.instance.collection("items").doc();
  var storage = firebase_storage.FirebaseStorage.instance;
  bool isLoading = false;
  List<String?> listOfItem = []; //商品画像ファイル名
  String? _text; // 商品の概要
  String? imageURL;
  String? price;
  String? storageURL;
  String? userName;
  String? contributorID;
  String? itemName;
  final now = DateTime.now();
  Image? _img;
  String? storagePath;

  firebase_storage.Reference? storageReference;

  Future addItem() async {
    setState(() {
      if (_text == null || _text == "") {
        throw '商品に関する説明が入力されていません';
      }

      if (imageURL == null) {
        throw '画像が入力されていません';
      }

      if (price == null || price == "") {
        throw '希望価格が入力されていません';
      }

      // if(imageURL != null) {
      FirebaseFirestore.instance.collection('items').add({
        'createdAt': now,
        'itemURL': imageURL!,
        'price': price,
        'contributorID': contributorID,
        'text': _text,
        'userName': userName,
        'itemName': itemName,
      });
      // }
    });
  }

  void uploadFromWeb({@required Function(File? file)? onSelected}) {
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected!(file);
        print('done');
      });
    });
  }

  void uploadToStorage(UserState user) async {
    // final dateTime = DateTime.now();
    final userId = user.userID;
    final path = '$userId/$now';

    uploadFromWeb(onSelected: (file) async {
      storageReference = firebase_storage.FirebaseStorage.instance
          .refFromURL('gs://buyear-e477f.appspot.com/')
          .child('items/$path.png');
      await storageReference!.putBlob(file);
      await storageReference!.getDownloadURL().then((fileURL) {
        imageURL = fileURL;
      });
      // imageURL = storageReference!.getDownloadURL().toString();
      _img = new Image(image: new CachedNetworkImageProvider(imageURL!));
    });
    storagePath = path;
  }

  Future _getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;

    // スマホアプリ用処理

    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _images.add(XFile(pickedFile.path));

        // _image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> saveImages(List<XFile> _images, DocumentReference ref) async {
    _images.forEach((image) async {
      String _imageURL = await uploadFile(image);
      ref.update({
        "items": FieldValue.arrayUnion([_imageURL])
      });
    });
  }

  // firebaseStrageにアップロード
  Future<String> uploadFile(XFile _image) async {
    // firebase_storage.FirebaseStorage.instance.ref("items").putFile(web_file!);

    firebase_storage.Reference? storageReference;
    firebase_storage.UploadTask uploadTask;
    Uint8List? downloadedData = await storageReference!.getData();
    uploadTask = storageReference.putData(await _image.readAsBytes());

    storageReference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('items/${basename(_image.path)}');
    storageURL = _image.path;
    // uploadTask = storageReference.putFile(_image);

    await uploadTask;
    print('File Uploaded');
    String? returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
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

  void _handleItemName(String e) {
    setState(() {
      itemName = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final String _userName = userState.userName!;
    userName = _userName;
    contributorID = userState.userID;
    return WillPopScope(
        // 出品せずにpopするとアップしたstrageの画像を消去する
        onWillPop: () async {
          if (storageURL != null) {
            firebase_storage.Reference imageRef = firebase_storage
                .FirebaseStorage.instance
                .ref()
                .child('items/${basename(storageURL!)}');
            imageRef.delete();
            Navigator.of(context).pop();
          } else {
            firebase_storage.Reference imageRef = firebase_storage
                .FirebaseStorage.instance
                .ref()
                .child('items/${userState.userID}/${basename(storagePath!)}');
            imageRef.delete();
            Navigator.of(context).pop();
          }
          return Future.value(false);
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: NewGradientAppBar(
              centerTitle: true,
              title: Text("出品"),
              gradient: LinearGradient(colors: [
                Colors.blue.shade200,
                Colors.blue.shade300,
                Colors.blue.shade400
              ]),
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Center(
                  child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 35,
                  width: 100,
                  child: Text(
                    "画像を追加",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                    height: 80,
                    width: 80,
                    child: RawMaterialButton(
                      fillColor: Theme.of(context).accentColor,
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.white,
                      ),
                      elevation: 8,
                      onPressed: () async {
                        if (kIsWeb) {
                          uploadToStorage(userState);
                        } else {
                          await _getImage(true);
                          await saveImages(_images, sightingRef);
                        }
                      },
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(),
                    )),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 150,
                  width: 180,
                  child: imageURL == null
                      ? Container(
                          color: Colors.grey,
                          width: 150,
                          height: 200,
                        )
                      : _img,
                  // : Image.file(_image!), // スマホ用
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
                    maxLength: 30,
                    onChanged: _handleItemName,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mode_edit),
                      labelText: '商品名',
                    ),
                  ),
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
                      onPressed: () async {
                        try {
                          await addItem();
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RootWidget(),
                            ),
                          );
                        } catch (e) {
                          print(e);
                          final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }),
                ),
                SizedBox(
                  height: 30,
                  width: 50,
                ),
              ])),
            )));
  }
}
