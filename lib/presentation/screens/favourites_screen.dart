import 'package:flutter/material.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Favourites",
          style: AppStyle.textStyle(40, Colors.black, FontWeight.bold),
        ),
      ),
    );
  }
}