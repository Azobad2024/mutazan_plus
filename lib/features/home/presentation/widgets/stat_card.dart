import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String assetIcon;
  final Color iconColor;
  final double iconRotation;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.assetIcon,
    required this.iconColor,
    required this.iconRotation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    double getResponsiveFontSize(double base) {
      if (screenWidth < 400) return base * 0.85;
      if (screenWidth > 800) return base * 1.15;
      return base;
    }

    double getResponsiveIconSize(double base) {
      if (screenWidth < 400) return base * 0.8;
      if (screenWidth > 800) return base * 1.25;
      return base;
    }

    final verticalPad = ResponsiveValue<double>(
      context,
      defaultValue: 8,
      conditionalValues: const [
        Condition.largerThan(name: MOBILE, value: 12),
        Condition.largerThan(name: TABLET, value: 16),
      ],
    ).value!;

    final horizontalPad = verticalPad;
    final iconBaseSize = 28.0;
    final iconSize = getResponsiveIconSize(iconBaseSize);

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: verticalPad),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveFontSize(14),
                    ),
                  ),
                ),
                SizedBox(width: verticalPad),
                Transform.rotate(
                  angle: iconRotation * math.pi / 180,
                  child: Image.asset(
                    assetIcon,
                    width: iconSize,
                    height: iconSize,
                    color: iconColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: verticalPad * 0.5),
            Text(
              value,
              style: theme.textTheme.headlineSmall!.copyWith(
                color: iconColor,
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveFontSize(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
