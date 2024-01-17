import 'package:flutter/material.dart';

class BottomProvider extends ChangeNotifier {
  int currentIndexValue = 0;
  void bottomNav(int index) {
    // print('Changing index to: $index');
    currentIndexValue = index;
    notifyListeners();
  }
}
