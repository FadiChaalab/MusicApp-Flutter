import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorChanger with ChangeNotifier {
  SharedPreferences prefs;
  Color accentColor;

  ColorChanger() {
    this.accentColor = Colors.indigo;
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    int c = prefs.getInt("color") ?? Colors.indigo.value;
    accentColor = Color(c);
  }

  setAccent(Color c) {
    int testingColorValue = c.value;
    prefs.setInt("color", testingColorValue);
    accentColor = c;
    notifyListeners();
  }

  getAccent() {
    return accentColor;
  }
}
