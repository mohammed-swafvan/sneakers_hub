import 'package:flutter/material.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Profile",
          style: AppStyle.textStyle(40, Colors.black, FontWeight.bold),
        ),
      ),
    );
  }
}