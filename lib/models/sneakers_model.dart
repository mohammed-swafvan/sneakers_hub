import 'dart:convert';

List<SneakersModel> sneakersFromJson(String str) =>
    List<SneakersModel>.from(json.decode(str).map((x) => SneakersModel.fromJson(x)));

String sneakersToJson(List<SneakersModel> data) => json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "imageUrl": imageUrl,
        "oldPrice": oldPrice,
        "price": price,
        "sizes": sizes,
        "description": description,
        "title": title,
      };
}
