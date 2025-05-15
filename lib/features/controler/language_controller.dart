import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/language_service.dart';

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
    final savedCode = await LanguageService.getLanguage() ?? 'ar';
    isArabic.value = savedCode == 'ar';
    Get.updateLocale(Locale(savedCode));
  }

   Future<void> changeLanguage(AppLanguage lang) async {
    final code = (lang == AppLanguage.arabic) ? 'ar' : 'en';
    isArabic.value = (lang == AppLanguage.arabic);
    Get.updateLocale(Locale(code));
    await LanguageService.saveLanguage(code);
  }
}
