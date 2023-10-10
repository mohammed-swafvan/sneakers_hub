import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneakers_hub/presentation/utils/custom_colors.dart';

class AppStyle {
  static TextStyle textStyle(double size, Color color, FontWeight fw) {
    return GoogleFonts.poppins(
      fontSize: size,
      color: color,
      fontWeight: fw,
    );
  }

  static TextStyle textStyleWithHt(double size, Color color, FontWeight fw, double height) {
    return GoogleFonts.poppins(
      fontSize: size,
      color: color,
      fontWeight: fw,
      height: height,
    );
  }

  static showSnackbar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: CustomColors.backGroundColor,
        content: Container(
          alignment: Alignment.center,
          child: Text(
            content,
            style: AppStyle.textStyle(
              16,
              Colors.black,
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
