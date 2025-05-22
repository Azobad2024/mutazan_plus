import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/features/invoice/presentation/widgets/invoicee_label.dart';

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
    Color borderColor = Colors.blueGrey;
    Widget statusWidget = const SizedBox.shrink();

    if (isVerified) {
      borderColor = Colors.green;
      statusWidget = const Icon(Icons.verified, color: Colors.green, size: 28);
    } else if (reportedViolation != null) {
      borderColor = Colors.red;
      statusWidget = const Icon(Icons.report, color: Colors.red, size: 28);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child:
                      Icon(Icons.menu_book, color: Colors.blueGrey, size: 28),
                ),
                Expanded(child: Container(height: 1, color: Colors.blueGrey)),
                statusWidget,
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.invoiceNumber.tr,
                        value: invoiceNumber,
                        prefixYear: true, )),
                const SizedBox(width: 8),
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.quantity.tr, value: quantity)),
                const SizedBox(width: 8),
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.date.tr, value: date, isDate: true)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.netWeight.tr, value: netWeight)),
                const SizedBox(width: 8),
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.material.tr, value: material)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
