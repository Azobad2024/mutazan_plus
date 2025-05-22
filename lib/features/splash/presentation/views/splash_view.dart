import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // تأخير صغير قبل التنقل
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final visited = getIt<CacheHelper>().getData(key: "isOnBoardingVisited") ?? false;
      delayedNavigate(context, visited ? "/signIn" : "/onBoarding");
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // حجم الخطّ يتغيّر بناءً على عرض الشاشة
    final fontSize = ResponsiveValue<double>(
      context,
      defaultValue: 48,
      conditionalValues: const [
        Condition.largerThan(name: MOBILE, value: 64),
        Condition.largerThan(name: TABLET, value: 80),
      ],
    ).value;

    return Scaffold(
      // خلفية الشاشة من الثيم
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Text(
          AppStrings.appName,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontSize: fontSize,
            fontFamily: "Khandevane",
            color: isDark ? AppColors.offWhite : AppColors.black,
          ),
        ),
      ),
    );
  }
}

void delayedNavigate(BuildContext context, String path) {
  Future.delayed(const Duration(seconds: 2), () {
    customReplacementNavigate(context, path);
  });
}
