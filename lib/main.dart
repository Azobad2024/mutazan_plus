import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/routes/app_router.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
import 'features/controler/language_controller.dart';
import 'features/helpers/permissions_helper.dart';
import 'features/languages/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<CacheHelper>().init();
  await PermissionsHelper.requestPermissions();
  await initHive();

  final languageController = Get.put(LanguageController());
  await languageController.loadSavedLanguage();

  runApp( BlocProvider<CompanyCubit>(
      create: (_) => getIt<CompanyCubit>()..fetchCompanies(),
      child: const MyApp(),
    ),);
}

Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
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
      supportedLocales: const [Locale('ar', 'AE')],
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
              // ربط GoRouter
        routeInformationParser:    router.routeInformationParser,
        routerDelegate:           router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      //routerConfig: router,
      //  initialRoute: LoginScreenWithWelcome.routeName,
      //  getPages: AppRoutes.routes,
    );
  }
}
