import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';

/// دالة مخصصة لعرض SnackBar بشكل جميل في أعلى الشاشة
void showTopSnackBar(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating, // يطفو على الشاشة
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8, // من الأعلى + المساحة العلوية للنظام
        left: 16,
        right: 16,
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16), // الحشوة داخل الـ SnackBar
      backgroundColor:
          (backgroundColor ?? AppColors.error).withOpacity(0.9), // اللون مع شفافية
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // الحواف الدائرية
      ),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      duration: duration,
    ),
  );
}
