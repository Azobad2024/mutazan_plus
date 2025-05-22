import 'package:flutter/material.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/stat_card_circle_truck.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';

class StatsRowWidget extends StatelessWidget {
  const StatsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // أحجام مرنة
    final containerPad = ResponsiveValue<double>(
      context,
      defaultValue: 8,
      conditionalValues: [
        Condition.largerThan(name: MOBILE, value: 12),
        Condition.largerThan(name: TABLET, value: 16),
      ],
    ).value;
    final cardSpacing = ResponsiveValue<double>(
      context,
      defaultValue: 12,
      conditionalValues: [
        Condition.largerThan(name: TABLET, value: 24),
      ],
    ).value;
    final dividerHeight = ResponsiveValue<double>(
      context,
      defaultValue: 80,
      conditionalValues: [
        Condition.largerThan(name: TABLET, value: 120),
      ],
    ).value;

    final theme = Theme.of(context);

    return Card(
      // يستعين تلقائياً بــ CardTheme من AppTheme
      margin: EdgeInsets.symmetric(vertical: containerPad, horizontal: containerPad),
      child: Padding(
        padding: EdgeInsets.all(containerPad),
        child: Row(
          children: [
            Expanded(
              child: const StatCard1(
                assetIcon: 'assets/icons/shuttle-bus.png',
                value: "1500",
                color: AppColors.success,
              ),
            ),
            SizedBox(width: cardSpacing),
            Container(
              width: 1,
              height: dividerHeight,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: cardSpacing),
            Expanded(
              child: const StatCard1(
                assetIcon: 'assets/icons/shuttle-bus.png',
                value: "5000",
                color: AppColors.info,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
