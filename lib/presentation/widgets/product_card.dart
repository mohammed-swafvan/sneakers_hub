import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sneakers_hub/models/constants.dart';
import 'package:sneakers_hub/presentation/screens/favourites_screen.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });

  final String id;
  final String name;
  final String image;
  final String price;
  final String category;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final favBox = Hive.box('fav_box');

    getFavourites() {
      final favData = favBox.keys.map((key) {
        final item = favBox.get(key);
        return {
          "key": key,
          "id": item["id"],
        };
      }).toList();
      favor = favData.toList();
      ids = favBox.keys.map((item) => item["id"]).toList();
      setState(() {});
    }

    Future<void> createFav(Map<String, dynamic> newFav) async {
      await favBox.add(newFav);
      getFavourites();
    }

    bool selected = true;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: screenHeight,
          width: screenWidth * 0.7,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.24,
                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.image))),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (ids.contains(widget.id)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavouritesScreen(),
                            ),
                          );
                        } else {
                          await createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "imageUrl": widget.image,
                            "price": widget.price,
                          });
                        }
                      },
                      child: ids.contains(widget.id)
                          ? const Icon(CommunityMaterialIcons.heart)
                          : const Icon(CommunityMaterialIcons.heart_outline),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppStyle.textStyleWithHt(32, Colors.black, FontWeight.bold, 1.2),
                    ),
                    Text(
                      widget.category,
                      style: AppStyle.textStyle(14, Colors.grey, FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: AppStyle.textStyle(24, Colors.black, FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          "Colors",
                          style: AppStyle.textStyle(16, Colors.grey, FontWeight.w400),
                        ),
                        const SizedBox(width: 5),
                        ChoiceChip(
                          shape: const StadiumBorder(),
                          label: const Text(""),
                          selected: selected,
                          showCheckmark: false,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          selectedColor: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
