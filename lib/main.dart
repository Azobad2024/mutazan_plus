import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart'; // استيراد GetX
import 'package:mutazan_plus/view/Company.dart';
import 'package:mutazan_plus/view/Home.dart';
import 'package:mutazan_plus/view/Bills.dart';
import 'package:mutazan_plus/view/Login.dart';
import 'package:mutazan_plus/view/profile_page.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'controler/Router.dart';
import 'controler/language_controller.dart';
import 'helpers/permissions_helper.dart';
import 'languages/translations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/company_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionsHelper.requestPermissions();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  Hive.registerAdapter(CompanyAdapter());
  await Hive.openBox<Company>('companyBox');
  final languageController = Get.put(LanguageController());
  await languageController.loadSavedLanguage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Khandevane"),
      locale: Get.find<LanguageController>().isArabic.value
          ? const Locale('ar', 'AE')
          : const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      translations: AppTranslations(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'),
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      initialRoute: LoginScreenWithWelcome.routeName,
      getPages: routers,
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // تهيئة الفلاتر قبل تشغيل التطبيق
//   await PermissionsHelper.requestPermissions(); // ✅ استدعاء دالة طلب الأذونات
//   await Hive.initFlutter(); // تهيئة Hive
//   await Hive.openBox('settings'); // فتح صندوق لتخزين الإعدادات
//
//   final languageController = Get.put(LanguageController());
//   await languageController.loadSavedLanguage(); // تحميل اللغة المحفوظة
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp( // استخدام GetMaterialApp بدلاً من MaterialApp
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(fontFamily: "Khandevane"),
//       locale: Get.find<LanguageController>().isArabic.value
//           ? const Locale('ar', 'AE')
//           : const Locale('en', 'US'), // اللغة المحفوظة
//       fallbackLocale: const Locale('en', 'US'), // اللغة الاحتياطية
//       translations: AppTranslations(), // إضافة الترجمة
//
//       // إعدادات الترجمة لدعم النصوص من اليمين إلى اليسار
//       localizationsDelegates: const [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const [
//         Locale('ar', 'AE'), // اللغة العربية
//       ],
//       builder: (context, child) {
//         return Directionality(
//           textDirection: TextDirection.rtl, // تعيين اتجاه النصوص
//           child: child!,
//         );
//       },
//       // home: LoginScreenWithWelcome(),//Company(), InvoicesScreen(),ProfilePage1(),
//       // routes: {
//       //   "/Home": (context) => Home(),
//       //   "/Company": (context) => Company(),
//       //   "/Profile": (context) => ProfilePage1(),
//       //
//       // },
//       initialRoute: LoginScreenWithWelcome.routeName, // الصفحة الأولى
//       getPages: routers, // استخدام GetX للتنقل
//     );
//   }
// }


// void permissionRequest() async {
//   var status = await Permission.camera.status;
//   if(!status.isGranted) {
//     await Permission.camera.request();
//   }
//   var status1 = await Permission.storage.status;
//   if(!status1.isGranted) {
//     await Permission.storage.request();
//   }
//   var status2 = await Permission.manageExternalStorage.status;
//   if(!status2.isGranted) {
//     await Permission.manageExternalStorage.request();
//   }
// }