import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartNotifier extends ChangeNotifier {
  final cartBox = Hive.box('cart_box');
  List<dynamic> cart = [];
  int count = 0;

  int get counter => count;
  List<dynamic> get cartList => cart;

  set cartList(List<dynamic> newCartList) {
    cart = newCartList;
    notifyListeners();
  }

  cartInitialize() {
    final cartData = cartBox.keys.map((key) {
      final item = cartBox.get(key);
      return {
        "key": key,
        "id": item["id"],
        "category": item["category"],
        "name": item["name"],
        "imageUrl": item["imageUrl"],
        "price": item["price"],
        "quantity": item["quantity"],
        "sizes": item["sizes"],
      };
    }).toList();
    cart = cartData.reversed.toList();
    notifyListeners();
  }

  Future<void> createCart(Map<String, dynamic> newCart) async {
    await cartBox.add(newCart);
    notifyListeners();
  }

  Future<void> deleteCart(int key) async {
    await cartBox.delete(key);
    notifyListeners();
  }

  void incrementCount() {
    count++;
    notifyListeners();
  }

  void decrementCount() {
    if (count >= 1) {
      count--;
      notifyListeners();
    }
  }
}
