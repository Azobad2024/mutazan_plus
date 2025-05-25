import 'package:mutazan_plus/core/utils/app_assets.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:get/get.dart';

class OnBoardingModel {
  final String imagePath;
  final String title;
  final String subTitle;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });
}

final List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    imagePath: Assets.imagesOnBoarding1,
    title:   AppStrings.onboardingTitle1.tr,
    subTitle:AppStrings.onboardingSubtitle1.tr,
  ),
  OnBoardingModel(
    imagePath: Assets.imagesOnBoarding2,
    title:   AppStrings.onboardingTitle2.tr,
    subTitle:AppStrings.onboardingSubtitle2.tr,
  ),
  OnBoardingModel(
    imagePath: Assets.imagesOnBoarding,
    title:   AppStrings.onboardingTitle3.tr,
    subTitle:AppStrings.onboardingSubtitle3.tr,
  ),
];
