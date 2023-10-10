import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_hub/controllers/providers/favorite_notifier.dart';
import 'package:sneakers_hub/presentation/screens/main_screen.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key, required this.isInsideTheScreen});
  final bool isInsideTheScreen;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var favProvider = Provider.of<FavoriteNotifier>(context, listen: false);
      favProvider.getAllData();
    });
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Consumer<FavoriteNotifier>(
          builder: (context, favnotifier, _) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 35, 0, 0),
                  height: screenHeight * 0.35,
                  width: screenWidth,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "My Favorites",
                      style: AppStyle.textStyle(
                        36,
                        Colors.white,
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isInsideTheScreen,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        AntIcons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                favnotifier.favList.isEmpty
                    ? Center(
                        child: Text(
                          "No Favorites",
                          style: AppStyle.textStyle(
                            18,
                            Colors.black,
                            FontWeight.bold,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: favnotifier.favList.length,
                          padding: const EdgeInsets.only(top: 90),
                          itemBuilder: (context, index) {
                            final shoe = favnotifier.favList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: screenHeight * 0.11,
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 5,
                                        blurRadius: 0.3,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: CachedNetworkImage(
                                              imageUrl: shoe["imageUrl"],
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 12, left: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  shoe['name'],
                                                  style: AppStyle.textStyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  shoe['category'],
                                                  style: AppStyle.textStyle(
                                                    14,
                                                    Colors.grey,
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "\$${shoe['price']}",
                                                      style: AppStyle.textStyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Consumer<FavoriteNotifier>(builder: (context, favNotifier, _) {
                                          return GestureDetector(
                                            onTap: () async {
                                              await favNotifier.deleteFav(shoe["key"]);
                                              favNotifier.favId.removeWhere((element) => element == shoe["id"]);
                                              if (context.mounted) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => MainScreen(),
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Icon(Ionicons.heart_dislike),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
