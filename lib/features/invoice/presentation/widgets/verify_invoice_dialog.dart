import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';

typedef VerifyCallback = Future<void> Function(int id);

void showVerifyInvoiceDialog({
  required BuildContext context,
  required InvoiceEntity invoice,
  required bool alreadyVerified,
  required VerifyCallback onConfirm,
}) {
  final theme = Theme.of(context);
  final primary = theme.colorScheme.secondary;
  final isDark = theme.brightness == Brightness.dark;

  if (alreadyVerified) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: isDark ? theme.canvasColor : theme.cardColor,
        title: Text(AppStrings.note.tr, style: theme.textTheme.titleMedium),
        content: Text(AppStrings.alreadyVerified.tr, style: theme.textTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.ok.tr, style: theme.textTheme.labelLarge),
          ),
        ],
      ),
    );
    return;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: isDark ? theme.canvasColor : theme.cardColor,
      title: Row(
        children: [
          Icon(Icons.verified, color: primary, size: responsive.ResponsiveValue<double>(context, defaultValue: 28, conditionalValues: [
            responsive.Condition.largerThan(name: responsive.TABLET, value: 32)
          ]).value),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppStrings.confirmInvoice.tr,
              style: theme.textTheme.titleLarge,
            ),
          ),
        ],
      ),
      content: Text(AppStrings.confirmInvoiceQuestion.tr, style: theme.textTheme.bodyMedium),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            onConfirm(invoice.id);
          },
          icon: Icon(Icons.check, color: Colors.white),
          label: Text(AppStrings.yesConfirm.tr),
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            minimumSize: Size(
              responsive.ResponsiveValue<double>(context, defaultValue: 150, conditionalValues: [
                responsive.Condition.largerThan(name: responsive.TABLET, value: 200)
              ]).value,
              responsive.ResponsiveValue<double>(context, defaultValue: 44, conditionalValues: [
                responsive.Condition.largerThan(name: responsive.TABLET, value: 56)
              ]).value,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    ),
  );
}
