import 'package:flutter/widgets.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/utils/app_text_styles.dart';
import 'package:mutazan_plus/core/widgets/custom_btn.dart';
import 'package:mutazan_plus/core/widgets/custom_elevated_button.dart';
import 'package:mutazan_plus/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:mutazan_plus/features/on_boarding/presentation/views/functions/on_boarding.dart';

class GetButtons extends StatelessWidget {
  const GetButtons({
    super.key,
    required this.currentIndex,
    required this.controller,
  });
  final int currentIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    if (currentIndex == onBoardingData.length - 1) {
      return Column(
        children: [
          CustomElevatedButton(
            text: AppStrings.loginNow,
            onPressed: () {
              onBoardingVisited();
              customReplacementNavigate(context, "/signIn");
            },
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              onBoardingVisited();
              customReplacementNavigate(context, "/signUp");
              // customReplacementNavigate(context, "/signIn");
            },
            child: Text(
              AppStrings.createAccount,
              style: CustomTextStyles.poppins300style16.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    } else {
      return CustomBtn(
        text: AppStrings.next,
        onPressed: () {
          controller.nextPage(
            duration: Duration(microseconds: 200),
            curve: Curves.bounceIn,
          );
        },
      );
    }
  }
}
