import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/routes/app_router.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/core/utils/theme/theme.dart';
import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:mutazan_plus/features/invoice/domain/usecases/get_invoices.dart';
import 'package:mutazan_plus/features/invoice/domain/usecases/verify_invoice.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:mutazan_plus/features/theme/bloc/theme_bloc.dart';
import 'package:mutazan_plus/features/controler/language_controller.dart';
import 'package:mutazan_plus/features/helpers/permissions_helper.dart';
import 'package:mutazan_plus/features/languages/translations.dart';
import 'package:responsive_framework/responsive_framework.dart';

/*************  ✨ Windsurf Command ⭐  *************/
/// The main entry point of the application.
///
/// This function initializes necessary services and configurations for the app.
/// It ensures Flutter bindings are initialized and sets up the service locator
/// for dependency injection. It initializes the cache and requests necessary
/// permissions. Hive is initialized for local data storage, and the saved 
/// language and theme settings are loaded. The app is then started by running
/// the `MyApp` widget wrapped with multiple BlocProviders for state management.

/*******  8827e23e-b05b-4576-b962-13b9c5222af4  *******/
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
        
        BlocProvider<NavCubit>(
          create: (_) => NavCubit(),
        ),
        BlocProvider<CompanyCubit>.value(
            value: getIt<CompanyCubit>()..fetchCompanies()),
        BlocProvider<InvoiceCubit>.value(
            value: getIt<InvoiceCubit>()..fetchInvoices(ApiKey.xSchema)),
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
          themeMode: state is DarkThemeState ? ThemeMode.dark : ThemeMode.light,

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
