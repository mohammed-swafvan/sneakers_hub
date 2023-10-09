import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_hub/controllers/providers/product_screen_notifier.dart';
import 'package:sneakers_hub/models/constants.dart';
import 'package:sneakers_hub/models/sneakers_model.dart';
import 'package:sneakers_hub/presentation/screens/favourites_screen.dart';
import 'package:sneakers_hub/presentation/utils/custom_size.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';
import 'package:sneakers_hub/presentation/widgets/checkout_button.dart';
import 'package:sneakers_hub/services/helper.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final PageController pageController = PageController();
  late Future<SneakersModel> sneakers;

  final cartBox = Hive.box('cart_box');
  final favBox = Hive.box('fav_box');

  @override
  void initState() {
    getShoes();
    super.initState();
  }

  Future<void> createCart(Map<String, dynamic> newCart) async {
    await cartBox.add(newCart);
  }

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

  void getShoes() {
    if (widget.category == "Men's Running") {
      sneakers = Helper().getMenSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      sneakers = Helper().getFemailSneakersById(widget.id);
    } else {
      sneakers = Helper().getKidsSneakersById(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<SneakersModel>(
        future: sneakers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Erro: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("List is empty"),
            );
          }
          return Consumer<ProductNotifier>(
            builder: (context, productNotifier, child) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leadingWidth: 0,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              productNotifier.sneakersSize.clear();
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              AntIcons.close,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Ionicons.ellipsis_horizontal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                    snap: false,
                    floating: true,
                    backgroundColor: Colors.transparent,
                    expandedHeight: screenHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.5,
                            width: screenWidth,
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.imageUrl.length,
                              controller: pageController,
                              onPageChanged: (page) {
                                productNotifier.activePage = page;
                              },
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: screenHeight * 0.39,
                                      width: screenWidth,
                                      color: Colors.grey.shade300,
                                      child: Center(
                                        child: SizedBox(
                                          height: screenHeight * 0.25,
                                          width: screenWidth * 0.55,
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!.imageUrl[index],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: screenHeight * 0.08,
                                      right: 20,
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
                                              "id": snapshot.data!.id,
                                              "name": snapshot.data!.name,
                                              "category": snapshot.data!.category,
                                              "imageUrl": snapshot.data!.imageUrl[0],
                                              "price": snapshot.data!.price,
                                            });
                                          }
                                        },
                                        child: ids.contains(widget.id)
                                            ? const Icon(
                                                AntIcons.heart,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                AntIcons.heart_outline,
                                                color: Colors.grey,
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 3,
                                      right: 0,
                                      left: 0,
                                      height: screenHeight * 0.3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: List<Widget>.generate(
                                          snapshot.data!.imageUrl.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4),
                                            child: CircleAvatar(
                                              radius: 5,
                                              backgroundColor: productNotifier.activePage != index ? Colors.grey : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              child: Container(
                                height: screenHeight * 0.6,
                                width: screenWidth,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.name,
                                        style: AppStyle.textStyle(
                                          35,
                                          Colors.black,
                                          FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data!.category,
                                            style: AppStyle.textStyle(
                                              18,
                                              Colors.grey,
                                              FontWeight.w500,
                                            ),
                                          ),
                                          CustomSize.width20,
                                          RatingBar.builder(
                                            initialRating: 4.5,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 22,
                                            itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                                            itemBuilder: (context, item) {
                                              return const Icon(
                                                Icons.star,
                                                size: 18,
                                                color: Colors.black,
                                              );
                                            },
                                            onRatingUpdate: (rating) {},
                                          ),
                                        ],
                                      ),
                                      CustomSize.height15,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${snapshot.data!.price}",
                                            style: AppStyle.textStyle(
                                              24,
                                              Colors.black,
                                              FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Colors",
                                                style: AppStyle.textStyle(
                                                  16,
                                                  Colors.black,
                                                  FontWeight.w600,
                                                ),
                                              ),
                                              CustomSize.width5,
                                              const CircleAvatar(
                                                radius: 6,
                                                backgroundColor: Colors.black,
                                              ),
                                              CustomSize.width5,
                                              const CircleAvatar(
                                                radius: 6,
                                                backgroundColor: Colors.red,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      CustomSize.height15,
                                      Row(
                                        children: [
                                          Text(
                                            "Select sizes",
                                            style: AppStyle.textStyle(
                                              18,
                                              Colors.black,
                                              FontWeight.w600,
                                            ),
                                          ),
                                          CustomSize.width20,
                                          Text(
                                            "View size guide",
                                            style: AppStyle.textStyle(
                                              18,
                                              Colors.grey,
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomSize.height10,
                                      SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                          itemCount: productNotifier.sneakersSize.length,
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final size = productNotifier.sneakersSize[index];
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              child: ChoiceChip(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(60),
                                                  side: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                    style: BorderStyle.solid,
                                                  ),
                                                ),
                                                showCheckmark: false,
                                                materialTapTargetSize: MaterialTapTargetSize.padded,
                                                visualDensity: const VisualDensity(horizontal: -4, vertical: -1),
                                                disabledColor: Colors.white,
                                                label: Text(
                                                  size['size'],
                                                  style: AppStyle.textStyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                                selected: size['isSelected'],
                                                onSelected: (value) {
                                                  if (productNotifier.size.contains(size['size'])) {
                                                    productNotifier.size.remove(size['size']);
                                                  } else {
                                                    productNotifier.size.add(size['size']);
                                                  }
                                                  productNotifier.toggleCheck(index);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      CustomSize.height10,
                                      const Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.grey,
                                      ),
                                      CustomSize.height10,
                                      SizedBox(
                                        width: screenWidth * 0.8,
                                        child: Text(
                                          snapshot.data!.title,
                                          style: AppStyle.textStyle(
                                            24,
                                            Colors.black,
                                            FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      CustomSize.height10,
                                      SizedBox(
                                        child: Text(
                                          snapshot.data!.description,
                                          maxLines: 4,
                                          textAlign: TextAlign.justify,
                                          style: AppStyle.textStyle(
                                            14,
                                            Colors.black,
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      CustomSize.height15,
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CheckoutButton(
                                          text: "Add to Cart",
                                          onTap: () async {
                                            await createCart({
                                              "id": snapshot.data!.id,
                                              "name": snapshot.data!.name,
                                              "category": snapshot.data!.category,
                                              "sizes": productNotifier.sizes,
                                              "imageUrl": snapshot.data!.imageUrl,
                                              "price": snapshot.data!.price,
                                              "quantity": 1,
                                            });
                                            productNotifier.sizes.clear();
                                            if (context.mounted) {
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
