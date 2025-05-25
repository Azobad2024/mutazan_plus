// lib/features/home/presentation/widgets/footer_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    // أحجام مرنة
    final verticalPadding = mq.height * 0.02;  // ~16px على شاشة 800px
    final horizontalSpacing = mq.width * 0.02; // ~8px على شاشة 400px
    final fontSize = mq.width * 0.05;          // ~20px على شاشة 400px
    final iconSize = mq.width * 0.06;          // ~24px على شاشة 400px

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.footerText.tr,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
          SizedBox(width: horizontalSpacing),
          Icon(
            Icons.check_box,
            color: AppColors.success,
            size: iconSize,
          ),
        ],
      ),
    );
  }
}
