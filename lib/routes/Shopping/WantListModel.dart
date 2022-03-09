import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Shopping/domain/WantList.dart';

class WantListModel extends ChangeNotifier {
  final  _userWantList = FirebaseFirestore.instance.collection("wantList");

  List<WantList>? wantLists;

  void fetchWantList() async{
    final QuerySnapshot snapshot = await _userWantList.get();

    final List<WantList> wantLists = snapshot.docs.map((DocumentSnapshot document) {

      Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String contributorID = data['contributorID'];
      final String date = data['date'];
      final String itemURL = data['itemURL'];
      final String price = data['price'];
      final String text = data['text'];
      final String title = data['title'];
      final String userName= data['userName'];
      
      return WantList(id, contributorID, date, itemURL, price, text, title, userName);
    }).toList();

      this.wantLists = wantLists;
      notifyListeners();
  }

  Future deleteboard(WantList wantList) {
    return FirebaseFirestore.instance.collection("wantList").doc(wantList.id).delete();
  }
}