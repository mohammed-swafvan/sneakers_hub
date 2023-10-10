import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<dynamic> ids = [];
  List<dynamic> favorites = [];
  List<dynamic> fav = [];

  final favBox = Hive.box('fav_box');

  List<dynamic> get favId => ids;
  List<dynamic> get favoritesData => favorites;
  List<dynamic> get favList => fav;

  set favId(List<dynamic> newId) {
    ids.add(newId);
    notifyListeners();
  }

  set favoritesData(List<dynamic> newFavorites) {
    favorites = newFavorites;
    notifyListeners();
  }

  set favList(List<dynamic> newFav) {
    fav = newFav;
    notifyListeners();
  }

  getAllData() {
    final favData = favBox.keys.map((key) {
      final item = favBox.get(key);
      return {
        "key": key,
        "id": item["id"],
        "name": item["name"],
        "category": item["category"],
        "price": item["price"],
        "imageUrl": item["imageUrl"],
      };
    }).toList();
    fav = favData.reversed.toList();
    notifyListeners();
  }

  getFavourites() {
    final favData = favBox.keys.map((key) {
      final item = favBox.get(key);
      return {
        "key": key,
        "id": item["id"],
      };
    }).toList();
    favorites = favData.toList();
    favId = favBox.keys.map((item) => item["id"]).toList();
    notifyListeners();
  }

  Future<void> createFav({required Map<String, dynamic> newFav,required BuildContext context}) async {
    await favBox.add(newFav);
    favId.add(newFav["id"]);
    if (context.mounted) {
      AppStyle.showSnackbar("Added to Favorite", context);
    }
    notifyListeners();
  }

  deleteFav(int key) async {
    await favBox.delete(key);
    notifyListeners();
  }
}
