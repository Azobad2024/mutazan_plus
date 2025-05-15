import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';


class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String assetIcon;
  final Color iconColor; // إضافة خاصية جديدة للون الأيقونة
  final double iconRotation; // إضافة خاصية جديدة للدوران

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.assetIcon,
    required this.iconColor, // تمرير اللون
    required this.iconRotation, // تمرير اتجاه الأيقونة
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style:  TextStyle(
                  fontSize: 16,
                  color: AppColors.backgroundColor, // اللون هنا يمكن تغييره حسب الحاجة
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              // إضافة دوران وتحكم في اللون
              Transform.rotate(
                angle: iconRotation *
                    3.14159 /
                    180, // تحويل الدوران من درجات إلى راديان
                child: Image.asset(
                  assetIcon,
                  width: 24,
                  height: 24,
                  color: iconColor, // التحكم في اللون
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style:  TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
