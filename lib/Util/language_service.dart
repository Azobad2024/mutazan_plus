import 'package:hive_flutter/hive_flutter.dart';

class LanguageService {
  static const String _languageKey = 'language';

  // حفظ اللغة المفضلة
  static Future<void> saveLanguage(String languageCode) async {
    final box = Hive.box('settings');
    await box.put(_languageKey, languageCode);
  }

  // استرجاع اللغة المفضلة
  static Future<String?> getLanguage() async {
    final box = Hive.box('settings');
    return box.get(_languageKey);
  }
}