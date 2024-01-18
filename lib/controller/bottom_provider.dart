import 'package:flutter/material.dart';

class BottomProvider extends ChangeNotifier {
  int currentIndexValue = 0;
  void bottomNav(int index) {
    currentIndexValue = index;
    notifyListeners();
  }
}
