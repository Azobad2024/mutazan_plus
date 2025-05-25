import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;

    // حشوة عمودية ريّسبونسيف
    final verticalPadding = ResponsiveValue<double>(
      context,
      defaultValue: 14,
      conditionalValues: const [
        Condition.largerThan(name: MOBILE, value: 18),
        Condition.largerThan(name: TABLET, value: 24),
      ],
    ).value!;

    // حجم خط ريّسبونسيف
    final fontSize = ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: const [
        Condition.largerThan(name: MOBILE, value: 18),
        Condition.largerThan(name: TABLET, value: 20),
      ],
    ).value!;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(2, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: verticalPadding * 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0, // ظلّنا مُعلَن خارجيًا
        ),
        child: Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            color: onPrimary,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
