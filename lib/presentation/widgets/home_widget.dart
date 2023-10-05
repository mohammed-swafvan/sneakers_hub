import 'package:animate_do/animate_do.dart';
import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_hub/controllers/providers/product_screen_notifier.dart';
import 'package:sneakers_hub/models/sneakers_model.dart';
import 'package:sneakers_hub/presentation/screens/product_by_cart.dart';
import 'package:sneakers_hub/presentation/screens/product_screen.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';
import 'package:sneakers_hub/presentation/widgets/new_shoe_card.dart';
import 'package:sneakers_hub/presentation/widgets/product_card.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required this.sneakers, required this.tabIndex});

  final int tabIndex;
  final Future<List<SneakersModel>> sneakers;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        FadeInRight(
          child: SizedBox(
            height: screenHeight * 0.42,
            child: FutureBuilder<List<SneakersModel>>(
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

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final SneakersModel shoe = snapshot.data![index];

                    return GestureDetector(
                      onTap: () {
                        productNotifier.sneakersSize = shoe.sizes;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              id: shoe.id,
                              category: shoe.category,
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        id: shoe.id,
                        name: shoe.name,
                        image: shoe.imageUrl[0],
                        price: "\$${shoe.price}",
                        category: shoe.category,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        FadeInLeft(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 18, 12, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest Shoes",
                  style: AppStyle.textStyle(24, Colors.black, FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductByCart(
                                  tabIndex: tabIndex,
                                )));
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: AppStyle.textStyle(14, Colors.black, FontWeight.w500),
                        ),
                        const Icon(
                          AntIcons.caret_right,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        FadeInRight(
          child: SizedBox(
            height: screenHeight * 0.13,
            child: FutureBuilder(
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

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final SneakersModel shoe = snapshot.data![index];

                    return NewShoesCard(
                      imageUrl: shoe.imageUrl[1],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
