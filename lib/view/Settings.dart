import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controler/language_controller.dart';
import 'Login.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr), // استخدام الترجمة
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text('language'.tr), // استخدام الترجمة
              trailing: Obx(() => DropdownButton<bool>(
                value: languageController.isArabic.value,
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text('العربية'),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text('English'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    languageController.changeLanguage(value ? AppLanguage.arabic : AppLanguage.english);
                  }
                },
              )),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text('theme'.tr), // استخدام الترجمة
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // إضافة وظيفة تغيير المظهر
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: Text('notifications'.tr), // استخدام الترجمة
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // إضافة وظيفة إعدادات الإشعارات
              },
            ),
          ),
          const SizedBox(height: 20), // مسافة قبل زر تسجيل الخروج
          Card(
            color: Colors.redAccent, // لون مميز لتسجيل الخروج
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text(
                'logout'.tr, // استخدام الترجمة
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // توجيه المستخدم إلى شاشة تسجيل الدخول وإزالة صفحة الإعدادات من المكدس
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreenWithWelcome()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}