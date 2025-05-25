import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';

class InvoicesHeader extends StatelessWidget {
  final int count;

  const InvoicesHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final hPad = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.MOBILE, value: 24),
        responsive.Condition.largerThan(name: responsive.TABLET, value: 32),
      ],
    ).value;
    final vPad = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 12,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 16),
      ],
    ).value;

    final iconSize = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 28,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 32),
      ],
    ).value;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: isDark ? theme.canvasColor : AppColors.containerColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.numberOfInvoices.tr,
                style: theme.textTheme.bodySmall!
                    .copyWith(color: theme.textTheme.bodySmall!.color),
              ),
              SizedBox(height: vPad / 2),
              Text(
                '$count',
                style: theme.textTheme.headlineMedium!
                    .copyWith(color: AppColors.darkGrey),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.report,
              color: theme.colorScheme.error,
              size: iconSize,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
