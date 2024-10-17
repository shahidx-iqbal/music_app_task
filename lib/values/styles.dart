import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static TextStyle customTextStylePopins(
      {double fontSize = 40,
      FontWeight? fontWeight,
      Color color = Colors.white,
      TextDecoration? textDecoration}) {
    return GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration);
  }

}