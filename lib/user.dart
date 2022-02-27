import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserState extends ChangeNotifier {
  User? user;
  String? userName;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }

  void setUserName(String newUserName) {
    FirebaseFirestore.instance.collection('user').add({
      'userName': newUserName,
    });
    notifyListeners();
  }
}