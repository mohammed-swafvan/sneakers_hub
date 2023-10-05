import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int page = 0;

  int get activePage => page;

  set activePage(int newIndex) {
    page = newIndex;
    notifyListeners();
  }
}
