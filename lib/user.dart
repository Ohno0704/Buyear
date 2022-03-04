import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  User? user;
  String? userName;
  String userIntroduce = "更新してください";
  String? userID;

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
    notifyListeners();
  }

  void setUserID(String newUserID) {
    userID = newUserID;
    notifyListeners();
  }
}