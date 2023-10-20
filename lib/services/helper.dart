import 'package:flutter/services.dart' as the_bundle;
import 'package:http/http.dart' as http;
import 'package:sneakers_hub/models/sneakers_model.dart';
import 'package:sneakers_hub/services/config.dart';

class Helper {
  static var client = http.Client();

  /// Getting for the Male's Sneakers
  Future<List<SneakersModel>> getMenSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      final List<SneakersModel> maleList = sneakersFromJson(response.body);
      List<SneakersModel> male = maleList.where((element) => element.category == "Men's Running").toList();
      return male;
    } else {
      throw Exception("Failed to get men's sneakers list");
    }
  }

  /// Getting for the Female's Sneakers
  Future<List<SneakersModel>> getFemaleSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      final List<SneakersModel> femaleList = sneakersFromJson(response.body);
      List<SneakersModel> female = femaleList.where((element) => element.category == "Women's Running").toList();
      return female;
    } else {
      throw Exception("Failed to get women's sneakers list");
    }
  }

  /// Getting for the Kid's Sneakers
  Future<List<SneakersModel>> getKidsSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      final List<SneakersModel> kidsList = sneakersFromJson(response.body);
      List<SneakersModel> kids = kidsList.where((element) => element.category == "Kid's Running").toList();
      return kids;
    } else {
      throw Exception("Failed to get kids's sneakers list");
    }
  }

  /// Getting for the Single Male's Sneaker By ID
  Future<SneakersModel> getMenSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final List<SneakersModel> maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  /// Getting for the Single Female's Sneakers By ID
  Future<SneakersModel> getFemailSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final List<SneakersModel> femaleList = sneakersFromJson(data);

    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  /// Getting for the Single Kid's Sneakers By ID
  Future<SneakersModel> getKidsSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final List<SneakersModel> kidsList = sneakersFromJson(data);

    final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }
}
