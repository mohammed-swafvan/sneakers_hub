import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_hub/controllers/providers/product_screen_notifier.dart';
import 'package:sneakers_hub/models/sneakers_model.dart';
import 'package:sneakers_hub/services/helper.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<SneakersModel> sneakers;

  @override
  void initState() {
    getShoes();
    super.initState();
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
    final PageController pageController = PageController();
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
                                      top: screenHeight * 0.09,
                                      right: 20,
                                      child: const Icon(
                                        AntIcons.heart_outline,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
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
