import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {

  int index = 0;

  int get pageIndex => index;

  set pageIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }
  
}
