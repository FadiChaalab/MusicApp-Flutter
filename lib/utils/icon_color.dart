import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IconChanger with ChangeNotifier {
  SharedPreferences prefs;
  Color iconColor;

  IconChanger() {
    this.iconColor = Colors.blue;
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    int i = prefs.getInt("iconColor") ?? Colors.blue.value;
    iconColor = Color(i);
  }

  setIcon(Color i) {
    int testingColorValue = i.value;
    prefs.setInt("iconColor", testingColorValue);
    iconColor = i;
    notifyListeners();
  }

  getIcon() {
    return iconColor;
  }
}
