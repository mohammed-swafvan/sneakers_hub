import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_hub/models/sneakers_model.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';
import 'package:sneakers_hub/presentation/widgets/home_widget.dart';
import 'package:sneakers_hub/services/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController tabController = TabController(length: 3, vsync: this);

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
              padding: const EdgeInsets.fromLTRB(16, 35, 0, 0),
              height: screenHeight * 0.35,
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
                    BounceInDown(
                      child: SizedBox(
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
                          ],
                        ),
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
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.260),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    HomeWidget(
                      sneakers: male,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      sneakers: female,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      sneakers: kids,
                      tabIndex: 2,
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
