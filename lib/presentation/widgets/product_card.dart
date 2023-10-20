import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_hub/controllers/providers/favorite_notifier.dart';
import 'package:sneakers_hub/presentation/screens/favourites_screen.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
  });

  final String id;
  final String name;
  final String image;
  final String category;
  final String price;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen: false);
    favoriteNotifier.getFavourites();

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
              Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.24,
                    width: screenWidth * 0.8,
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Consumer<FavoriteNotifier>(builder: (context, favNotifier, _) {
                      return GestureDetector(
                        onTap: () async {
                          if (favNotifier.favId.contains(widget.id)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavouritesScreen(),
                              ),
                            );
                          } else {
                            await favNotifier.createFav(
                              newFav: {
                                "id": widget.id,
                                "name": widget.name,
                                "category": widget.category,
                                "imageUrl": widget.image,
                                "price": widget.price,
                              },
                              context: context,
                            );
                          }
                          setState(() {});
                        },
                        child: favNotifier.favId.contains(widget.id)
                            ? const Icon(CommunityMaterialIcons.heart)
                            : const Icon(CommunityMaterialIcons.heart_outline),
                      );
                    }),
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
                      "\$${widget.price}",
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
