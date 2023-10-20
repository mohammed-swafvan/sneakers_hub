import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_hub/controllers/providers/main_screen_notifier.dart';
import 'package:sneakers_hub/presentation/screens/cart_screen.dart';
import 'package:sneakers_hub/presentation/screens/favourites_screen.dart';
import 'package:sneakers_hub/presentation/screens/home_screen.dart';
import 'package:sneakers_hub/presentation/screens/profile_screen.dart';
import 'package:sneakers_hub/presentation/screens/search_screen.dart';
import 'package:sneakers_hub/presentation/widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const FavouritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        body: pages[mainScreenNotifier.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
