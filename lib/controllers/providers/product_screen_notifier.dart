import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int page = 0;
  List<dynamic> shoesSizes = [];
  List<String> size = [];

  int get activePage => page;
  List<dynamic> get sneakersSize => shoesSizes;
  List<String> get sizes => size;

  set activePage(int newIndex) {
    page = newIndex;
    notifyListeners();
  }

  set sneakersSize(List<dynamic> newSizes) {
    shoesSizes = newSizes;
    notifyListeners();
  }

  set sizes(List<String> newSize) {
    size = newSize;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (var i = 0; i < shoesSizes.length; i++) {
      if (i == index) {
        shoesSizes[i]['isSelected'] = !shoesSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }
}
