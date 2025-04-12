import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Util/language_service.dart';

enum AppLanguage { arabic, english }

class LanguageController extends GetxController {
  var isArabic = true.obs;

  AppLanguage get currentLanguage => isArabic.value ? AppLanguage.arabic : AppLanguage.english;

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  Future<void> loadSavedLanguage() async {
    final savedLanguage = await LanguageService.getLanguage();
    final languageCode = savedLanguage ?? 'ar';

    isArabic.value = languageCode == 'ar';
    Get.updateLocale(Locale(languageCode));
  }

  Future<void> changeLanguage(AppLanguage language) async {
    isArabic.value = language == AppLanguage.arabic;
    final languageCode = isArabic.value ? 'ar' : 'en';
    Get.updateLocale(Locale(languageCode));
    await LanguageService.saveLanguage(languageCode);
  }
}



// import 'dart:ui';
//
// import 'package:get/get.dart';
//
// import '../Util/language_service.dart';
//
// class LanguageController extends GetxController {
//   var isArabic = true.obs; // اللغة العربية هي الافتراضية
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadSavedLanguage();
//   }
//
//   // تحميل اللغة المحفوظة
//   Future<void> loadSavedLanguage() async {
//     final savedLanguage = await LanguageService.getLanguage();
//     if (savedLanguage != null) {
//       isArabic.value = savedLanguage == 'ar';
//       Get.updateLocale(Locale(savedLanguage));
//     }
//   }
//
//   void changeLanguage(bool isArabicSelected) async {
//     isArabic.value = isArabicSelected;
//     final languageCode = isArabicSelected ? 'ar' : 'en';
//     Get.updateLocale(Locale(languageCode));
//     await LanguageService.saveLanguage(languageCode); // حفظ اللغة
//   }
// }