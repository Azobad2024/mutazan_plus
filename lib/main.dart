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
import 'helpers/permissions_helper.dart';
import 'languages/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تهيئة الفلاتر قبل تشغيل التطبيق
  await PermissionsHelper.requestPermissions(); // ✅ استدعاء دالة طلب الأذونات
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // استخدام GetMaterialApp بدلاً من MaterialApp
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Khandevane"),
      locale: const Locale('ar', 'AE'),
      fallbackLocale: const Locale('ar', 'AE'), // اللغة الافتراضية في حالة عدم توفر الترجمة
      translations: AppTranslations(), // إضافة الترجمة

      // إعدادات الترجمة لدعم النصوص من اليمين إلى اليسار
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // اللغة العربية
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // تعيين اتجاه النصوص
          child: child!,
        );
      },
      // home: LoginScreenWithWelcome(),//Company(), InvoicesScreen(),ProfilePage1(),
      // routes: {
      //   "/Home": (context) => Home(),
      //   "/Company": (context) => Company(),
      //   "/Profile": (context) => ProfilePage1(),
      //
      // },
      initialRoute: LoginScreenWithWelcome.routeName, // الصفحة الأولى
      getPages: routers, // استخدام GetX للتنقل
    );
  }
}


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