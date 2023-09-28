import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  
}
