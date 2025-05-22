import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/utils/app_text_styles.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final canvas = theme.canvasColor;            // لون الداكن
    final lightGradient = LinearGradient(
      colors: [
        AppColors.container1Color.withOpacity(0.95),
        AppColors.backgroundColor.withOpacity(0.85),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomRight,
    );

    // لو أردت أن ترجع اللون العلوي للبانر:
    final bannerTopColor = isDark ? canvas : lightGradient.colors.first;
    
    return Container(
      // اجعل البانر يمتد خلف شريط الحالة
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: isDark ? canvas : null,
        gradient: isDark ? null : lightGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveValue<double>(
            context,
            defaultValue: 24,
            conditionalValues: const [
              Condition.largerThan(name: MOBILE, value: 32),
            ],
          ).value,
          vertical: ResponsiveValue<double>(
            context,
            defaultValue: 16,
            conditionalValues: const [
              Condition.largerThan(name: MOBILE, value: 24),
            ],
          ).value,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.appName,
              style: CustomTextStyles.pacifico700style32.copyWith(
                color: isDark ? Colors.white : AppColors.offWhite,
              ),
            ),
            // const SizedBox(height: 8),
          
          ],
        ),
      ),
    );
  }
}




 // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Flexible(
            //       child: ConstrainedBox(
            //         constraints: BoxConstraints(
            //           maxWidth: ResponsiveValue<double>(
            //             context,
            //             defaultValue: 80,
            //             conditionalValues: const [
            //               Condition.largerThan(name: TABLET, value: 100),
            //             ],
            //           ).value!,
            //         ),
            //         // child: SvgPicture.asset(Assets.imagesVector2),
            //       ),
            //     ),
            //     const SizedBox(width: 16),
            //     Flexible(
            //       child: ConstrainedBox(
            //         constraints: BoxConstraints(
            //           maxWidth: ResponsiveValue<double>(
            //             context,
            //             defaultValue: 80,
            //             conditionalValues: const [
            //               Condition.largerThan(name: TABLET, value: 100),
            //             ],
            //           ).value!,
            //         ),
            //         // child: SvgPicture.asset(Assets.imagesVector1),
            //       ),
            //     ),
            //   ],
            // ),