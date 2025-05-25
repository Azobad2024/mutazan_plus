import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class InvoiceLabel extends StatelessWidget {
  final String title;
  final String value;
  final bool isDate;
  final bool prefixYear;

  const InvoiceLabel({
    super.key,
    required this.title,
    required this.value,
    this.isDate = false,
    this.prefixYear = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // تنسيق القيمة وترقيمها
    final raw = value.replaceAll(',', '.');
    final parsed = double.tryParse(raw);
    String formatted;
    if (parsed != null) {
      formatted = parsed == parsed.truncateToDouble()
          ? parsed.toInt().toString()
          : parsed.toStringAsFixed(2);
    } else {
      formatted = value;
    }
    // if (prefixYear) formatted = '${DateTime.now()}$formatted';
    final display =
        formatted.length > 10 ? '${formatted.substring(0, 10)}  ...' : formatted;

    // ريسبونسيف للأحجام
    final vPad = ResponsiveValue<double>(context,
        defaultValue: 4,
        conditionalValues: const [
          Condition.largerThan(name: MOBILE, value: 6),
          Condition.largerThan(name: TABLET, value: 8),
        ]).value;
    final titleSize = ResponsiveValue<double>(context,
        defaultValue: 12,
        conditionalValues: const [
          Condition.largerThan(name: TABLET, value: 14),
        ]).value;
    final valueSize = ResponsiveValue<double>(context,
        defaultValue: 16,
        conditionalValues: const [
          Condition.largerThan(name: TABLET, value: 18),
        ]).value;

    return Container(
      padding: EdgeInsets.all(vPad),
      decoration: BoxDecoration(
        color: isDark ? theme.canvasColor : theme.cardColor,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: theme.textTheme.bodySmall!
                  .copyWith(fontSize: titleSize, color: theme.hintColor)),
          SizedBox(height: vPad / 2),
          Text(display,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: valueSize,
                fontWeight: FontWeight.bold,
                color: isDate
                    ? theme.colorScheme.primary
                    : theme.textTheme.bodyLarge!.color,
              )),
        ],
      ),
    );
  }
}