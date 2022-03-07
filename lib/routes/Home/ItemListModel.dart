import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Home/domain/Item.dart';

class ItemListModel extends ChangeNotifier {
  final  _userItem = FirebaseFirestore.instance.collection("items");

  List<Item>? items;

  void fetchItemList() async{
    final QuerySnapshot snapshot = await _userItem.get();

    final List<Item> items = snapshot.docs.map((DocumentSnapshot document) {

      Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String contributorID = data['contributor'];
      final String itemURL = data['itemURL'];
      final String price = data['price'];
      final String text = data['text'];
      final String userName = data['userName'];
      
      return Item(id, contributorID, itemURL, price, text, userName);
    }).toList();

      this.items = items;
      notifyListeners();
  }

  Future deleteboard(Item item) {
    return FirebaseFirestore.instance.collection("itemURL").doc(item.id).delete();
  }
}