import 'dart:convert';

List<SneakersModel> sneakersFromJson(String str) => List<SneakersModel>.from(json.decode(str).map((x) => SneakersModel.fromJson(x)));

class SneakersModel {
  SneakersModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.price,
    required this.sizes,
    required this.description,
    required this.title,
  });

  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final String price;
  final List<dynamic> sizes;
  final String description;
  final String title;

  factory SneakersModel.fromJson(Map<String, dynamic> json) => SneakersModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        price: json["price"],
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        description: json["description"],
        title: json["title"],
      );
}
