import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
 
class AddBoard2 extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  _onSubmitted(String content){
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    posts.add({
      "content": content
    });
    
    /// 入力欄をクリアにする
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text("掲示板に投稿しよう！"),
        gradient:
          LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade300, Colors.blue.shade400])
      ),
      body: Center(
        child: TextField(
          controller: _textEditingController,
          onSubmitted: _onSubmitted,
          enabled: true,
          maxLength: 50, // 入力数
          maxLengthEnforced: false, // 入力上限になったときに、文字入力を抑制するか
          style: TextStyle(color: Colors.black),
          obscureText: false,
          maxLines:1 ,
          decoration: const InputDecoration(
            icon: Icon(Icons.speaker_notes),
            hintText: '投稿内容を記載します',
            labelText: '投稿内容 * ',
          ),
        ),
      ),
    );
  }
}