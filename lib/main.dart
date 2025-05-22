import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/routes/app_router.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/core/utils/theme/theme.dart';
import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:mutazan_plus/features/theme/bloc/theme_bloc.dart';
import 'package:mutazan_plus/features/controler/language_controller.dart';
import 'package:mutazan_plus/features/helpers/permissions_helper.dart';
import 'package:mutazan_plus/features/languages/translations.dart';
import 'package:responsive_framework/responsive_framework.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🛠 إعداد الـ service locator
  setupServiceLocator();

  // 🗄 تهيئة الكاش
  final cache = getIt<CacheHelper>()..init();

  // 🎯 صلاحيات وأذونات
  await PermissionsHelper.requestPermissions();

  // 📦 تهيئة Hive
  await Hive.initFlutter();
  await Hive.openBox('settings');

  // 🌐 إعداد اللغة
  final languageController = Get.put(LanguageController());
  await languageController.loadSavedLanguage();

  // 👷 إنشاء ThemeBloc مع قراءة الوضع المحفوظ
  final bool savedDarkMode =
      (cache.getData(key: 'isDarkMode') as bool?) ?? false;
  final themeBloc = ThemeBloc(cache)
    ..add(ChangeThemeEvent(isDark: savedDarkMode));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>.value(value: themeBloc),
        BlocProvider<CompanyCubit>(
          create: (_) => getIt<CompanyCubit>()..fetchCompanies(),
        ),
        BlocProvider<NavCubit>(
          create: (_) => NavCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          // ربط الثيمات المحسّنة
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              state is DarkThemeState ? ThemeMode.dark : ThemeMode.light,

          // إعدادات اللغة والمحليّات
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
          supportedLocales: const [Locale('ar', 'AE'), Locale('en', 'US')],

          // responsive + rtl
          builder: (context, child) {
            final rtlChild = Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
            return ResponsiveBreakpoints.builder(
              child: BouncingScrollWrapper.builder(context, rtlChild),
              breakpoints: const [
                Breakpoint(start: 0, end: 450, name: MOBILE),
                Breakpoint(start: 451, end: 800, name: TABLET),
                Breakpoint(start: 801, end: 1000, name: DESKTOP),
                Breakpoint(start: 1001, end: double.infinity, name: 'XL'),
              ],
            );
          },

          // مسارات التطبيق
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
// import 'package:mutazan_plus/core/routes/app_router.dart';
// import 'package:mutazan_plus/core/services/services_locator.dart';
// import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
// import 'package:responsive_framework/responsive_framework.dart';
// import 'features/controler/language_controller.dart';
// import 'features/helpers/permissions_helper.dart';
// import 'features/languages/translations.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   setupServiceLocator();
//   await getIt<CacheHelper>().init();
//   await PermissionsHelper.requestPermissions();
//   await initHive();

//   final languageController = Get.put(LanguageController());
//   await languageController.loadSavedLanguage();

//   runApp( BlocProvider<CompanyCubit>(
//       create: (_) => getIt<CompanyCubit>()..fetchCompanies(),
//       child: const MyApp(),
//     ),);
// }

// Future<void> initHive() async {
//   await Hive.initFlutter();
//   await Hive.openBox('settings');
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       // themeMode: ThemeMode.system,
//       //   theme: AppTheme.lightTheme,
//       //   darkTheme: AppTheme.darkTheme,
//       theme: ThemeData(fontFamily: "Khandevane"),
//       locale: Get.find<LanguageController>().isArabic.value
//           ? const Locale('ar', 'AE')
//           : const Locale('en', 'US'),
//       fallbackLocale: const Locale('en', 'US'),
//       translations: AppTranslations(),
//       localizationsDelegates: const [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const [Locale('ar', 'AE')],
//       builder: (context, child) {
//         // أولاً Directionality كما كان
//         final rtlChild = Directionality(
//           textDirection: TextDirection.rtl,
//           child: child!,
//         );
//         // ثم نلفّه بـ ResponsiveWrapper
//         return ResponsiveWrapper.builder(
//           ClampingScrollWrapper.builder(context, rtlChild),
//           // يمكنك تعديل القيم حسب احتياجك:
//           maxWidth: 1200,
//           minWidth: 450,
//           defaultScale: true,
//           breakpoints: [
//             // لاحظ أننا نستخدم ResponsiveBreakpoint.resize وليس resize وحسب
//             ResponsiveBreakpoint.resize(450, name: MOBILE),
//             ResponsiveBreakpoint.autoScale(800, name: TABLET),
//             ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
//           ],
//         );
//       },
//               // ربط GoRouter
//         routeInformationParser:    router.routeInformationParser,
//         routerDelegate:           router.routerDelegate,
//         routeInformationProvider: router.routeInformationProvider,
//       //routerConfig: router,
//       //  initialRoute: LoginScreenWithWelcome.routeName,
//       //  getPages: AppRoutes.routes,
//     );
//   }
// }
