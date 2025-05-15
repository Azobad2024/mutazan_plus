import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mutazan_plus/core/utils/app_assets.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/utils/app_text_styles.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: BoxDecoration(color: AppColors.container1Color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            AppStrings.appName,
            style: CustomTextStyles.pacifico700style32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // SvgPicture.asset(Assets.imagesVector3),
              // SvgPicture.asset(Assets.imagesHarbor1),
              SvgPicture.asset(Assets.imagesVector2),
              SvgPicture.asset(Assets.imagesVector1),
            ],
          ),
        ],
      ),
    );
  }
}
