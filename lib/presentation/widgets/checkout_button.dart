import 'package:flutter/material.dart';
import 'package:sneakers_hub/presentation/widgets/app_style.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key, required this.text, required this.onTap});

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            text,
            style: AppStyle.textStyle(
              18,
              Colors.white,
              FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
