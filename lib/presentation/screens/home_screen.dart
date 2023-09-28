import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';
import 'package:sneakers_hub/presentation/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController tabController = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: screenHeight * 0.4,
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(60),
                  bottomStart: Radius.circular(60),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/top_image.jpeg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 8, bottom: 15),
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Athletics Shoes",
                      style: AppStyle.textStyleWithHt(42, Colors.white, FontWeight.bold, 1.5),
                    ),
                    Text(
                      "Collection",
                      style: AppStyle.textStyleWithHt(42, Colors.white, FontWeight.bold, 1.2),
                    ),
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: AppStyle.textStyle(22, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs: const [
                        Tab(text: "Men Shoes"),
                        Tab(text: "Women Shoes"),
                        Tab(text: "Kids Shoes"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.265),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.43,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return const ProductCard(
                                id: "1",
                                name: "Nike",
                                image:
                                    "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464-978x1024.png",
                                price: "\$20.00",
                                category: "Men's Running",
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latest Shoes",
                                style: AppStyle.textStyle(24, Colors.black, FontWeight.bold),
                              ),
                              Row(
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.13,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.26,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 1,
                                        blurRadius: 0.8,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://www.effectiveecommerce.com/wp-content/uploads/2020/02/nike-shoe-png-nike-shoes-transparent-png-1464-978x1024.png",
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: screenHeight * 0.405,
                          color: Colors.amber,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: screenHeight * 0.405,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
