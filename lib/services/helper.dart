import 'package:flutter/services.dart' as the_bundle;
import 'package:sneakers_hub/models/sneakers_model.dart';

class Helper {
  /// Getting for the Male's Sneakers
  Future<List<SneakersModel>> getMenSneakers() async {
    
    final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final List<SneakersModel> maleList = sneakersFromJson(data);

    return maleList;
  }

  /// Getting for the Female's Sneakers
  Future<List<SneakersModel>> getFemaleSneakers() async {
    final data = await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final List<SneakersModel> femaleList = sneakersFromJson(data);

    return femaleList;
  }

  /// Getting for the Kid's Sneakers
  Future<List<SneakersModel>> getKidsSneakers() async {
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final List<SneakersModel> kidsList = sneakersFromJson(data);

    return kidsList;
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
