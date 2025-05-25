import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/features/invoice/presentation/widgets/invoicee_label.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import 'package:mutazan_plus/core/utils/app_strings.dart';

class InvoiceCard extends StatelessWidget {
  final String invoiceNumber, date, quantity, material, netWeight;
  final bool isVerified;
  final int? reportedViolation;
  final VoidCallback onTap;

  const InvoiceCard({
    super.key,
    required this.invoiceNumber,
    required this.date,
    required this.quantity,
    required this.material,
    required this.netWeight,
    required this.isVerified,
    this.reportedViolation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // تحديد ألوان الحالة
    final successColor = AppColors.success;
    final errorColor = theme.colorScheme.error;
    final defaultColor = AppColors.offWhite;
    final borderColor = isVerified
        ? successColor
        : (reportedViolation != null ? errorColor : defaultColor);
    final statusIcon = isVerified
        ? Icons.verified
        : (reportedViolation != null ? Icons.report : null);

    // مسافات ريسبونسيف
    final hMargin = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: const [
        responsive.Condition.largerThan(name: responsive.MOBILE, value: 24),
        responsive.Condition.largerThan(name: responsive.TABLET, value: 32),
      ],
    ).value;
    final vPadding = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 12,
      conditionalValues: const [
        responsive.Condition.largerThan(name: responsive.MOBILE, value: 16),
      ],
    ).value;
    final iconSize = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 28,
      conditionalValues: const [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 32),
      ],
    ).value;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        // نحدد شكل البطاقة مع حدود Side BorderSide
        color: theme.cardColor,
        margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: vPadding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: borderColor, width: 2),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(vPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // رأس البطاقة: أيقونة + فاصل + أيقونة الحالة
              Row(
                children: [
                  Icon(
                    Icons.menu_book,
                    color: isVerified ? successColor : theme.dividerColor,
                    size: iconSize,
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Container(height: 1, color: theme.dividerColor)),
                  if (statusIcon != null)
                    Icon(statusIcon, color: borderColor, size: iconSize),
                ],
              ),

              SizedBox(height: vPadding),

              // الصف الأول من البيانات
              Row(
                children: [
                  Expanded(
                    child: InvoiceLabel(
                      title: AppStrings.invoiceNumber.tr,
                      value: invoiceNumber,
                      prefixYear: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InvoiceLabel(
                      title: AppStrings.quantity.tr,
                      value: quantity,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InvoiceLabel(
                      title: AppStrings.date.tr,
                      value: date,
                      // isDate: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: vPadding),

              // الصف الثاني من البيانات
              Row(
                children: [
                  Expanded(
                    child: InvoiceLabel(
                      title: AppStrings.netWeight.tr,
                      value: 'طن/ $netWeight ',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InvoiceLabel(
                      title: AppStrings.material.tr,
                      value: material,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
