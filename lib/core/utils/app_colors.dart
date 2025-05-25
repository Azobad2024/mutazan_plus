import 'package:flutter/material.dart';

abstract class AppColors {
  static Color primaryColor = const Color(0xffBCCCDC);
  static Color offWhite = const Color(0xffF8F4F9);
  static Color deepBrown = const Color(0xffBCCCDC);
  static Color deepGrey = const Color(0xffBCCCDC);

////////////////////----------////////////

  static Color? primaryBackgroundColor = Colors.grey[200];
  static Color backgroundColor = const Color(0xff486581);
  static Color backgroundColorAppBar = const Color(0xff829AB1);
  static Color containerColor = const Color(0xffF0F4F8);
  static Color container1Color = const Color(0xffBCCCDC);
  static Color buttomColor = const Color(0xff243853);

  //////////////////////////////////////////////
  
  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;
  // Background Colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);
  // Background Container Colors
  static const Color lightContainter = Color(0xFFF6F6F6);
  static Color darkContainter = Colors.white.withOpacity(0.1);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C7570);
  static const Color buttonDisabled = Color(0xFFC4C4C4);
  // Border Colors
  static const Color borderPrimary = Color(0xFFD90909);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);
  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color canvasColor = Color(0xFFFFFFFF);
}
