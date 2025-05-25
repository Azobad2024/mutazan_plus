import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;

class HeaderRowWidget extends StatelessWidget {
  const HeaderRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // paddings مرنة عبر ResponsiveValue
    final horizontalPadding = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 8.0,
      conditionalValues: [
        responsive.Condition.smallerThan(name: responsive.MOBILE, value: 12.0),
        responsive.Condition.largerThan(name: responsive.TABLET, value: 24.0),
      ],
    ).value;
    final verticalPadding = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 8.0,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.MOBILE, value: 12.0),
        responsive.Condition.largerThan(name: responsive.TABLET, value: 16.0),
      ],
    ).value;
    final dividerHeight = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 35.0,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 60.0),
      ],
    ).value;
    final cardHPad = horizontalPadding * 0.75;
    final cardVPad = verticalPadding * 0.75;
    final fontSize = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 14.0,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.MOBILE, value: 16.0),
        responsive.Condition.largerThan(name: responsive.TABLET, value: 18.0),
      ],
    ).value;

    final theme = Theme.of(context);
    final cardBackground = theme.cardColor;
    final highlightBackground = theme.colorScheme.primary.withOpacity(0.3);
    final dividerColor = theme.colorScheme.primary;

    return Card(
      // يستخدم CardTheme من AppTheme
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _HeaderChip(
              title: AppStrings.companies.tr,
              background: highlightBackground,
              fontSize: fontSize,
              padding: EdgeInsets.symmetric(
                horizontal: cardHPad,
                vertical: cardVPad,
              ),
            ),
            Container(
              width: 1,
              height: dividerHeight,
              color: dividerColor,
            ),
            _HeaderChip(
              title: AppStrings.status.tr,
              background: highlightBackground,
              fontSize: fontSize,
              padding: EdgeInsets.symmetric(
                horizontal: cardHPad,
                vertical: cardVPad,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  final String title;
  final Color background;
  final double fontSize;
  final EdgeInsets padding;

  const _HeaderChip({
    required this.title,
    required this.background,
    required this.fontSize,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: style.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}