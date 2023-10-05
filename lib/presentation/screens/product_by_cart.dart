import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneakers_hub/models/sneakers_model.dart';
import 'package:sneakers_hub/presentation/utils/custom_size.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';
import 'package:sneakers_hub/presentation/widgets/category_button.dart';
import 'package:sneakers_hub/presentation/widgets/latest_shoes.dart';
import 'package:sneakers_hub/services/helper.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart> with TickerProviderStateMixin {
  late final TabController tabController = TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);

  late Future<List<SneakersModel>> male;
  late Future<List<SneakersModel>> female;
  late Future<List<SneakersModel>> kids;

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  void getMale() {
    male = Helper().getMenSneakers();
  }

  void getFemale() {
    female = Helper().getFemaleSneakers();
  }

  void getKids() {
    kids = Helper().getKidsSneakers();
  }

  List<String> brand = [
    "assets/images/addidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.jpeg",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 35, 0, 0),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntIcons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesomeIcons.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicator: const BoxDecoration(),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    controller: tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: AppStyle.textStyle(22, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.4),
                    tabs: const [
                      Tab(text: "Men Shoes"),
                      Tab(text: "Women Shoes"),
                      Tab(text: "Kids Shoes"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.16, left: 16, right: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    LatestShoes(shoe: male),
                    LatestShoes(shoe: female),
                    LatestShoes(shoe: kids),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() async {
    double value = 100;
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Column(
            children: [
              CustomSize.height10,
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      CustomSize.height25,
                      Text(
                        "Filter",
                        style: AppStyle.textStyle(36, Colors.black, FontWeight.bold),
                      ),
                      CustomSize.height25,
                      Text(
                        "Gender",
                        style: AppStyle.textStyle(18, Colors.black, FontWeight.bold),
                      ),
                      CustomSize.height20,
                      const Row(
                        children: [
                          CategoryButton(buttonColor: Colors.black, label: "Man"),
                          CategoryButton(buttonColor: Colors.grey, label: "Women"),
                          CategoryButton(buttonColor: Colors.grey, label: "Kids"),
                        ],
                      ),
                      CustomSize.height25,
                      Text(
                        "Category",
                        style: AppStyle.textStyle(18, Colors.black, FontWeight.w600),
                      ),
                      CustomSize.height20,
                      const Row(
                        children: [
                          CategoryButton(buttonColor: Colors.black, label: "Shoes"),
                          CategoryButton(buttonColor: Colors.grey, label: "Apparels"),
                          CategoryButton(buttonColor: Colors.grey, label: "Accessory"),
                        ],
                      ),
                      CustomSize.height25,
                      Text(
                        "Price",
                        style: AppStyle.textStyle(18, Colors.black, FontWeight.bold),
                      ),
                      CustomSize.height25,
                      Slider(
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500,
                        divisions: 50,
                        label: value.toString(),
                        secondaryTrackValue: 200,
                        value: value,
                        onChanged: (value) {},
                      ),
                      CustomSize.height25,
                      Text(
                        "Brand",
                        style: AppStyle.textStyle(18, Colors.black, FontWeight.bold),
                      ),
                      CustomSize.height20,
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 70,
                        child: ListView.builder(
                            itemCount: brand.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200, borderRadius: const BorderRadius.all(Radius.circular(12))),
                                  child: Image.asset(
                                    brand[index],
                                    height: 70,
                                    width: 80,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
