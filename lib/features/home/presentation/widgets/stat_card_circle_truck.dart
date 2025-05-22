import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';

class StatCard1 extends StatelessWidget {
  final String assetIcon;
  final String value;
  final Color color;
  final double progress;

  const StatCard1({
    super.key,
    required this.assetIcon,
    required this.value,
    required this.color,
    this.progress = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // أحجام مرنة
    final circleDiameter = ResponsiveValue<double>(
      context,
      defaultValue: 80,
      conditionalValues: const [
        Condition.largerThan(name: MOBILE, value: 100),
        Condition.largerThan(name: TABLET, value: 120),
      ],
    ).value;
    final strokeWidth = circleDiameter * 0.05;
    final avatarR = circleDiameter * 0.43;
    final iconSize = circleDiameter * 0.55;
    final spacing = ResponsiveValue<double>(
      context,
      defaultValue: 8,
      conditionalValues: const [
        Condition.largerThan(name: TABLET, value: 12),
      ],
    ).value;
    final fontSize = ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: const [
        Condition.largerThan(name: TABLET, value: 18),
      ],
    ).value;

    // الخلفيات بحسب الثيم
    final outerBg = isDark
        ? AppColors.backgroundColor      // اللون المطلوب في الداكن
        : theme.scaffoldBackgroundColor; // أو أي لون فاتح في الـ Light
    final avatarBg = outerBg; // نفس اللون داخل الدائرة

    // لون الأيقونة
    final iconColor = isDark ? Colors.white : null;

    return Container(
      padding: EdgeInsets.all(spacing),
      // إذا أردت خلفية كاملة للبطاقة:
      decoration: BoxDecoration(
        color: outerBg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(1, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // الشعار الدائري مع المؤشر
          Container(
            width: circleDiameter + 8,
            height: circleDiameter + 8,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: circleDiameter,
                  height: circleDiameter,
                  child: CircularProgressIndicator(
                    value: progress,
                    color: color,
                    backgroundColor: theme.dividerColor,
                    strokeWidth: strokeWidth,
                  ),
                ),
                CircleAvatar(
                  radius: avatarR,
                  backgroundColor: avatarBg,
                  child: Image.asset(
                    assetIcon,
                    width: iconSize,
                    height: iconSize,
                    color: iconColor, // يصير أبيض في الداكن
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spacing),
          Text(
            value,
            style: theme.textTheme.titleMedium!
                .copyWith(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
