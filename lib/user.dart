import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  User? user;
  String? userName;
  String? userIntroduce;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }

  void setUserName(String newUserName) {
    userName = newUserName;
    notifyListeners();
  }

  void setIntroduce(String newIntroduce) {
    userIntroduce = newIntroduce;
  }
}