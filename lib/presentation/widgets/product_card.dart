import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class ProductCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(CommunityMaterialIcons.heart_outline),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.23,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(image))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppStyle.textStyleWithHt(34, Colors.black, FontWeight.bold, 1.3),
                    ),
                    Text(
                      category,
                      style: AppStyle.textStyleWithHt(16, Colors.grey, FontWeight.w500, 1.2),
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
                      price,
                      style: AppStyle.textStyleWithHt(28, Colors.black, FontWeight.w600, 1.1),
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
