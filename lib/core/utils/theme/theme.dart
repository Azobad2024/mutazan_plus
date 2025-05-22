import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/theme/custom_themes/texts_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Khandevane',
    brightness: Brightness.light,
    
    // الألوان الرئيسية
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    canvasColor: AppColors.offWhite,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.deepBrown,
      error: AppColors.error,
      background: AppColors.primaryBackground,
    ),

    // شريط التطبيقات
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColorAppBar,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textWhite),
      titleTextStyle: TextStyle(
        color: AppColors.textWhite,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    // نافذة التنبيهات (SnackBar)
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.deepGrey.withOpacity(0.85),
      contentTextStyle: TextStyle(color: AppColors.textWhite),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // margin يتم تحديده عند الاستدعاء ليتناسب مع الـ SafeArea
    ),

    // تصميم البطاقات
    cardTheme: CardTheme(
      color: AppColors.containerColor,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    // تصميم أزرار التطبيق الافتراضية
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // تصميم شريط التنقل السفلي
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.canvasColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.deepGrey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    // تحسينات عامة
    textTheme: TxtTheme.lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Khandevane',
    brightness: Brightness.dark,
    
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.dark,
    canvasColor: AppColors.darkContainter,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.deepBrown,
      error: AppColors.error,
      background: AppColors.dark,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColorAppBar,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textWhite),
      titleTextStyle: TextStyle(
        color: AppColors.textWhite,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.deepGrey.withOpacity(0.85),
      contentTextStyle: TextStyle(color: AppColors.textWhite),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    cardTheme: CardTheme(
      color: AppColors.darkContainter,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.canvasColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.darkerGrey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    textTheme: TxtTheme.darkTextTheme,
  );
}
