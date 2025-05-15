import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/utils/app_text_styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    bool isOnBoardingVisited =
        getIt<CacheHelper>().getData(key: "isOnBoardingVisited") ?? false;
    if (isOnBoardingVisited == true) {
      delayedNavigate(context, "/signIn");
    } else {
      delayedNavigate(context, "/onBoarding");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppStrings.appName,
          style: CustomTextStyles.pacifico400style64,
        ),
      ),
    );
  }
}

void delayedNavigate(context, path) {
  Future.delayed(const Duration(seconds: 2), () {
    customReplacementNavigate(context, path);
  });
}
