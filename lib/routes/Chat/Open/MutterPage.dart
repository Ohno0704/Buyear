/* 掲示板内のつぶやきページ */

import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'dart:async';

class MutterPage extends StatefulWidget {
  MutterPage(this.documentID, this.boardTitle);
  String documentID;
  String boardTitle;
  @override
  _MutterPageState createState() => _MutterPageState(documentID, boardTitle);
}

class _MutterPageState extends State<MutterPage> {
  _MutterPageState(String documentID, String boardTitle) {
    this.documentID = documentID;
    this.boardTitle = boardTitle;
  }

  // メンバー変数
  String? documentID;
  String? boardTitle;
  String? comment;
  String? date;
  String? contributorID;

  final messageTextInputCtl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();
  final now = DateTime.now();

  // 画像に関する処理用変数
  String imageURL = '';
  Image? _img;
  firebase_storage.Reference? storageReference;
  String? storagePath;

  var selected_img = false;

  void _addMessage(String _comment) {
    setState(() {
      if(_comment == '') return;

      FirebaseFirestore.instance
          .collection('posts')
          .doc('${documentID}')
          .collection('コメント')
          .add({
        'createdAt': now,
        'comment': _comment,
        'contributorID': contributorID,
        'date': DateTime.now().toIso8601String(),
        'imageURL': ''
      });
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +
          MediaQuery.of(context).viewInsets.bottom,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  // 以下から画像送信用メソッド
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
        selected_img = true;
      });
    });
  }

  Future uploadToStorage(UserState user) async {
    // final dateTime = DateTime.now();
    final userId = user.userID;
    final path = '$userId/$now';

    uploadFromWeb(onSelected: (file) async {
      storageReference = firebase_storage.FirebaseStorage.instance
          .refFromURL('gs://buyear-e477f.appspot.com/')
          .child('images/$path.png');
      await storageReference!.putBlob(file);
      await storageReference!.getDownloadURL().then((fileURL) {
      imageURL = fileURL;
      });
      // imageURL = storageReference!.getDownloadURL().toString();
      // _img = new Image(image: new CachedNetworkImageProvider(imageURL!));
      _img = new Image.network(imageURL);
    });
    storagePath = path;
  }

  Future addImage() async{
  setState(() {
    // if(imageURL == '') return;
    FirebaseFirestore.instance
        .collection('posts')
        .doc('${documentID}')
        .collection('コメント')
        .add({
      'createdAt': now,
      'comment': '',
      'contributorID': contributorID,
      'date': DateTime.now().toIso8601String(),
      'imageURL': imageURL,
    });
    // }
    print('uploaded');
  });
}

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    contributorID = userState.userID;
    return Scaffold(
      appBar: NewGradientAppBar(
        gradient: LinearGradient(colors: [
          Colors.blue.shade200,
          Colors.blue.shade300,
          Colors.blue.shade400
        ]),
        title: Text('${boardTitle}'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc('${documentID}')
            .collection('コメント')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            ListView(
              controller: _scrollController,
              children: documents.map((document) {
                var image_check = false;
                double h = 50;
                if (document['imageURL'] != '') {
                  image_check = true;
                  h = 200;
                }
                return Container(
                  child: Column(
                    children: [
                      Text(""),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: document['comment'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(document['date']),
                        ],
                      ),
                      InteractiveViewer(
                        child: Row(
                          children: [
                            SizedBox(
                              height: h,
                              width: 200,
                              child: image_check
                                ? Image.network(document["imageURL"]): null,
                              )
                            ] 
                        ),
                      )  
                    ],
                  ),
                );
              }).toList(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new Container(
                    color: Colors.blue[100],
                    child: Column(children: <Widget>[
                      new Form(
                          key: _formKey,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                new Flexible(
                                    child: new TextFormField(
                                  controller: messageTextInputCtl,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  decoration: selected_img == true ? const InputDecoration(
                                    hintText: '画像が選択されています。送信ボタンを押してください',
                                  ) :  const InputDecoration(
                                    hintText: 'コメントを入力してください',
                                  ),
                                  onTap: () {
                                    // タイマーを入れてキーボード分スクロールする様に
                                    // Timer(
                                    //   Duration(milliseconds: 200),
                                    //   _scrollToBottom,
                                    // );
                                  },
                                )),
                                // 画像送信
                                Material(
                                  color: Colors.blue[100],
                                  child: Center(
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        color: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.add_photo_alternate_outlined),
                                        color: Colors.white,
                                        onPressed: () async{
                                          if(kIsWeb) {
                                            uploadToStorage(userState);
                                            Future.delayed(Duration(milliseconds:1000));
                                            // if(selected_img == true)  addImage();
                                            // selected_img = false;
                                          }
                                          FocusScope.of(context).unfocus();
                                          messageTextInputCtl.clear();
                                          // Timer(
                                          //   Duration(milliseconds: 200),
                                          //   _scrollToBottom,
                                          // );
                                          // 
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                // メッセージ送信
                                Material(
                                  color: Colors.blue[100],
                                  child: Center(
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        color: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.send),
                                        color: Colors.white,
                                        onPressed: () {
                                          _addMessage(messageTextInputCtl.text);
                                          if(selected_img == true)  addImage();
                                            selected_img = false;
                                          FocusScope.of(context).unfocus();
                                          messageTextInputCtl.clear();
                                          // Timer(
                                          //   Duration(milliseconds: 200),
                                          //   _scrollToBottom,
                                          // );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ])),
                    ])),
              ],
            )
          ]);
        },
      ),
    );
  }
}
