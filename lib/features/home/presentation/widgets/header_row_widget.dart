import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';

class HeaderRowWidget extends StatelessWidget {
  const HeaderRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.containerColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // لون الظل مع شفافية
            spreadRadius:2,
            blurRadius: 16,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderCard(title: "companies".tr), // استخدام الترجمة
          Container(
            width: 1,
            height: 40,
            color: AppColors.backgroundColor,
          ),
          HeaderCard(title: "status".tr), // استخدام الترجمة
        ],
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  final String title;

  const HeaderCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.container1Color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
