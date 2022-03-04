import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBoardModel extends ChangeNotifier {
  String? title;
  String? date;
  String? contributorID;

  Future addBoard() async{

    if(title == null || title == "") {
      throw 'タイトルが入力されていません';
    }

    // if(date == null || date!.isEmpty) {
    //   throw '時間が入力されていません';
    // }
    date = DateTime.now().toIso8601String();

    await FirebaseFirestore.instance.collection('posts').add({
      'title': title,
      'date': date,
      'contributorID': contributorID,
    });
  }
}