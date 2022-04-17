import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBoardModel extends ChangeNotifier {
  String? documentID;
  String? title;
  String? date;
  String? contributorID;
  final now = DateTime.now();

  Future addBoard() async {
    if (title == null || title == "") {
      throw 'タイトルが入力されていません';
    }

    // if(date == null || date!.isEmpty) {
    //   throw '時間が入力されていません';
    // }
    date = DateTime.now().toIso8601String();

    await FirebaseFirestore.instance.collection('posts').add({
      'createdAt': now,
      'title': title,
      'date': date,
      'contributorID': contributorID,
    });

    await FirebaseFirestore.instance
        .collection('mutter')
        .doc('${documentID}')
        .collection('コメント')
        .add({
      'comment': 'なにかつぶやいてみましょう！',
      'contributorID': contributorID,
      'date': DateTime.now().toIso8601String(),
    });
  }
}
