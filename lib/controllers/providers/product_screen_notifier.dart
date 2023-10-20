import 'package:flutter/material.dart';
import 'package:sneakers_hub/models/sneakers_model.dart';
import 'package:sneakers_hub/services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int page = 0;
  List<dynamic> shoesSizes = [];
  List<String> size = [];
  late Future<List<SneakersModel>> male;
  late Future<List<SneakersModel>> female;
  late Future<List<SneakersModel>> kids;
  final PageController pageController = PageController();
  late Future<SneakersModel> sneakers;

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

  void getShoes(String category, String id) {
    if (category == "Men's Running") {
      sneakers = Helper().getMenSneakersById(id);
      notifyListeners();
    } else if (category == "Women's Running") {
      sneakers = Helper().getFemailSneakersById(id);
      notifyListeners();
    } else {
      sneakers = Helper().getKidsSneakersById(id);
      notifyListeners();
    }
  }

  void getMale() {
    male = Helper().getMenSneakers();
    notifyListeners();
  }

  void getFemale() {
    female = Helper().getFemaleSneakers();
    notifyListeners();
  }

  void getKids() {
    kids = Helper().getKidsSneakers();
    notifyListeners();
  }
}
