import 'package:flutter/material.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, this.onTap, required this.buttonColor, required this.label});

  final void Function()? onTap;
  final Color buttonColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: onTap,
      child: Container(
        height: 45,
        width: screenWidth * 0.25,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonColor,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(9)),
        ),
        child: Center(
          child: Text(
            label,
            style: AppStyle.textStyle(18, buttonColor, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
