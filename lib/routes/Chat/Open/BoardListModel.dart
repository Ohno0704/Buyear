import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Board.dart';

class BoardListModel extends ChangeNotifier {
  final  _userBoard = FirebaseFirestore.instance.collection("posts");

  List<Board>? boards;

  void fetchBoardList() async{
    final QuerySnapshot snapshot = await _userBoard.get();

    final List<Board> boards = snapshot.docs.map((DocumentSnapshot document) {

      Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
      final String title = data['content'];
      final String date = data['date'];
      // if (data['date'] == null) data['date'] = '';
      
      return Board(title, date);
    }).toList();

      this.boards = boards;
      notifyListeners();
  }
}