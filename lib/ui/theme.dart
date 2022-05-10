import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


const Color bluishClr = Color(0xffa03758);
const Color hashClr = Color(0xff3bcd99);
const Color yellowClr = Color(0xFFFFB746);
const Color pink = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242);


class Themes{
  static final light= ThemeData(
      appBarTheme: AppBarTheme(color : Colors.black26),
    brightness: Brightness.light
  );
  static final dark= ThemeData(
      appBarTheme: AppBarTheme(color: darkGreyClr),
      brightness: Brightness.dark
  );

}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.grey[400]:Colors.grey
    )
  );
}


TextStyle get headingStyle{
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}


TextStyle get categoryStyle{
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}


TextStyle get subCategoryStyle{
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600]
      )
  );
}