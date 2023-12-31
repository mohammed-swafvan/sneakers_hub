import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_hub/controllers/providers/cart_notifier.dart';
import 'package:sneakers_hub/presentation/screens/main_screen.dart';
import 'package:sneakers_hub/presentation/utils/custom_size.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';
import 'package:sneakers_hub/presentation/widgets/checkout_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartNotifier>(context, listen: false);
    cartProvider.cartInitialize();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSize.height30,
                Text(
                  "My Cart",
                  style: AppStyle.textStyle(34, Colors.black, FontWeight.bold),
                ),
                CustomSize.height10,
                SizedBox(
                  height: screenHeight * 0.65,
                  child: Consumer<CartNotifier>(builder: (context, cartNotifier, _) {
                    return ListView.builder(
                      itemCount: cartNotifier.cartList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = cartNotifier.cartList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) async {
                                      await cartNotifier.deleteCart(data["key"]);
                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(),
                                          ),
                                        );
                                      }
                                    },
                                    flex: 1,
                                    backgroundColor: const Color(0xFF000000),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
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
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: CachedNetworkImage(
                                            imageUrl: data["imageUrl"][1],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12, left: 20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['name'],
                                                style: AppStyle.textStyle(16, Colors.black, FontWeight.bold),
                                              ),
                                              Text(
                                                data['category'],
                                                style: AppStyle.textStyle(14, Colors.grey, FontWeight.w500),
                                              ),
                                              Text(
                                                "\$${data['price']}",
                                                style: AppStyle.textStyle(18, Colors.black, FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    cartProvider.decrementCount();
                                                  },
                                                  child: const Icon(
                                                    AntIcons.minus_square,
                                                    size: 20,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  data['quantity'].toString(),
                                                  style: AppStyle.textStyle(
                                                    12,
                                                    Colors.black,
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cartProvider.incrementCount();
                                                  },
                                                  child: const Icon(
                                                    AntIcons.plus_square,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(
                text: "Proceed to Checkout",
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
