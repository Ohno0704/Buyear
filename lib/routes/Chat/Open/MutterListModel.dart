import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Mutter.dart';

class MutterListModel extends ChangeNotifier {
  // String? boardTitle;

  List<Mutter>? mutters;

  void fetchMutterList(String boardTitle) async{
    final  _mutters = FirebaseFirestore.instance.collection("mutter").doc('${boardTitle}').collection('コメント');
    final QuerySnapshot snapshot = await _mutters.get();

    final List<Mutter> mutters = snapshot.docs.map((DocumentSnapshot document) {

      Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      // final String title = data['title'];
      final String date = data['date'];
      final String comment = data['comment'];
      final String contributorID = data['contributorID'];
      
      return Mutter(id, date, comment, contributorID);
    }).toList();

      this.mutters = mutters;
      notifyListeners();
  }

  Future deleteboard(Mutter mutter) {
    return FirebaseFirestore.instance.collection("mutter").doc(mutter.id).delete();
  }
}