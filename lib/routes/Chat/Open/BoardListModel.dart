import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Board.dart';
import 'package:flutter_application_1/routes/Chat/Open/MutterListModel.dart';

class BoardListModel extends ChangeNotifier {
  final  _userBoard = FirebaseFirestore.instance.collection("posts");

  List<Board>? boards;

  void fetchBoardList() async{
    final QuerySnapshot snapshot = await _userBoard.get();

    final List<Board> boards = snapshot.docs.map((DocumentSnapshot document) {

      Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String date = data['date'];
      final String contributorID = data['contributorID'];
      
      return Board(id, title, date, contributorID);
    }).toList();

      this.boards = boards;
      notifyListeners();
  }

  Future deleteboard(Board board) {
    FirebaseFirestore.instance.collection("mutter").doc('${board.title}').delete();
    return FirebaseFirestore.instance.collection("posts").doc(board.id).delete();
  }
}