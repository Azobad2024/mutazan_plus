import 'dart:ui';

import 'package:get/get.dart';

class LanguageController extends GetxController {
  var isArabic = true.obs; // اللغة العربية هي الافتراضية

  void changeLanguage(bool isArabicSelected) {
    isArabic.value = isArabicSelected;
    if (isArabicSelected) {
      Get.updateLocale(const Locale('ar', 'AE')); // تغيير اللغة إلى العربية
    } else {
      Get.updateLocale(const Locale('en', 'US')); // تغيير اللغة إلى الإنجليزية
    }
  }
}