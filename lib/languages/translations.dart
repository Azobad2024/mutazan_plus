import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar_AE': {
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'theme': 'المظهر',
      'notifications': 'الإشعارات',
      'logout': 'تسجيل الخروج',

      'home': 'الرئيسية',
      'company': 'الشركات',
    },
    'en_US': {
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
      'notifications': 'Notifications',
      'logout': 'Logout',
      'home': 'Home',
      'company': 'Company',
    },
  };
}