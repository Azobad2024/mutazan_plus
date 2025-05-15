import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'footerText'.tr, // استخدام الترجمة
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.check_box,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}