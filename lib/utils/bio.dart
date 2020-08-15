import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBio with ChangeNotifier {
  String bio;
  SharedPreferences prefs;

  UserBio() {
    this.bio = "Write something about yourself";
    init();
  }
  init() async {
    prefs = await SharedPreferences.getInstance();
    String temp = prefs.getString("bio") ?? "bio";
    bio = temp;
  }

  setBio(String x) {
    prefs.setString("bio", x);
    bio = x;
    notifyListeners();
  }

  getBio() {
    return bio;
  }
}
