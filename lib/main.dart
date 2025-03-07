import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart'; // استيراد GetX
import 'package:mutazan_plus/view/Company.dart';
import 'package:mutazan_plus/view/Home.dart';
import 'package:mutazan_plus/view/Bills.dart';
import 'package:mutazan_plus/view/Login.dart';
import 'package:mutazan_plus/view/profile_page.dart';
import 'controler/Router.dart';
import 'languages/translations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp( // استخدام GetMaterialApp بدلاً من MaterialApp
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Khandevane"),
      // تعيين اللغة إلى العربية
      locale: const Locale('ar', 'AE'),
      fallbackLocale: const Locale('ar', 'AE'), // اللغة الافتراضية في حالة عدم توفر الترجمة
      translations: AppTranslations(), // إضافة الترجمة

      // تحديد إعدادات الترجمة لدعم النصوص من اليمين إلى اليسار
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // اللغة العربية
      ],
      // تحديد اتجاه النصوص افتراضياً إلى اليمين
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