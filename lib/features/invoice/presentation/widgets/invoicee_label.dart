import 'package:flutter/material.dart';

class InvoiceLabel extends StatelessWidget {
  final String title;
  final String value;
  final bool isDate;
  final bool prefixYear;   // ← الخيار الجديد
  const InvoiceLabel({
    super.key,
    required this.title,
    required this.value,
    this.isDate = false,
    this.prefixYear = false, // افتراضيًا لا يضيف العام
  });

  @override
  Widget build(BuildContext context) {
    // 1. حاول تحويل النص إلى رقم
    final raw = value.replaceAll(',', '.');
    final parsed = double.tryParse(raw);

    String formattedValue;
    if (parsed != null) {
      // إذا عدد صحيح → بلا فاصلة، وإلا بخانتين عشريتين
      if (parsed == parsed.truncateToDouble()) {
        formattedValue = parsed.toInt().toString();
      } else {
        formattedValue = parsed.toStringAsFixed(2);
      }
    } else {
      formattedValue = value;
    }

    // 2. إذا طلبنا إضافة العام، نلصقه في البداية
    if (prefixYear) {
      final year = DateTime.now().year.toString(); // 2025
      formattedValue = '$year$formattedValue';
    }

    // 3. قصّ النص الطويل
    final displayValue = formattedValue.length > 15
        ? '${formattedValue.substring(0, 15)}...'
        : formattedValue;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            displayValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDate ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
