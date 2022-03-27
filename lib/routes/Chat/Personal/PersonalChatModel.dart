import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Chat/Personal/domain/Personal.dart';

class PersonalChatModel extends ChangeNotifier {
  final  _userList = FirebaseFirestore.instance.collection("chat_room");

  List<Personal>? friends;

  void fetchPersonalChat() async{
    final QuerySnapshot snapshot = await _userList.get();

    final List<Personal> friends = snapshot.docs.map((DocumentSnapshot document) {

      Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String name = data['name'];
      // final String date = data['date'];
      // final String text = data['text'];
      // final String uid = data['uid'];
      
      // return Personal(id, name, date, text, uid);
      return Personal(id, name);
    }).toList();

      this.friends = friends;
      notifyListeners();
  }

  Future deletefriend(Personal friend) {
    return FirebaseFirestore.instance.collection("chat_room").doc(friend.id).delete();
  }
}