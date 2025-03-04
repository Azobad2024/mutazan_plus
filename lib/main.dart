import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mutazan_plus/view/Company.dart';
import 'package:mutazan_plus/view/Home.dart';
import 'package:mutazan_plus/view/Bills.dart';
import 'package:mutazan_plus/view/Login.dart';
import 'package:mutazan_plus/view/profile_page.dart';

import 'controler/Router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Khandevane"
      ),
      // تعيين اللغة إلى العربية
      locale: Locale('ar', 'AE'),
      // تحديد إعدادات الترجمة لدعم النصوص من اليمين إلى اليسار
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
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
      initialRoute: LoginScreenWithWelcome.routeName, // تأكد من أن `Home.routeName` معرف
      routes: routers, // استخدام `routers` من ملف المسارات
    );
  }
}
