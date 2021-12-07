import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Chat/Open/domain/Board.dart';

class BoardListModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _userStream =
  FirebaseFirestore.instance.collection("posts").snapshots();

  List<Board>? boards;

  void fetchBoardList() {
    _userStream.listen((QuerySnapshot snapshot) {

      final List<Board> boards = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String title = data['content'];
        final String date = data['date'];
        var time = DateTime.now();
        return Board(title, date);
      }).toList();

      this.boards = boards;
      notifyListeners();
    });
  }
}
// return Card(
//                   child: ListTile(
//                     title: Text(document['content']),
//                     subtitle: Text(document['date']),
//                     //Text('${appTime.year}/${appTime.month}/${appTime.day}'),
//                     onTap:() {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      // return OpenChatting(document['content']);
                      // }));
//                     },
//                   ),
//                 );