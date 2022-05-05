import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/routes/Chat/Personal/domain/Personal.dart';
import 'package:flutter_application_1/user.dart';
import 'package:provider/provider.dart';

class PersonalChatModel extends ChangeNotifier {
  List<Personal>? friends;

  void fetchPersonalChat() async {
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    final QuerySnapshot chatRoomSnapshot = await FirebaseFirestore.instance
        .collection("chat_room")
        // .orderBy("createdAt", descending: true)
        .where("users.$myUserId", isEqualTo: true)
        .get();

    List<Personal> personals = [];

    for (var document in chatRoomSnapshot.docs) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
      final List users = (document["users"] as Map).keys.toList();
      print("Users: $users");

      final slaveId = users.firstWhere(
        (user) {
          return user != myUserId;
        },
      );

      print("相手のユーザーID: $slaveId");
      final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("user")
          .where("userID", isEqualTo: slaveId)
          .get();
      final slaveProfile =
          userSnapshot.docs.first.data() as Map<String, dynamic>;
      final slaveName = slaveProfile["userName"];
      print(slaveName);

      personals.add(Personal(slaveId, slaveName, document.id));
    }

    this.friends = personals;
    notifyListeners();
  }

  Future deletefriend(Personal friend) {
    return FirebaseFirestore.instance
        .collection("chat_room")
        .doc(friend.documentId)
        .delete();
  }
}
