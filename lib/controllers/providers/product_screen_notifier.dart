import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int page = 0;
  List<dynamic> shoesSizes = [];

  int get activePage => page;

  set activePage(int newIndex) {
    page = newIndex;
    notifyListeners();
  }

  List<dynamic> get sneakersSize => shoesSizes;

  set sneakersSize(List<dynamic> newSizes) {
    shoesSizes = newSizes;
    notifyListeners();
  }

  void toggleChech(int index) {
    for (var i = 0; i < shoesSizes.length; i++) {
      if (i == index) {
        shoesSizes[i]['isSelected'] = !shoesSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }
}
