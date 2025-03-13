import 'dart:ui';

import 'package:get/get.dart';

import '../Util/language_service.dart';

class LanguageController extends GetxController {
  var isArabic = true.obs; // اللغة العربية هي الافتراضية

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  // تحميل اللغة المحفوظة
  Future<void> loadSavedLanguage() async {
    final savedLanguage = await LanguageService.getLanguage();
    if (savedLanguage != null) {
      isArabic.value = savedLanguage == 'ar';
      Get.updateLocale(Locale(savedLanguage));
    }
  }

  void changeLanguage(bool isArabicSelected) async {
    isArabic.value = isArabicSelected;
    final languageCode = isArabicSelected ? 'ar' : 'en';
    Get.updateLocale(Locale(languageCode));
    await LanguageService.saveLanguage(languageCode); // حفظ اللغة
  }
}